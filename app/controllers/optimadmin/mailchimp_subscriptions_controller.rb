module Optimadmin
  class MailchimpSubscriptionsController < Optimadmin::ApplicationController
    before_action :set_lists, only: [:new, :create]

    def new
      @mailchimp_subscription = MailchimpSubscription.new
    end

    def create
      @mailchimp_subscription = MailchimpSubscription.new(mailchimp_subscription_params)
      if @mailchimp_subscription.valid?
        @notice = MailchimpSubscription.subscribe(mailchimp_subscription_params)
        redirect_to new_mailchimp_subscription_path, notice: @notice
      else
        render :new
      end
    end

    def destroy
      @mailchimp_subscription.destroy
      redirect_to mailchimp_subscriptions_url, notice: 'Mailchimp subscription was successfully destroyed.'
    end

  private

    def set_lists
       @mailchimp_lists = MailchimpSubscription.lists
     end

    def mailchimp_subscription_params
      params.require(:mailchimp_subscription).permit(:email_address, :first_name, :last_name, :company, :job_title, :list_id)
    end
  end
end
