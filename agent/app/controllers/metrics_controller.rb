#require 'metrics_monitor/metrics_monitor'

class MetricsController < ApplicationController
  def index
    last_record_id = params.include?('metric_last_record_id') ? params['metric_last_record_id'].to_i : 0
    @metrics =  MetricUsage.where("id > ?", last_record_id)

    respond_to do |format|
      format.html
      format.json { render json: @metrics}
    end
  end
end
