import { Controller } from "@hotwired/stimulus"
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"

// Connects to data-controller="address-autocomplete"
export default class extends Controller {
  // static values = { apiKey: String }

  static targets = ['imagesContainer', 'optionsContainer', 'searchOverlayContainer', 'closeButton', 'overlay', 'body', 'address']


  connect() {
    console.log("address autocomplete stimulus controller connected")


    this.geocoder = new MapboxGeocoder({
      accessToken: "pk.eyJ1IjoiYWhtZXRtZW5ldnNlIiwiYSI6ImNsZDJ1Ymh3OTBjNHgzcm9hNTViNXdxY3AifQ.zeq7bHyIs2400GTDmJcJEw",
      types: "address,place"
    })
    this.geocoder.addTo(this.element)
    this.geocoder.on("result", event => this.#setInputValue(event))

    this.geocoder.on("result", event => console.log(event))

    this.geocoder.on("clear", () => this.#clearInputValue())

  }

  #setInputValue(event) {
    this.addressTarget.value = event.result["place_name"]
    // console.log(event.result["place_name"])
    this.searchAddress(event.result["place_name"])
    // let searchboxController = this.application.getControllerForElementAndIdentifier(this.#searchboxTarget, 'searchbox')
    // searchboxController.searchAddress(event)

  }

  #clearInputValue() {
    this.addressTarget.value = ""
  }

  disconnect() {
    this.geocoder.onRemove()
  }

  searchAddress(event) {
    console.log("hello")
    // event.preventDefault()
    console.log(this.addressTarget.value)
    console.log(this.imagesContainerTarget)

    const apiKey = 'AIzaSyDb-GlGjN3ftlq0fqbuHmzjwgNdR0P3Wow';

    const startingHeading = Math.floor(Math.random() * 91)

    //define our address
    const address = this.addressTarget.value

    //define our imagesContainer
    const imagesContainer = this.imagesContainerTarget
    //set inner HTML to nil so we don't keep appending over and over
    imagesContainer.innerHTML = ""

    //Add the address query
    const query = document.createElement('div')
    query.setAttribute("id", "address");
    query.classList.add("my-2")

    query.insertAdjacentHTML("beforeend", `<i class="fa-solid fa-location-dot"></i> ${address}`);

    //append address
    imagesContainer.appendChild(query)

    //Create street images
    const imagesSubContainer = document.createElement('div')
    imagesSubContainer.classList.add("row","d-flex","mb-3");

    const fetchStreetImage = (imageNumber, query) => {
      console.log(`fetching image - ${imageNumber}`)
      // 1 - Set Heading Based on IMG Number
      let heading = ""
      //first image always faces the address
      if (imageNumber != 0) {
        heading = `&heading=${startingHeading+90*(imageNumber - 1)}`
      }
      console.log(heading)
      //define the URL for each query
      return `https://maps.googleapis.com/maps/api/streetview?size=640x512${heading}&location=${address}&key=${apiKey}`
    }

    //Create 5 different street images
    for (const x of Array(5).keys()) {
      console.log('getting images.')
      let streetImg = document.createElement('div')
      streetImg.classList.add("col")

      streetImg.innerHTML = `
        <label for="img-${x}">
          <input id="img-${x}" type="radio" name="image[before_photo_base_url]" value="${fetchStreetImage(x, query)}">
            <img src="${fetchStreetImage(x, query)}" class="rounded img-search" alt="img-${x}">
        </label>`

      //append each image to our subcontainer
      imagesSubContainer.appendChild(streetImg)
    }

    //append street images to our container
    imagesContainer.appendChild(imagesSubContainer)

    //display the hidden searchbox overlay
    // this.searchOverlayContainerTarget.classList.remove('hidden')
    this.searchOverlayContainerTarget.classList.add('open')





    //display the hidden options
    const optionsContainer = this.optionsContainerTarget
    // this.overlayTarget.hidden = false;
    optionsContainer.classList.remove('hidden')

    document.body.style.overflow = "hidden";
  }

  closeButton(event) {
    document.body.style.overflow = "visible";
    this.overlayTarget.hidden = true
    this.searchOverlayContainerTarget.classList.remove('open')
  }

}
