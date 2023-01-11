class Image < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  # has_one_attached :before_photo
  has_one_base64_attached :after_photo
  # data validations - TO DO
  # after_create :generate_image_variations

  OPTIONS = ["Trees", "Bicycles", "Cafe", "Greenery", "Mural", "Colour", "Flowers", "Colourful Lights", "Snow"]

  def generate_image_variations
    # use before_photo to generate variations using api
    # Api returns json with image information (save this image to after_photo)
    # debugger
    image = MiniMagick::Image.open(self.before_photo)
    image.format "PNG"

    before_base64 = Base64.encode64(image.to_blob).split("\n").join

    init_image = {}
    init_image['init_image'] = before_base64

    headers = {
      Authorization: "sk-5NLUcaVC3X6jSekE3PohI4MNklrxxsLUKImERlSt5V5SBCJg",
      Accept: "image/png",
      "Content-Type" => "multipart/form-data"
    }

    options = {
      cfg_scale: 7,
      clip_guidance_preset: "FAST_BLUE",
      step_schedule_start: 0.6,
      step_schedule_end: 0.01,
      height: 512,
      width: 512,
      samples: 1,
      steps: 50,
      text_prompts: [
        {
            text: self.options.join(" "),
            weight: 1
        }
      ]
    }

    response = HTTParty.post("https://api.stability.ai/v1alpha/generation/stable-diffusion-512-v2-1/image-to-image", body: options.to_json, headers: headers, init_image: init_image)
    response.body
    raise
  end



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
