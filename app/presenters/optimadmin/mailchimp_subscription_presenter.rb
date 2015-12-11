module Optimadmin
  class MailchimpSubscriptionPresenter < Optimadmin::BasePresenter
    presents :mailchimp_subscription
    delegate :id, to: :mailchimp_subscription

    def title
      #mailchimp_subscription.title
    end

    def toggle_title
      inline_detail_toggle_link(title)
    end

    def optimadmin_summary
      #h.simple_format mailchimp_subscription.summary
    end
  end
end
