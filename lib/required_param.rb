def required(name)
  raise ArgumentError.new("#{name} is required")
end
