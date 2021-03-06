class GuestsController < ApplicationController
  before_filter :require_admin

  include SessionsHelper
  
  def index
    if current_user
      @guests = current_user.guests
    else
      @guests = []
    end
  end

  def new
    @guest = current_user.guests.build
  end

  def create
    @guest = current_user.guests.build(params[:guest])
    respond_to do |format|
      if @guest.save
        format.html { redirect_to guests_path, notice: 'Guest was successfully created.'; return }
        format.json { render json:@guest, status: :created, location: @guest }
      else
        format.html {
          render 'new'
        }
        format.json { render json:@guest.error, status:unprocessable_entity }
      end
    end
  end

  def update
    guest = Guest.find(params[:id])
    if guest.update_attributes(params[:guest])
      render :json=>{ :memo=>guest.memo }
    else
      render :json=>{ :error=>true, :errors=>guest.errors.messages }.to_json
    end
  end

  def edit
  end

  def show
  end

  def destroy
    guest = current_user.guests.find(params[:id])
    guest.destroy

    redirect_to guests_path
  end

end
