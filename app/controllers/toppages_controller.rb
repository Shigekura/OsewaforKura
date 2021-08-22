class ToppagesController < ApplicationController
  def index
    if logged_in?
      @kurarecord = current_user.kurarecords.build(clock: Time.now)  # form_with 用
      #@kurarecords = current_user.kurarecords.order(clock: :desc).page(params[:page])
      @kurarecords = Kurarecord.all.order(clock: :desc).page(params[:page])
    end
  end
end
