class MatricesDetailsPdfController < ApplicationController
  def details
    @host_matrices = HostsAndMatrix.where(host_id: params[:host_id]).first(50)
    sub_title = @host_matrices.size > 0 ?
                @host_matrices[0].host.description + '(' + @host_matrices[0].host.ip_or_host_name + ')'
                : nil
    pdf = DetailsMatricesPdf.new(@host_matrices, 'System Monitoring', 'Host Name : ' + sub_title)
    send_data pdf.render, filename: 'details.pdf', type: 'application/pdf', disposition: 'inline'
  end
end

