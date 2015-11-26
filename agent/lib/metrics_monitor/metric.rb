class Metric
  include ActiveModel::Serializers::JSON
  attr_accessor :cpu_usage, :disk_usage

  def attributes(options={})
    {cpu_usage: cpu_usage, disk_usage: disk_usage}
  end
end