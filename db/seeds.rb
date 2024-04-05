user = User.create!(email: 'admin@admin.com', password: '123456')
avatar = Avatar.create!
avatar.image.attach(io: File.open("#{Rails.root}/app/assets/images/default-avatar.png"), filename: 'default-avatar.png', content_type: 'image/png')
user.avatar = avatar
p user.as_json
p avatar.as_json