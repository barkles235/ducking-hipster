# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Topic.delete_all
Topic.create(name:'Abaca (Manila hemp)',systematic_name:'Musa textilis')
Topic.create(name:'Alfalfa for fodder',systematic_name:'Medicago sativa')
Topic.create(name:'Alfalfa for seed',systematic_name:'Medicago sativa')
Topic.create(name:'Almond',systematic_name:'Prunus dulcis')
Topic.create(name:'Anise seeds',systematic_name:'Pimpinella anisum')
Topic.create(name:'Apple',systematic_name:'Malus sylvestris')
