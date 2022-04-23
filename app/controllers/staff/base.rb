class Staff::Base < ApplicationController
  before_action :authorize

  private def current_staff_member
    if session[:staff_member_id]
      @current_staff_member ||=
        StaffMember.find_by(id: session[:staff_member_id])
    end
  end

  helper_method :current_staff_member

  private def authorize
    unless current_staff_member
      flash.notice = '職員としてろぐいんしてください。'
      redirect_to :staff_login
    end
  end
end
