class VehiclesController < ApplicationController
  include ImplicitResource

  protected

  def permitted_attributes(resource)
    params.require(:vehicle).permit(:msrp)
  end
end
