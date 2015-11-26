class HostConfigurationController < ApplicationController
  def index
    @host_configuration = HostConfiguration.new.to_json

    respond_to do |format|
      format.html
      format.json { render json: @host_configuration}
    end
  end
end
