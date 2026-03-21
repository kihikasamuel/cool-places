import PrintToPdf from './hooks/print_to_pdf.js';
import VisitorMap from './hooks/visitor_map.js';
import * as THREE from "three";
import { LiveThree, EffectsRegistry } from "live_three";

LiveThree.init(THREE)

EffectsRegistry.celestial = (scene, camera, opts, state) => {
    const mainColor = opts.color || 0x2563EB;
    const starCount = opts.count || 4000;
    const group = new THREE.Group();
    scene.add(group);

    // 1. Dynamic Starfield (3 groups for imaginary orbits)
    const starGroups = [];
    const colorObj = new THREE.Color(mainColor);

    for (let g = 0; g < 3; g++) {
        const currentCount = Math.floor(starCount / 3);
        const starGeo = new THREE.BufferGeometry();
        const starPos = new Float32Array(currentCount * 3);
        const starColors = new Float32Array(currentCount * 3);

        for (let i = 0; i < currentCount; i++) {
            starPos[i * 3] = (Math.random() - 0.5) * 150;
            starPos[i * 3 + 1] = (Math.random() - 0.5) * 150;
            starPos[i * 3 + 2] = (Math.random() - 0.5) * 150;

            const mixedColor = new THREE.Color(0xffffff).lerp(colorObj, Math.random() * 0.4);
            starColors[i * 3] = mixedColor.r;
            starColors[i * 3 + 1] = mixedColor.g;
            starColors[i * 3 + 2] = mixedColor.b;
        }

        starGeo.setAttribute('position', new THREE.BufferAttribute(starPos, 3));
        starGeo.setAttribute('color', new THREE.BufferAttribute(starColors, 3));

        const starMat = new THREE.PointsMaterial({
            size: 0.08 + (g * 0.04), // Sizes: 0.08, 0.12, 0.16
            vertexColors: true,
            transparent: true,
            opacity: 1.0,
            blending: THREE.AdditiveBlending,
            depthWrite: false
        });
        const stars = new THREE.Points(starGeo, starMat);

        stars.rotation.x = Math.random() * Math.PI;
        stars.rotation.y = Math.random() * Math.PI;
        stars.rotation.z = Math.random() * Math.PI;

        group.add(stars);
        starGroups.push(stars);
    }

    // 2. Central Planet (Realistic High-Res Core with Atmosphere & Holographic Shell)
    const planetGeo = new THREE.SphereGeometry(2.2, 64, 64);

    const baseColor = new THREE.Color(0x0a0a0a);
    const emissiveColor = new THREE.Color(mainColor).multiplyScalar(0.15);

    const planetMat = new THREE.MeshStandardMaterial({
        color: baseColor,
        emissive: emissiveColor,
        roughness: 0.2,
        metalness: 0.8
    });
    const planet = new THREE.Mesh(planetGeo, planetMat);
    group.add(planet);

    // Atmospheric Edge Glow
    const atmoGeo = new THREE.SphereGeometry(2.28, 64, 64);
    const atmoMat = new THREE.MeshPhongMaterial({
        color: mainColor,
        transparent: true,
        opacity: 0.15,
        blending: THREE.AdditiveBlending,
        side: THREE.BackSide,
        depthWrite: false
    });
    const atmosphere = new THREE.Mesh(atmoGeo, atmoMat);
    planet.add(atmosphere);

    // Core holographic wireframe shell
    const wireGeo = new THREE.SphereGeometry(2.24, 32, 32);
    const wireMat = new THREE.MeshBasicMaterial({
        color: mainColor,
        wireframe: true,
        transparent: true,
        opacity: 0.3,
        blending: THREE.AdditiveBlending,
        depthWrite: false
    });
    const wireShell = new THREE.Mesh(wireGeo, wireMat);
    planet.add(wireShell);

    // --- Surface Exploration Nodes & Arcs ---
    const markerCount = 15;
    const planetRadius = 2.23;
    const markers = [];
    const pulsarNodes = [];

    const markerGeo = new THREE.CircleGeometry(0.04, 16);
    const markerMat = new THREE.MeshBasicMaterial({
        color: mainColor,
        side: THREE.DoubleSide,
        transparent: true,
        opacity: 0.9,
        depthWrite: false
    });

    // Convert spherical coords to Cartesian
    const getCartesian = (lat, lon, radius) => {
        const phi = (90 - lat) * (Math.PI / 180);
        const theta = (lon + 180) * (Math.PI / 180);
        return new THREE.Vector3(
            -(radius * Math.sin(phi) * Math.cos(theta)),
            radius * Math.cos(phi),
            radius * Math.sin(phi) * Math.sin(theta)
        );
    };

    for (let i = 0; i < markerCount; i++) {
        const lat = (Math.random() - 0.5) * 140; // Avoid poles
        const lon = (Math.random() - 0.5) * 360;
        const pos = getCartesian(lat, lon, planetRadius);

        const marker = new THREE.Mesh(markerGeo, markerMat);
        marker.position.copy(pos);
        marker.lookAt(new THREE.Vector3(0, 0, 0));

        const glowMat = new THREE.SpriteMaterial({
            color: mainColor,
            transparent: true,
            opacity: 0.8,
            blending: THREE.AdditiveBlending,
            depthWrite: false
        });
        const glow = new THREE.Sprite(glowMat);
        glow.scale.set(0.15, 0.15, 0.15);
        glow.position.z = 0.02; // Local offset outward
        marker.add(glow);

        planet.add(marker);
        markers.push(pos.clone());
        pulsarNodes.push({ sprite: glow, phase: Math.random() * Math.PI * 2 });
    }

    // Generate Connection Arcs (Flight Paths)
    const arcCount = 12;
    const lineMat = new THREE.LineBasicMaterial({
        color: 0xffffff, // Give the arcs a distinctly bright contrast pop
        transparent: true,
        opacity: 0.25,
        depthWrite: false,
        blending: THREE.AdditiveBlending
    });

    for (let i = 0; i < arcCount; i++) {
        let startIdx = Math.floor(Math.random() * markerCount);
        let endIdx = Math.floor(Math.random() * markerCount);
        if (startIdx === endIdx) endIdx = (startIdx + 1) % markerCount;

        const startNode = markers[startIdx];
        const endNode = markers[endIdx];

        const distance = startNode.distanceTo(endNode);
        const midNode = startNode.clone().lerp(endNode, 0.5);

        // Push the curve outward proportionately to distance covered
        midNode.normalize().multiplyScalar(planetRadius + distance * 0.35);

        const curve = new THREE.QuadraticBezierCurve3(startNode, midNode, endNode);
        const points = curve.getPoints(32);
        const curveGeo = new THREE.BufferGeometry().setFromPoints(points);

        const arcLine = new THREE.Line(curveGeo, lineMat);
        planet.add(arcLine);
    }
    // --- End Surface Nodes ---

    // 3. Orbiting Realistic Moons (PBR Materials)
    const moons = new THREE.Group();
    const moonData = [];

    for (let i = 0; i < 5; i++) {
        const pivot = new THREE.Group();

        const distance = 3.2 + Math.random() * 2.5;
        const speed = (0.001 + Math.random() * 0.003) * (Math.random() > 0.5 ? 1 : -1);

        // Randomize orbit plane tilt
        pivot.rotation.x = (Math.random() - 0.5) * Math.PI;
        pivot.rotation.z = (Math.random() - 0.5) * Math.PI;

        // Visible Imaginary Orbit Ring
        const orbitCurve = new THREE.EllipseCurve(0, 0, distance, distance, 0, 2 * Math.PI, false, 0);
        const orbitPoints = orbitCurve.getPoints(64);
        const orbitGeo = new THREE.BufferGeometry().setFromPoints(orbitPoints);
        orbitGeo.rotateX(Math.PI / 2);

        const orbitMat = new THREE.LineBasicMaterial({
            color: mainColor,
            transparent: true,
            opacity: 0.2,
            depthWrite: false
        });
        const orbitLine = new THREE.Line(orbitGeo, orbitMat);
        pivot.add(orbitLine);

        // Realistic High-Fidelity Moon
        const moonRadius = 0.08 + Math.random() * 0.1;
        const moonGeo = new THREE.SphereGeometry(moonRadius, 32, 32);

        // Distort the sphere slightly for realistic non-uniformity
        moonGeo.scale(1.0, 0.9 + Math.random() * 0.2, 1.0);

        // Natural rocky color variant
        const isDark = Math.random() > 0.5;
        const moonColor = isDark ? 0x444444 : 0x888888;

        const moonMat = new THREE.MeshStandardMaterial({
            color: moonColor,
            roughness: 0.8 + Math.random() * 0.2,
            metalness: 0.1 + Math.random() * 0.3
        });
        const moon = new THREE.Mesh(moonGeo, moonMat);
        moon.position.set(distance, 0, 0);

        const moonSpinX = Math.random() * 0.05;
        const moonSpinY = Math.random() * 0.05;

        pivot.add(moon);
        moons.add(pivot);

        moonData.push({ pivot, moon, speed, spinX: moonSpinX, spinY: moonSpinY });
    }
    group.add(moons);

    // 4. Scene Lighting (Crucial for PBR Moons)
    const ambientLight = new THREE.AmbientLight(0xffffff, 0.1);
    group.add(ambientLight);

    const mainLight = new THREE.DirectionalLight(0xffffff, 1.5);
    mainLight.position.set(10, 10, 10);
    group.add(mainLight);

    const fillLight = new THREE.PointLight(mainColor, 2, 50);
    fillLight.position.set(-5, -5, -5);
    group.add(fillLight);

    // 5. Kinematic Update Loop
    let time = 0;
    return () => {
        time += 0.05;

        // Pulse exploration markers
        pulsarNodes.forEach(node => {
            const scale = 0.12 + Math.sin(time + node.phase) * 0.05;
            node.sprite.scale.set(scale, scale, scale);
            node.sprite.material.opacity = 0.5 + Math.sin(time + node.phase) * 0.4;
        });

        // Planet Core
        planet.rotation.y += 0.002;
        planet.rotation.x += 0.001;
        wireShell.rotation.y -= 0.004;
        wireShell.rotation.x += 0.002;

        // Realistic Moons
        moonData.forEach(data => {
            data.pivot.rotation.y += data.speed;
            data.moon.rotation.x += data.spinX;
            data.moon.rotation.y += data.spinY;
        });

        // Swirling Imaginary Star Orbits
        starGroups[0].rotation.y -= 0.0005;
        starGroups[1].rotation.x += 0.0004;
        starGroups[1].rotation.z += 0.0002;
        starGroups[2].rotation.y += 0.0006;
        starGroups[2].rotation.x -= 0.0003;

        // Smooth Mouse Parallax
        const targetX = state.mouse.x * 0.5;
        const targetY = state.mouse.y * 0.5;

        group.rotation.y += (targetX - group.rotation.y) * 0.05;
        group.rotation.x += (targetY - group.rotation.x) * 0.05;
    };
}

export default {
    PrintToPdf,
    VisitorMap,
    LiveThreeHook: LiveThree.Hook
}
