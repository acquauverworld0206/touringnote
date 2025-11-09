function initMap() {
  const mapElement = document.getElementById('map');

  if (mapElement) {
    const latitude = parseFloat(mapElement.dataset.latitude);
    const longitude = parseFloat(mapElement.dataset.longitude);

    if (!isNaN(latitude) && !isNaN(longitude)) {
      const location = { lat: latitude, lng: longitude };

      const map = new google.maps.Map(mapElement, {
        zoom: 15,
        center: location,
      });

      new google.maps.Marker({
        position: location,
        map: map,
      });
    }
  }
}

document.addEventListener('turbo:load', initMap);