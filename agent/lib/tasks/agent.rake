require 'open3'

namespace :agent do
  task save_matrices: :environment do
    metric = MetricsMonitor.metrics

    Rails.logger.info('Saving cpu Usage to database')
    CpuUsage.create(usage: metric.cpu_usage)

    Rails.logger.info('Saving disk Usage to database')
    DiskUsage.create(usage: metric.disk_usage)
  end
end

