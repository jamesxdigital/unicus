class MailerSettingsController < ApplicationController

	before_action :set_mailer_setting, only: [:update]

 def update
    if @mailer_setting.update(mailer_setting_params)
      redirect_to settings_path, notice: 'Mail Settings successfully updated!.'
    else
      render :edit
    end
  end


private

  def set_mailer_setting
  	@mailer_setting = MailerSetting.find(params[:id])
  end

  def mailer_setting_params
    params.require(:mailer_setting).permit(:user_id,:when_objective_added,:when_objective_proposed,:when_objective_approved,:when_objective_rejected,:when_peer_review_added,:when_peer_review_updated,:when_user_added,:when_account_activated)
  end

end