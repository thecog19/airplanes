class AirplanesController < ApplicationController
  def index
    @airplanes = Airplane.all
  end

  def new
  end

  def create
    @airplane = Airplane.enqueue(airplane_params)
    if @airplane.valid?
      flash[:success] = "Plane added to queue"
    else
      flash[:danger] = @airplane.errors.full_messages.first 
    end
    redirect_to action: "new"
  end

  def airplane_params 
    params.require(:airplane).permit(:name, :size, :cargo_type)
  end
end
