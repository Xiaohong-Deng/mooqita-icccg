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

Game.create document: Document.find(1)

["judge", "reader", "guesser"].each_with_index do |role, index|
  GamePlayer.create game: Game.find(1), user: User.find(index + 1), role: role
end

GamePlayer.find(2).update(questioner: true)
