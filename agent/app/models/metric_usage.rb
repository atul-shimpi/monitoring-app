class MetricUsage < ActiveRecord::Base
  validates :type, presence: true
  validates :usage, presence: true

  def as_json(options={})
    super(options.merge({:methods => :type}))
  end
end
