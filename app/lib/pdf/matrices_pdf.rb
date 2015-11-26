require 'pdf_base'

class MatricesPdf < PDFBase
  def initialize(hosts, app_name)
    super()

    @hosts = hosts

    header(app_name)
    title('Host Matrices')
    body(rows)
  end

  def rows
    [['Description', 'IP/Host Name', 'Connection', 'Platform',
      'Monitoring Duration', 'Avg CPU USage','Avg Disk Usage']] +
      @hosts.map do |host|
        [host.description, host.ip_or_host_name, host.connection_status.humanize, host.platform,
         host.monitoring_duration_in_hours, host.avg_cpu_usage, host.avg_disk_usage
        ]
      end
  end

end

