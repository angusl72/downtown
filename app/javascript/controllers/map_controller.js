import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    apiKey: String,
    allMarkers: Array,
    imageMarker: Array
  }
  connect() {
    console.log("connected to map controller")
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: 'mapbox://styles/pdunleav/cjofefl7u3j3e2sp0ylex3cyb',
      center: [this.imageMarkerValue[0].lng, this.imageMarkerValue[0].lat],
      zoom: 9,
    });
    this.#addMarkersToMap()
  }

  #addMarkersToMap() {
    this.allMarkersValue.forEach((marker) => {
      new mapboxgl.Marker()
      .setLngLat([ marker.lng, marker.lat ])
      .addTo(this.map)
    })

    this.imageMarkerValue.forEach((marker) => {
      new mapboxgl.Marker()
        .setLngLat([ marker.lng, marker.lat ])
        .addTo(this.map)
    })
  }
}
