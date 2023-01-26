class Image < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  # Do we need has_one_base 64 attached?? or just one attached
  has_one_attached :before_photo
  has_one_base64_attached :after_photo
  # data validations - TO DO
  after_create :attach_before_photo

  # Geocoding
  geocoded_by :address # tells geocoder gem which column to use
  after_validation :geocode, if: :will_save_change_to_address? # runs geocode conversion if address saved.

  OPTIONS = ["Green trees", "Bicycles", "Bike Lanes", "Cafe", "Park", "Colour", "Pedestrians", "Snow", "Greenery", "Christmas time"]

  def attach_before_photo
    before_photo_data = URI.parse(before_photo_base_url).open
    before_photo.attach(io: before_photo_data, filename: "before_photo_#{id}.jpg")
  end

  def generate_image_variations
    # use before_photo_base_url to generate variations using api
    # Api returns json with image information (save this image to after_photo)
    # debugger

    image = MiniMagick::Image.open(before_photo_base_url)
    image.format "PNG"
    # image.resize('640x512') # only needed if other size is returned

    url = URI("https://api.stability.ai/v1alpha/generation/stable-diffusion-512-v2-1/image-to-image")
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Post.new(url)
    request["Authorization"] = ENV.fetch("STABILITY_AI_KEY")
    request["Accept"] = "application/json"

    options = {
      cfg_scale: 16,
      clip_guidance_preset: "NONE",
      height: 512,
      # sampler: "K_DPM_2_ANCESTRAL",
      samples: 1,
      seed: 0,
      step_schedule_end: 0.01,
      step_schedule_start: 0.4,
      steps: 100,
      text_prompts: [
        {
          text: self.options.join(" "),
          weight: 1
        },
        {
          text: self.custom_option,
          weight: 1
        }
      ],
      width: 512
    }

    form_data = [['init_image', image.to_blob], ['options', options.to_json]]
    request.set_form form_data, 'multipart/form-data'
    response = https.request(request)
    response.read_body
    parsed_response = JSON.parse(response.read_body)
    parsed_response["artifacts"][0]["base64"]
  end

  # Text generation method not currently in use
  # def generate_text_variations
  #   # use before_photo to generate variations using api
  #   # Api returns json with image information (save this image to after_photo)
  #   # debugger
  #   headers = {
  #     Authorization: "sk-5NLUcaVC3X6jSekE3PohI4MNklrxxsLUKImERlSt5V5SBCJg",
  #     Accept: "application/json",
  #     "Content-Type": "application/json"
  #   }

  #   body = {
  #     cfg_scale: 7,
  #     clip_guidance_preset: "FAST_BLUE",
  #     height: 512,
  #     sampler: "K_DPM_2_ANCESTRAL",
  #     samples: 1,
  #     seed: 0,
  #     steps: 20,
  #     text_prompts: [
  #       {
  #         text: "A lighthouse and many trees on a cliff",
  #         weight: 1
  #       }
  #     ],
  #     width: 512
  #   }
  #   response = HTTParty.post("https://api.stability.ai/v1alpha/generation/stable-diffusion-512-v2-1/text-to-image", body: body.to_json, headers: headers)
  #   base_64_result = response["artifacts"][0]["base64"]
  # end


end
