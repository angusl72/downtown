import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['addressQuery', 'imagesContainer', 'optionsContainer']

  connect() {
    console.log("searchbox stimulus controller connected")
  }

  searchAddress(event) {
    event.preventDefault()
    console.log(this.addressQueryTarget.value)

    const apiKey = 'test';
    const startingHeading = Math.floor(Math.random() * 91)

    //define our address
    const address = this.addressQueryTarget.value

    //define our imagesContainer
    const imagesContainer = this.imagesContainerTarget
    //set inner HTML to nil so we don't keep appending over and over
    imagesContainer.innerHTML = ""

    //Add the address query
    const query = document.createElement('div')
    query.setAttribute("id", "addressQuery");
    query.classList.add("my-2")

    query.textContent = `📍 ${address}`

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
      return `https://maps.googleapis.com/maps/api/streetview?size=640x400${heading}&location=${address}&key=${apiKey}`
    }

    //Create 5 different street images
    for (const x of Array(5).keys()) {
      console.log('getting images.')
      let streetImg = document.createElement('div')
      streetImg.classList.add("col")
      // streetImg.setAttribute("id", `img-${x}`)
      streetImg.classList.add("col")

      streetImg.innerHTML = `
        <label for="img-${x}">
          <input id="img-${x}" type="radio" name="img-selection" value="img-${x}">
            <img src="${fetchStreetImage(x, query)}" class="rounded img-search" alt="img-${x}">
        </label>`

      //append each image to our subcontainer
      imagesSubContainer.appendChild(streetImg)
    }

    //append street images to our container
    imagesContainer.appendChild(imagesSubContainer)

    //display the hidden options
    const optionsContainer = this.optionsContainerTarget
    optionsContainer.classList.remove('hidden')
  }
}
