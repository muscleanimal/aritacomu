class ToppagesController < ApplicationController
  def index
      @works = Work.limit(3).order(id: :desc)
  end
  
  def show
        @works = Work.order(id: :desc).page(params[:page]).per(25)
end 

end
