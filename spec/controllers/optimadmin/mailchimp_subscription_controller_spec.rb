require "rails_helper"
=begin
describe Optimadmin::MailchimpSubscriptionsController, type: :controller do
  routes { Optimadmin::Engine.routes }
  before(:each) do
    sign_in
  end

  describe "#create" do
    context "when Mailchimp subscription is valid" do
      it "redirects to index on normal save" do
        mailchimp_subscription = stub_valid_mailchimp_subscription

        post :create, commit: "Save", mailchimp_subscription: mailchimp_subscription.attributes

        expect(response).to redirect_to(mailchimp_subscriptions_path)
        expect(flash[:notice]).to eq("Mailchimp subscription was successfully created.")
      end

      it "redirects to edit on save and continue editing" do
        mailchimp_subscription = stub_valid_mailchimp_subscription

        post :create, commit: "Save and continue editing", mailchimp_subscription: mailchimp_subscription.attributes

        expect(response).to redirect_to(edit_mailchimp_subscription_path(mailchimp_subscription))
        expect(flash[:notice]).to eq("Mailchimp subscription was successfully created.")
      end
    end

    context "when Mailchimp subscription is invalid" do
      it "renders the edit template" do
        mailchimp_subscription = stub_invalid_mailchimp_subscription

        post :create, commit: "Save", mailchimp_subscription: mailchimp_subscription.attributes

        expect(response).to render_template(:new)
      end
    end
  end

  describe "#update" do
    context "when Mailchimp subscription is valid" do
      it "redirects to index on normal save" do
        mailchimp_subscription = stub_valid_mailchimp_subscription

        patch :update, id: mailchimp_subscription.id, commit: "Save", mailchimp_subscription: mailchimp_subscription.attributes

        expect(response).to redirect_to(mailchimp_subscriptions_path)
        expect(flash[:notice]).to eq("Mailchimp subscription was successfully updated.")
      end

      it "redirects to edit on save and continue editing" do
        mailchimp_subscription = stub_valid_mailchimp_subscription

        patch :update, id: mailchimp_subscription.id, commit: "Save and continue editing", mailchimp_subscription: mailchimp_subscription.attributes

        expect(response).to redirect_to(edit_mailchimp_subscription_path(mailchimp_subscription))
        expect(flash[:notice]).to eq("Mailchimp subscription was successfully updated.")
      end
    end

    context "when Mailchimp subscription is invalid" do
      it "renders the edit template" do
        mailchimp_subscription = stub_invalid_mailchimp_subscription

        patch :update, id: mailchimp_subscription.id, commit: "Save", mailchimp_subscription: mailchimp_subscription.attributes

        expect(response).to render_template(:edit)
      end
    end
  end

  def stub_valid_mailchimp_subscription
    mailchimp_subscription = build_stubbed(:mailchimp_subscription)
    allow(AdditionalContent).to receive(:new).and_return(mailchimp_subscription)
    allow(mailchimp_subscription).to receive(:save).and_return(true)
    allow(AdditionalContent).to receive(:find).and_return(mailchimp_subscription)
    allow(mailchimp_subscription).to receive(:update).and_return(true)
    mailchimp_subscription
  end

  def stub_invalid_mailchimp_subscription
    mailchimp_subscription = build_stubbed(:mailchimp_subscription)
    allow(AdditionalContent).to receive(:new).and_return(mailchimp_subscription)
    allow(mailchimp_subscription).to receive(:save).and_return(false)
    allow(AdditionalContent).to receive(:find).and_return(mailchimp_subscription)
    allow(mailchimp_subscription).to receive(:update).and_return(false)
    mailchimp_subscription
  end
end
=end
