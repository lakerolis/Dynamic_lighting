class ActorsController < ApplicationController
  def index
    @actors = Actor.all
  end

  def new
    @actor = Actor.new
  end

  def create
    @actor = Actor.new(actor_params)
    if @actor.save
      redirect_to '/actors'
    else
      render 'new'
    end
  end

  def delete
    @actor = Actor.find(params[:id])
    @actor.destroy
    respond_to do |format|
      format.html { redirect_to actors_url, notice: 'Actor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def actor_params
    params.require(:actor).permit(:name, :description, :defaultConfig)
  end
end
