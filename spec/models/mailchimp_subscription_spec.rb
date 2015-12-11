require 'rails_helper'

RSpec.describe MailchimpSubscription, type: :model do
  describe 'validations', :validation do
    subject(:mailchimp_subscription) { build(:mailchimp_subscription) }
    it { should validate_presence_of(:email_address) }
    it { should validate_presence_of(:list_id) }
    it { expect(mailchimp_subscription).to_not allow_value('optimised.today').for(:email_address) }
    it { expect(mailchimp_subscription).to allow_value('paul@optimised.today').for(:email_address) }
  end

  describe 'fields', :fields do
    subject(:mailchimp_subscription) { build(:mailchimp_subscription) }
    it { should have_attr_accessor(:list_id) }
    it { should have_attr_accessor(:email_address) }
    it { should have_attr_accessor(:first_name) }
    it { should have_attr_accessor(:last_name) }
    it { should have_attr_accessor(:company) }
    it { should have_attr_accessor(:job_title) }
  end

  describe 'public class methods' do
    context 'responds to its methods' do
      it { expect(MailchimpSubscription).to respond_to(:monkey) }
      it { expect(MailchimpSubscription).to respond_to(:lists) }
      it { expect(MailchimpSubscription).to respond_to(:list_name) }
      it { expect(MailchimpSubscription).to respond_to(:subscribe) }
    end

    context 'executes methods correctly' do
      context 'self.monkey' do
        it 'creates new Mailchimp API instance' do
          # expect(MailchimpSubscription.monkey).to eq(Mailchimp::API.new(MAILCHIMP_API_KEY))
        end
      end

      context 'self.lists' do
        it 'returns array of Mailchimp lists' do
          # expect(MailchimpSubscription.lists).to eq(Mailchimp::API.new(MAILCHIMP_API_KEY).lists.list['data'])
        end
      end

      context 'self.list_name' do
        it 'returns list name of Mailchimp list' do
          # expect(MailchimpSubscription.list_name('list_id')).to eq(Mailchimp::API.new(MAILCHIMP_API_KEY).lists.list(list_id: id)['data'][0]['name'])
        end
      end

=begin
      context 'self.subscribe' do
        it 'returns string to determine subscription status' do
          expect(MailchimpSubscription.subscribe(mailchimp_subscription)).to eq(
            Mailchimp::API.new(MAILCHIMP_API_KEY).ists.subscribe(params[:list_id],
                                                                 # The email field is a struct that can use an
                                                                 #    email address or two MailChimp specific list ids (see API docs)
                                                                 { email: mailchimp_subscription.email },
                                                                 # Set your merge vars here
                                                                 { 'FNAME' => mailchimp_subscription.first_name,
                                                                   'LNAME' => mailchimp_subscription.last_name,
                                                                   'MMERGE3' => mailchimp_subscription.company,
                                                                   'MMERGE4' => mailchimp_subscription.job_title
                                                                 },
                                                                 'html',
                                                                 false,
                                                                 false,
                                                                 false,
                                                                 false
                                                                )
          )
        end
      end
=end
    end
  end
end
