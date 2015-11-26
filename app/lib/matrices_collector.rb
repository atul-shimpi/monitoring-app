require 'open-uri'
require 'json'

class MatricesCollector
  def self.collect
    Host.all.each do |host|
      save_or_update_host_config(host)

      Rails.logger.info("Collecting matrices from #{host.ip_or_host_name} started")

      metrics = collect_metric(host)
      return if metrics.nil?

      metrics.each do |metric|
        case metric["type"]
          when 'CpuUsage'
            HostsCPUUsage.create(host_id: host.id, collection_time: metric["created_at"], usage: metric["usage"])
          when 'DiskUsage'
            HostsDiskUsage.create(host_id: host.id, collection_time: metric["created_at"], usage: metric["usage"])
          else
            Rails.logger.info("Invalid Metric " + metric.to_s)
        end
      end

      Rails.logger.info("Collecting matrices from #{host.ip_or_host_name} completed")

      update_record_id(host, metrics)
    end

  end

  private
  def self.collect_metric(host)
    last_record_id = 0
    if HostAndMatricesRecordId.where('host_id = ?', host.id).count > 0
      last_record_id = HostAndMatricesRecordId.where(host_id: host.id).last.last_record_id
    end

    metrics = collect_response(host,host.metrics_api_end_point + '?metric_last_record_id=' + last_record_id.to_s)
  end

  def self.save_or_update_host_config(host)
    host_config = collect_host_config(host)
    return if host_config.nil?

    HostConfiguration.where("id = ?", host.id).first_or_initialize.update_attributes( host_id: host.id,
                                                                                      os: host_config['os'],
                                                                                      cpu_size: 0,
                                                                                      disk_size: 0
                                                                                     )
  end

  def self.collect_host_config(host)
    collect_response(host,host.host_config_api_end_point)
  end

  def self.collect_response(host, url)
    begin
      response = open(url).read
      host.update(connection_status: :ok)
      metrics = JSON.parse(response)
    rescue Errno::ECONNREFUSED
      host.update(connection_status: :failed)
      nil
    rescue Errno::ENETUNREACH
      host.update(connection_status: :failed)
      nil
    end
  end

  def self.update_record_id(host, matrices)
    Rails.logger.info('Updating record ids started')

    cpu_usage_record_id = 0
    disk_usage_record_id = 0

    matrices.each do |metric|
      case metric["type"]
        when 'CpuUsage'
          cpu_usage_record_id = metric["id"].to_i if metric["id"].to_i > cpu_usage_record_id
        when 'DiskUsage'
          disk_usage_record_id = metric["id"].to_i if metric["id"].to_i > disk_usage_record_id
        else
          Rails.logger.info("Invalid Metric " + metric.to_s)
      end
    end

    cpu_usage = CPUUsageMatricesRecordIds.where("host_id = ?", host.id).first_or_initialize
    cpu_usage.update_attributes(host_id: host.id, last_record_id: cpu_usage_record_id)

    disk_usage = DiskUsageMatricesRecordIds.where("host_id = ?", host.id).first_or_initialize
    disk_usage.update_attributes(host_id: host.id, last_record_id: disk_usage_record_id)

    Rails.logger.info("Updating record ids completed")
  end


end