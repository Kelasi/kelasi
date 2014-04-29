module CarrierWave
  module MiniMagick
    def quality(percentage)
      manipulate! do |img|
        img.quality(percentage.to_s)
        img = yield(img) if block_given?
        img
      end
    end
    def get_quality
      file_path = self.file.file
      img = ::MiniMagick::Image.open(file_path)
      img["%Q"].to_i
    end
  end
end
