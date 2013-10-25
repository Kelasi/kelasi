# Define random prefix to prevent indexes from clashing
Tire::Model::Search.index_prefix "#{Rails.application.class.parent_name.downcase}_#{Rails.env.to_s.downcase}_#{rand(1000000)}"

# In order to know what all of the models are, we need to load all of them
Dir["#{Rails.root}/app/models/**/*.rb"].each do |model|
  load model
end

# Refresh Elastic Search indexes
# NOTE: relies on all app/models/**/*.rb to be loaded
models = ActiveRecord::Base.subclasses.collect { |type| type.name }.sort
models.each do |klass|
  # make sure that the current model is using tire
  if klass.respond_to? :tire
    # delete the index for the current model
    klass.tire.index.delete

    # the mapping definition must get executed again. for that, we reload the model class.
    load File.expand_path("../../app/models/#{klass.name.downcase}.rb", __FILE__)
  end
end

Tire::Configuration.client.get "#{Tire::Configuration.url}/_cluster/health?wait_for_status=yellow"
sleep 1

