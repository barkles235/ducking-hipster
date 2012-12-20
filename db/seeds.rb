# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Topic.delete_all
Topic.create(name:'beaver',systematic_name:'Castor canadensis')
Topic.create(name:'bison',systematic_name:'Bison bison')
Topic.create(name:'black bear',systematic_name:'Ursus americanus')
Topic.create(name:'moose',systematic_name:'Alces americanus')
