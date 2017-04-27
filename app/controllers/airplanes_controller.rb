class AirplanesController < ApplicationController
  def index
    @airplanes = Airplane.all.order(:priority, :updated_at)
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

  def destroy
    @airplane = Airplane.dequeue
    if @airplane
      flash[:success] = "Airplane #{@airplane[:name]}, with id #{@airplane[:id]} was successfuly Dequeued"
    else
      flash[:danger] = "there were no planes to dequeue"
    end
    redirect_to action: "new"
  end


  def airplane_params 
    params.require(:airplane).permit(:name, :size, :cargo_type)
  end
end
