class ConditionsController < ApplicationController
  def index
    @conditions = Condition.all
  end

  def new
    @condition = Condition.new
    @sensors = Sensor.all
    @rules = Rule.all
  end

  def create
    @condition = Condition.new(condition_params)
    if @condition.save
      redirect_to '/conditions'
    else
      render 'new'
    end
  end

  def edit
  end

  def destroy
    @condition = Condition.find(params[:id])
    @condition.destroy
    respond_to do |format|
      format.html { redirect_to conditions_url, notice: 'Condition was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def condition_params
    params.require(:condition).permit(:name, :description, :operator, :operator_value, :sensor_id, :rule_id)
  end
end
