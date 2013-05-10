#encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) are set in the file config/application.yml.
# See http://railsapps.github.com/rails-environment-variables.html
puts 'ROLES'
YAML.load(ENV['ROLES']).each do |role|
  Role.find_or_create_by_name({ :name => role }, :without_protection => true)
  puts 'role: ' << role
end
puts 'DEFAULT USERS'
puts 'admin user'
user = User.find_or_create_by_email :name => ENV['ADMIN_NAME'].dup, :email => ENV['ADMIN_EMAIL'].dup, :password => ENV['ADMIN_PASSWORD'].dup, :password_confirmation => ENV['ADMIN_PASSWORD'].dup
puts 'admin user: ' << user.name
user.add_role :admin
puts 'manager user'
user = User.find_or_create_by_email :name => "Manager User", :email => "manager@example.com", :password => "changeme", :password_confirmation => "changeme"
puts 'manager user: ' << user.name
user.add_role :VIP
puts 'common user'
user = User.find_or_create_by_email :name => "Common User", :email => "common@example.com", :password => "changeme", :password_confirmation => "changeme"
puts 'commom user: ' << user.name
user.add_role :user

puts 'DEFAULT PRODUCTIONS'
p1 = Production.create(:p_type => "facet", :p_pattern => "nacklace", :p_color => "red", :p_size => "30mm*40mm", :p_material => "silver", :price => 120, :make_at => Time.now, :img_url => "facet_example.jpg")
p2 = Production.create(:p_type => "radial", :p_pattern => "earrings", :p_color => "black", :p_size => "40mm*40mm", :p_material => "nylon", :price => 80, :make_at => Time.now, :img_url =>"radial_example.jpg")
p3 = Production.create(:p_type => "radial", :p_pattern => "项链", :p_color => "白色", :p_size => "40mm*40mm", :p_material => "竹子", :price => 70, :make_at => Time.now, :img_url =>"radial_example.jpg")

puts 'USER and PRODUCTION'
UserProduction.create(:user => user, :production => p1, :order_at => p1.make_at, :bargain_price => (p1.price*0.8).to_int)
UserProduction.create(:user => user, :production => p2, :order_at => p2.make_at, :bargain_price => (p2.price*0.8).to_int)
UserProduction.create(:user => user, :production => p3, :order_at => p3.make_at, :bargain_price => (p3.price*0.8).to_int, :is_sold => true, :sold_at => Time.now)

puts 'DOTS'
d1 = Dot.create(:latitude => "30.3",:longitude => "120.2")
d2 = Dot.create(:latitude => "29.6",:longitude => "91")
d3 = Dot.create(:latitude => "29.5",:longitude => "106.5")
d4 = Dot.create(:latitude => "40.5",:longitude => "120.5")

puts "DOT belongs_to PRODUCTION"
p1.dots << d1
p1.dots << d2
p2.dots << d3
p3.dots << d4