class Host < ActiveRecord::Base
  validates :description, presence: true
  validates :ip_or_host_name, presence: true
  validates :port, presence: true
  enum connection_status: [:unknown, :failed, :ok, :error]

  has_one :host_configuration
  has_many :hosts_and_matrixes
  has_many :hosts_cpu_usages
  has_many :hosts_disk_usages

  def api_end_point
    "http://" + ip_or_host_name + ":" + port.to_s
  end

  def metrics_api_end_point
    api_end_point + '/metrics.json'
  end

  def host_config_api_end_point
    api_end_point + '/host/configuration.json'
  end

  def platform
    host_configuration.os
  end

  def monitoring_duration_in_hours
    (monitoring_duration_in_mins/60.0).round(2)
  end

  def monitoring_duration_in_mins
    ((hosts_and_matrixes.last.collection_time.to_i - hosts_and_matrixes.first.collection_time.to_i)/60).round(2)
  end

  def avg_cpu_usage
    (HostsAndMatrix.where(host_id: id, type: 'HostsCPUUsage').sum(:usage) / monitoring_duration_in_mins).round(2)
  end

  def avg_disk_usage
    (HostsAndMatrix.where(host_id: id, type: 'HostsDiskUsage').sum(:usage) / monitoring_duration_in_mins).round(2)
  end


end
