class HostConfiguration
  include ActiveModel::Serializers::JSON
  attr_accessor :os

  def initialize
    self.os = Config::CONFIG['host_os'] + ' ' + Config::CONFIG['host_cpu']
  end

  def attributes(options={})
    {os: os}
  end
end