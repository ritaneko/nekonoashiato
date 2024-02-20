class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top]
  
  private
  
  def configure_authentication
    if admin_controller?
      authenticate_admin!
    else
      authenticate_user! unless action_is_public?
    end
  end
  
  def admin_controller?
    self.class.module_parent_name == 'admin'
  end
end
