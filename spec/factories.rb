FactoryGirl.define do
  factory :event do
    title "Factory default title"
    main_picture_no -1
  end

  factory :picture do
  end

  factory :user do
    password 'secret'
    email 'example@mail.com'
    username 'test'
  end
end
