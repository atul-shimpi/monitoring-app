class MatricesController < ApplicationController
  def index
    @hosts = Host.all
  end

  def details
    @host_matrices = HostsAndMatrix.where(host_id: params[:host_id])
  end

  def collect_matrices
    Rails.logger.info('Collecting matrices from agents started')
    MatricesCollector.collect
    Rails.logger.info('Collecting matrices from agents completed')
    redirect_to root_path
  end
end
