require 'colorize'

puts "Adding Admin Users".green
AdminUser.create([
                  { first_name: 'Krishna Prasad',  last_name: "Varma", phone: "12345678", organisation: "Right Solutions", email: "krishna@yopmail.com", password: "Password@1", password_confirmation: "Password@1"}, 
                  { first_name: 'Sanoop',  last_name: "Nair", phone: "12345678", organisation: "Right Solutions", email: "sanoop@yopmail.com", password: "Password@1", password_confirmation: "Password@1"}, 
                  { first_name: 'Vedaditya',  last_name: "Nirankar", phone: "12345678", organisation: "Right Solutions", email: "nirankar@yopmail.com", password: "Password@1", password_confirmation: "Password@1"}, 
                ])

puts "Adding Client Users".green
ClientUser.create([
                  { first_name: 'Tom',  last_name: "Sawyer", phone: "12345678", organisation: "Disney", email: "sawyer@yopmail.com", password: "Password@1", password_confirmation: "Password@1"}, 
                  { first_name: 'Huckleburry',  last_name: "Finn", phone: "12345678", organisation: "DM Studios", email: "finn@yopmail.com", password: "Password@1", password_confirmation: "Password@1"}, 
                  { first_name: 'Mark',  last_name: "Twain", phone: "12345678", organisation: "Micky Productions", email: "mark@yopmail.com", password: "Password@1", password_confirmation: "Password@1"}, 
                ])

