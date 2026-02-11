const VisitorMap = {
    mounted() {
        this.map = L.map(this.el).setView([20, 0], 2);

        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
        }).addTo(this.map);

        this.markers = [];
        this.pushEvent("get_markers", {}, (reply) => {
            this.addMarkers(reply.markers);
        });

        this.handleEvent("update_markers", ({ markers }) => {
            this.addMarkers(markers);
        });
    },

    addMarkers(markers) {
        // Clear existing markers
        this.markers.forEach(marker => this.map.removeLayer(marker));
        this.markers = [];

        markers.forEach(marker => {
            const m = L.marker([marker.lat, marker.lng])
                .addTo(this.map)
                .bindPopup(`${marker.city || 'Unknown'}, ${marker.country}<br>${new Date(marker.visited_at).toLocaleString()}`);
            this.markers.push(m);
        });
    }
};

export default VisitorMap;
