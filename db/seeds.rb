# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.find_or_initialize_by(first_name: 'John', last_name: 'Galt', profile_name: 'johnGalt') {|u| u.id = 1}
user.save validate:false
