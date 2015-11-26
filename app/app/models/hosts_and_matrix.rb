class HostsAndMatrix < ActiveRecord::Base
  belongs_to :host

  validates :type, presence: true
  validates :usage, presence: true

  def collection_time_humanize
    collection_time.strftime("%d-%m-%Y, %H:%M")
  end

  def type_humanize
    {HostsCPUUsage: 'CPU Usage', HostsDiskUsage: 'Disk Usage'}[type.to_sym]
  end
end
