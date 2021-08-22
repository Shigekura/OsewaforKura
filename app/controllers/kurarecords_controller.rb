class KurarecordsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:edit, :update, :destroy]
  def create
    @kurarecord = current_user.kurarecords.build(kurarecord_params)
    if @kurarecord.save
      flash[:success] = 'お世話記録を書き込みました。'
      redirect_to root_url
    else
      #@kurarecords = current_user.kurarecords.order(clock: :desc).page(params[:page])
      @kurarecords = Kurarecord.all.order(clock: :desc).page(params[:page])
      flash.now[:danger] = 'お世話記録の書き込みに失敗しました。'
      render 'toppages/index'
    end
  end
  def edit
    @kurarecord = current_user.kurarecords.find(params[:id])    
  end
  def update
    if @kurarecord.update(kurarecord_params)
      flash[:success] = 'お世話記録を修正しました。'
      redirect_to root_url
    else
      @kurarecords = current_user.kurarecords.order(clock: :desc).page(params[:page])
      flash.now[:danger] = 'お世話記録の修正に失敗しました。'
      render 'toppages/index'
    end
  end
  def destroy
    @kurarecord.destroy
    flash[:success] = 'お世話記録を削除しました。'
    redirect_back(fallback_location: root_path)
  end

  private
  def kurarecord_params
    params.require(:kurarecord).permit(:clock, :feed, :content)
  end
  def correct_user
    @kurarecord = current_user.kurarecords.find_by(id: params[:id])
    unless @kurarecord
      redirect_to root_url
    end
  end
end