class ActionsController < ApplicationController
  def index
    @actions = Action.all
  end

  def new
    @action = Action.new
    @actors = Actor.all
  end

  def create
    @action = Action.new(action_params)
    if @action.save
      redirect_to '/actions'
    else
      render 'new'
    end
  end

  def edit
  end

  private
  def action_params
    #params.permit(:name, :actor_id, :config)
    params.require(:action).permit(:name, :config, :action_id)
  end

end
