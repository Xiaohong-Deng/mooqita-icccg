# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

(1..4).each do |n|
  User.create email: "user#{n}@example.com", password: "topsecret"
end

Dir.glob('db/documents/*.txt').each do |file_name|
  lines = File.open(file_name, 'r').readlines
  title = lines[0].chomp
  content = lines.slice(2, lines.length - 2).join.chomp

  Document.create title: title, content: content
end
