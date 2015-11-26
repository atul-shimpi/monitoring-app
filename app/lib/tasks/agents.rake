require_relative '../matrices_collector'
require 'open3'

namespace :agents do
  task collect_matrices: :environment do
    Rails.logger.info('Collecting matrices from agents started')
    MatricesCollector.collect
    Rails.logger.info('Collecting matrices from agents completed')
  end
end