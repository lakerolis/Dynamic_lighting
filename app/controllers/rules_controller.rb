class RulesController < ApplicationController
  def index
    @rules = Rule.all
  end

  def new
    @rule = Rule.new
  end

  def create
    @rule = Rule.new(actor_params)
    if @rule.save
      redirect_to '/rules'
    else
      render 'new'
    end
  end

  def delete
    @rule = Rule.find(params[:id])
    @rule.destroy
    respond_to do |format|
      format.html { redirect_to rules_url, notice: 'Rule was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def actor_params
    params.require(:rule).permit(:name, :description, :state, :conditionTypes)
  end
end
