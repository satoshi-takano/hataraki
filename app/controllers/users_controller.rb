class UsersController < ApplicationController
  include WorksHelper
  
  before_filter :require_guest, :only=>[:show_works, :show_work]
  
  def show_works
    @years = loadWorksEachYears
    render "works/index"
  end

  def show_work
    @work = Work.find_by_user_id_and_id(current_guest.user_id, params[:work_id])
    if @work
      render "works/show"
    else
      redirect_to user_path(current_guest.user_id)
    end

  end

  def guest_authentication
    guest = Guest.find_by_user_id_and_login_id_and_login_password(params[:user_id], params[:guest_id], params[:password])

    if guest
      session[:guest_id] = guest.id
      admin_logout
    end

    redirect_to user_path(params[:user_id])
  end


  private
  def require_guest
    @user_id = params[:user_id]
    if current_guest == nil
      render 'users/authenticate'
      return
    elsif current_guest.user_id != params[:user_id].to_i
      render 'users/authenticate'
      return
    end
  end
end
