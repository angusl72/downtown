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

  OPTIONS = ["Trees", "Bicycle Lanes", "Cafes", "Parkspace", "Colour", "Pedestrians", "Snow", "Street Furniture", "Cyclists", "Greenspace", "Christmas time"]

  def attach_before_photo
    unless self.before_photo.attached?
      before_photo_data = URI.parse(before_photo_base_url).open
      before_photo.attach(io: before_photo_data, filename: "before_photo_#{id}.jpg")
    end
  end

  def generate_image_variations
    image = MiniMagick::Image.open(before_photo_base_url)
    image.format "PNG"
    # image.resize('640x512') # only needed if other size is returned

    engine = 'stable-diffusion-512-v2-1'
    form_data = [
      ['init_image', image.to_blob], # Street view image in base64 format
      ['samples', '1'], # How many images to generate
      ['width', '640'],
      ['height', '512'],
      ['init_image_mode', "IMAGE_STRENGTH"],
      ['image_strength', '0.7'], # [0..1] How much influence the init_image has on the diffusion process. Values close to 1 will yield images very similar to the init_image while values close to 0 will yield images wildly different than the init_image.
      ['cfg_scale', '17'], # [0..35] How strictly the diffusion process adheres to the prompt text (higher values keep your image closer to your prompt
      ['sampler', 'K_DPM_2_ANCESTRAL'],
      ['clip_guidance_preset', 'FAST_GREEN'],
      ['steps', '100'], # [10..150] Number of diffusion steps to run
      ['text_prompts[0][text]:', 'A photo of beautiful architectural street with great urban design '],
      ['text_prompts[0][weight]:', '0.5'], # [0..1] How much weighting the prompt will have on the image
      ['text_prompts[3][text]:', 'disfigured, impressionistic'],
      ['text_prompts[3][weight]:', '-1']
    ]

    unless self.options.empty? # This will remove the option radio checkboxes from form data if none are selected. Blanks cause API error
      form_data.append(['text_prompts[1][text]:', self.options.join(', ')])
      form_data.append(['text_prompts[1][weight]:', '1'])
    end

    unless self.custom_option.empty? # This will remove the custom options from form data if left blank. Blanks cause API error
      form_data.append(['text_prompts[2][text]:', self.custom_option])
      form_data.append(['text_prompts[2][weight]:', '1'])
    end

    url = URI("https://api.stability.ai/v1beta/generation/#{engine}/image-to-image")
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Post.new(url)
    request["Authorization"] = ENV.fetch("STABILITY_AI_KEY")
    request["Accept"] = "application/json"

    request.set_form form_data, 'multipart/form-data'
    response = https.request(request)
    response.read_body
    parsed_response = JSON.parse(response.read_body)
    parsed_response["artifacts"][0]["base64"]
  end

end
