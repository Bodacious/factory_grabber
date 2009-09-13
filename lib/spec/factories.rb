require "factory_girl"

Factory.define(:user) do |f|
  f.sequence(:first_name) { |n| "first#{n}" }
  f.sequence(:last_name)  { |n| "last#{n}" }
  f.sequence(:email)      { |n| "email#{n}@email.com" }
  f.admin(false)
end