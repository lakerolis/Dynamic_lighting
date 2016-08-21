class SensorsController < ApplicationController
  def index
    @sensors = Sensor.all
  end

  def new
    @sensor = Sensor.new
  end

  def create
    @sensor = Sensor.new(sensor_params)
    if @sensor.save
      redirect_to '/sensors'
    else
      render 'new'
    end
  end

  def delete
    @sensor = Sensor.find(params[:id])
    @sensor.destroy
    respond_to do |format|
      format.html { redirect_to sensors_url, notice: 'Sensor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def sensor_params
    params.require(:sensor).require(:name)
    params.require(:sensor).permit(:description)
  end
end
