FactoryGirl.define do
  factory :event do
    title "Factory default title"
    main_picture_no -1
  end

  factory :user do
    password 'secret'
  end
end
