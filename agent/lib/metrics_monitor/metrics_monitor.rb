require 'open3'
require_relative './metric'

class MetricsMonitor
  def self.metrics
    metric = Metric.new

    # Get CPU Usage
    Open3.popen3("top -b -n1 | grep 'Cpu(s)' | awk '{print $2 + $4}'") do |stdin, stdout, stderr|
      metric.cpu_usage = stdout.read
    end

    # Get disk usage
    Open3.popen3("df -hT /home | grep -v 'Used' | awk '{ print $6}'") do |stdin, stdout, stderr|
      metric.disk_usage = stdout.read
    end

    metric
  end
end