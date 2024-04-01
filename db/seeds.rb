# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "seedの実行を開始"

rita = User.find_or_create_by!(email: "rita@example.com") do |user|
  user.name = "Rita"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/nekocyanPAKE4516-433_TP_V4.jpg"), filename:"nekocyanPAKE4516-433_TP_V4.jpg")
end

yuri = User.find_or_create_by!(email: "yuri@example.com") do |user|
  user.name = "Yuri"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/nekocyanPAKE4478-424_TP_V4.jpg"), filename:"nekocyanPAKE4478-424_TP_V4.jpg")
end

miko = User.find_or_create_by!(email: "miko@example.com") do |user|
  user.name = "Miko"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/nekocatPAR585852415_TP_V4.jpg"), filename:"nekocatPAR585852415_TP_V4.jpg")
end

Photo.find_or_create_by!(title: "カメラ目線") do |photo|
  photo.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/zeke-tucker-gSSK4u8yPpM-unsplash.jpg"), filename:"zeke-tucker-gSSK4u8yPpM-unsplash.jpg")
  photo.body = "カメラ目線でゴロン"
  photo.user = rita

end

Photo.find_or_create_by!(title: "窓辺でお昼寝") do |photo|
  photo.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/roberto-huczek-oA6zqMdnhjE-unsplash.jpg"), filename:"roberto-huczek-oA6zqMdnhjE-unsplash.jpg")
  photo.body = "気持ちよさそうに日向ぼっこ"
  photo.user = yuri
end

Photo.find_or_create_by!(title: "お気に入り") do |photo|
  photo.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/TOMS526533_TP_V4.jpg"), filename:"TOMS526533_TP_V4.jpg")
  photo.body = "いいもの見つけた！"
  photo.user = miko
end

Tag.find_or_create_by!(tag_name: 'かわいい')
Tag.find_or_create_by!(tag_name: '不思議')

Board.find_or_create_by!(title: "お気に入りの猫") do |board|
  board.body = "みんなのお気に入りの猫を教えて！"
  board.user = rita
end

puts "seedの実行が完了しました"