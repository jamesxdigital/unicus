# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.where(email:
'admin@example.com').first_or_create(password:
'mypassword123', password_confirmation: 'mypassword123', role: 'Administrator')

User.where(email:
'moderator@example.com').first_or_create(password:
'mypassword123', password_confirmation: 'mypassword123', role: 'Moderator')

Frontpv.create(title: "We are Team 21",
              message: "We create amazing stuff for the web, hehe. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
              location: "The University of Sheffield",
              date: "12/12/2016"
              )

Speaker.create(email: "admin@example.com",to_display: "0")
Speaker.create(email: "moderator@example.com",to_display: "0")
