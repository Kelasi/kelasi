module MIME

  Valid_types = {"audio/mpeg" => %w(mp3),
                 "image/jpeg" => %w(jpg jpeg),
                 "text/plain" => %w(doc txt)}

  class << self

    def valid_extensions
      Valid_types.values.flatten
    end
  end
end
