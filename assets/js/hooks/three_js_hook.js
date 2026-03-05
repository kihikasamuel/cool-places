import * as THREE from 'three';

const ThreeJSHook = {
    mounted() {
        // 'this.el' is the DOM element the hook is attached to
        this.cleanup = createScene(this.el);
    },
    destroyed() {
        // Clean up memory when the LiveView unmounts the element
        if (this.cleanup) this.cleanup();
    },
}

function createScene(container) {
    const scene = new THREE.Scene();
    const camera = new THREE.PerspectiveCamera(75, container.clientWidth / container.clientHeight, 0.1, 2000);
    const renderer = new THREE.WebGLRenderer({ antialias: true, alpha: true });

    renderer.setSize(container.clientWidth, container.clientHeight);
    container.appendChild(renderer.domElement);

    // --- 1. Starfield Setup ---
    const starCount = 6000;
    const geometry = new THREE.BufferGeometry();
    const vertices = new Float32Array(starCount * 3);

    for (let i = 0; i < starCount * 3; i++) {
        vertices[i] = (Math.random() - 0.5) * 1000;
    }

    geometry.setAttribute('position', new THREE.BufferAttribute(vertices, 3));

    const material = new THREE.PointsMaterial({
        color: 0xffffff,
        size: 1.5,
        transparent: true,
        opacity: 0.8
    });

    const stars = new THREE.Points(geometry, material);
    scene.add(stars);


    // --- 2. 3D Text Setup (Canvas Texture) ---
    const textCanvas = document.createElement('canvas');
    // Use a high resolution for crisp text
    textCanvas.width = 2048;
    textCanvas.height = 256;
    const ctx = textCanvas.getContext('2d');

    // Transparent background
    ctx.clearRect(0, 0, textCanvas.width, textCanvas.height);

    // Style the text
    ctx.font = 'bold 80px "Segoe UI", Roboto, Helvetica, Arial, sans-serif';
    ctx.fillStyle = '#ffffff'; // White text
    ctx.textAlign = 'center';
    ctx.textBaseline = 'middle';

    // Draw the text in the exact center of the off-screen canvas
    ctx.fillText('Explore the World, One Trip at a Time', textCanvas.width / 2, textCanvas.height / 2);

    // Convert the canvas into a Three.js Texture
    const textTexture = new THREE.CanvasTexture(textCanvas);

    // Create a Sprite material (Sprites always face the camera)
    const textMaterial = new THREE.SpriteMaterial({ map: textTexture, transparent: true });
    const textSprite = new THREE.Sprite(textMaterial);

    // Scale the sprite so it fits nicely in the camera view
    // The ratio should roughly match your textCanvas width/height ratio
    textSprite.scale.set(16, 2, 1);

    // Position it slightly away from the camera
    textSprite.position.set(0, 0, -10);
    scene.add(textSprite);

    camera.position.z = 1;

    // --- 3. Animation Loop ---
    let animationId;
    function animate() {
        animationId = requestAnimationFrame(animate);

        // Rotate the stars, but leave the text stationary!
        stars.rotation.x += 0.0005;
        stars.rotation.y += 0.0005;

        // Optional: Add a subtle floating effect to the text
        textSprite.position.y = Math.sin(Date.now() * 0.001) * 0.2;

        renderer.render(scene, camera);
    }

    animate();

    // --- 4. Cleanup ---
    return () => {
        cancelAnimationFrame(animationId);

        geometry.dispose();
        material.dispose();

        // Dispose of the text texture and material too!
        textTexture.dispose();
        textMaterial.dispose();

        renderer.dispose();
        if (container.contains(renderer.domElement)) {
            container.removeChild(renderer.domElement);
        }
    };
}

export default ThreeJSHook;
