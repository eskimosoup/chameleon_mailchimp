FactoryGirl.define do
  factory :mailchimp_subscription do
    email_address 'paul@optimised.today'
    first_name 'Paul'
    last_name 'L'
    company 'optimised'
    job_title 'Developer'
  end
end
