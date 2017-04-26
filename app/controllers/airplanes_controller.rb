class AirplanesController < ApplicationController
  def index
    @airplanes = Airplane.all
  end

  def new
  end

  def create
    @airplane = Airplane.enqueue(airplane_params)
    redirect_to action: "new"
  end

  def airplane_params 
    params.require(:airplane).permit(:name, :size, :cargo_type)
  end
end
