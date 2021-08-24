class ToppagesController < ApplicationController
  def index
    if logged_in?
      @kurarecord = current_user.kurarecords.build(clock: Time.current.strftime("%FT%T"))  # form_with 用
      @kurarecords = Kurarecord.all.order(clock: :desc).page(params[:page])
      dayfeed=0
      @kurarecords.each do |kurarecord|
        if kurarecord.clock > Time.current-86400
          unless kurarecord.feed.nil?
            dayfeed=dayfeed+kurarecord.feed
          end
        end
        @dayfeed=dayfeed
      end
    end
  end
end