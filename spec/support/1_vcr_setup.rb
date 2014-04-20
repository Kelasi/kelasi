
VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr'
  c.hook_into :webmock
  c.allow_http_connections_when_no_cassette = true
end

RSpec.configure do |c|
  c.around(:each) do |example|
    vcr = example.metadata[:vcr]
    vcr = {} if vcr.class == TrueClass
    name = example.metadata[:full_description]
    if vcr
      VCR.use_cassette(name, vcr) {example.call}
    else
      example.call
    end
  end
end

