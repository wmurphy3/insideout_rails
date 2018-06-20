User.find_or_create_by!(email: "willardtwashington@gmail.com") do |user|
  user.password = "wM!@#456"
  user.is_admin = true
  user.name = "William Murphy"
end
