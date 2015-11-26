class MatricesPdfController < ApplicationController
  def index
    @hosts = Host.all

    pdf = MatricesPdf.new(@hosts, 'System Monitoring')
    send_data pdf.render, filename: 'matrics.pdf', type: 'application/pdf', disposition: 'inline'
  end
end

