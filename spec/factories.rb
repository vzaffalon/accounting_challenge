FactoryBot.define do

    factory :user do
        name {'Victor Zaffalon'}
        email {Faker::Internet.unique.email}
        password {'123456'}
        password_confirmation {'123456'}
    end

    factory :login_session do
        association :user, factory: :user
    end

    factory :account do
        amount {80000}
        name {'Rodrigo Peixoto LTDA'}
        number {Faker::Number.unique.number(digits: 10)}
        association :user, factory: :user
    end

end