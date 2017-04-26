class AirplanesController < ApplicationController
  def index
    @airplanes = Airplane.all
  end

  def new
  end
end
