class ApplicationController < ActionController::Base

  layout "layouts/admin_layout"

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :update_headers_to_disable_caching
  before_action :ie_warning

  ## The following are used by our Responder service classes so we can access
  ## the instance variable for the current resource easily via a standard method
  ## controller_name.demodulize.singularize
##  end

  def current_resource
   instance_variable_get(:"@#{resource_name}")
  end

  def current_resource=(val)
   instance_variable_set(:"@#{resource_name}", val)
  end

  # Catch NotFound exceptions and handle them neatly, when URLs are mistyped or mislinked
  rescue_from ActiveRecord::RecordNotFound do
    render template: 'errors/error_404', status: 404
  end
  rescue_from CanCan::AccessDenied do
    render template: 'errors/error_403', status: 403
  end

  # IE over HTTPS will not download if browser caching is off, so allow browser caching when sending files
  def send_file(file, opts={})
    response.headers['Cache-Control'] = 'private, proxy-revalidate' # Still prevent proxy caching
    response.headers['Pragma'] = 'cache'
    response.headers['Expires'] = '0'
    super(file, opts)
  end
  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:username, :password, :remember_me) }
    end

  private
    def update_headers_to_disable_caching
      response.headers['Cache-Control'] = 'no-cache, no-cache="set-cookie", no-store, private, proxy-revalidate'
      response.headers['Pragma'] = 'no-cache'
      response.headers['Expires'] = '-1'
    end

    def ie_warning
      return redirect_to(ie_warning_path) if request.user_agent.to_s =~ /MSIE [6-7]/ && request.user_agent.to_s !~ /Trident\/7.0/
    end

    def getMailerSettings(user_id)
      settings = MailerSetting.find_by_user_id(user_id)

      if settings.nil?
          createMailerSettings(user_id)
          settings = MailerSetting.find_by_user_id(user_id)
      end

      return settings
    end

    def createMailerSettings(user_id)
      settings = MailerSetting.new
      settings.user_id = user_id
      settings.save
    end
end
