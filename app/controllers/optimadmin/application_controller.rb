module Optimadmin
  class ApplicationController < ActionController::Base

    include Optimadmin::AdminSessionsHelper

    before_action :global_site_settings, :authorize

    def index
      redirect_to new_mailchimp_subscription_path
    end

    def link_list
      respond_to do |format|
        format.js do
          render layout: nil
        end
      end
    end

    private

    def authorize
      session[cookie_name_return_to] = request.fullpath
      redirect_to login_url, alert: 'Not authorised' if current_administrator.nil?
    end

    def global_site_settings
      @global_site_settings ||= SiteSetting.current_environment
    end
    helper_method :global_site_settings

    # needs to be defined to use cancancan in engine
    def current_ability
      @current_ability ||= AdminAbility.new(current_administrator)
    end

    def redirect_to_index_or_continue_editing(model)
      if continue_editing?
        redirect_to({ action: :edit, id: model.id }, notice: notice(model))
      else
        redirect_to({ action: :index }, notice: notice(model))
      end
    end

    def continue_editing?
      params[:commit] == "Save and continue editing"
    end

    def notice(model)
      "#{ model.class.name } was successfully #{ params[:action] == "create" ? 'created' : 'updated' }."
    end

    rescue_from CanCan::AccessDenied do |exception|
      logger.info exception
      flash[:error] = 'Access denied!'
      redirect_to root_url
    end
  end
end
