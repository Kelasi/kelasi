
Tire.configure do
  url "http://elasticsearch:9200/"
end

Tire::Model::Search.index_prefix "#{Rails.application.class.parent_name.downcase}_#{Rails.env.to_s.downcase}"

