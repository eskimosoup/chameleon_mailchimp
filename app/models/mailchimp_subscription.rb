class MailchimpSubscription
  include ActiveModel::Model

  attr_accessor :email_address, :first_name, :last_name, :company,
                :job_title, :list_id

  validates :email_address, :list_id, presence: true
  validates :email_address, email: true

  require 'mailchimp'

  def self.monkey
    Mailchimp::API.new(MAILCHIMP_API_KEY)
  end

  def self.lists
    lists = monkey.lists.list
    lists['data']
  rescue
    nil
  end

  def self.list_name(id)
    result = monkey.lists.list(list_id: id)
    result['data'][0]['name'] if result
  rescue
    nil
  end

  # http://andrew.coffee/blog/how-to-add-subscribers-to-a-mailchimp-list-with-ruby.html
  def self.subscribe(params)
    # http://www.rubydoc.info/gems/mailchimp-api/2.0.4/Mailchimp/Lists#subscribe-instance_method
    monkey.lists.subscribe(params[:list_id],
                           # The email field is a struct that can use an
                           #    email address or two MailChimp specific list ids (see API docs)
                           { email: params[:email_address] },
                           # Set your merge vars here
                           { 'FNAME' => params[:first_name],
                             'LNAME' => params[:last_name],
                             'MMERGE3' => params[:company],
                             'MMERGE4' => params[:job_title]
                           },
                           'html',
                           false,
                           false,
                           false,
                           false
                          )
    'Success'
  rescue Mailchimp::ListAlreadySubscribedError
    # Decide what to do if the user is already subscribed
    'Email is already subscribed'
  rescue Mailchimp::ListDoesNotExistError => e
    # This is definitely a problem I want to know about
    # raise e
    if e.present?
      e.message
    else
      'List does not exist'
    end
  rescue Mailchimp::Error => e
    # Unforeseen errors that need to be dealt with
    if e.present?
      e.message
    else
      'Mailchimp API down, please try again later'
    end
  end
end
