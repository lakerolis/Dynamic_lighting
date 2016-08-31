class AactionsController < ApplicationController
  def index
    @aactions = Aaction.all
  end

  def new
    @aaction = Aaction.new
    @actors = Actor.all
    @rules = Rule.all
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

  def destroy
    @aaction = Aaction.find(params[:id])
    @aaction.destroy
    respond_to do |format|
      format.html { redirect_to rules_url, notice: 'Action was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def aaction_params
    #params.permit(:name, :config, :aaction_id)
    params.require(:aaction).permit(:name, :config, :actor_id, :rule_id)
  end
end
