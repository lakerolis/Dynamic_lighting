class AactionsController < ApplicationController
  def index
    @aactions = Aaction.all
  end

  def new
    @aaction = Aaction.new
    @actors = Actor.all
  end

  def create
    @aaction = Aaction.new(aaction_params)
    if @aaction.save
      redirect_to '/aactions'
    else
      render 'new'
    end
  end

  def edit
  end

  private
  def aaction_params
    #params.permit(:name, :config, :aaction_id)
    params.require(:aaction).permit(:name, :config, :actor_id)
  end
end
