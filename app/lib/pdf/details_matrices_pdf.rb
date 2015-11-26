require 'pdf_base'

class DetailsMatricesPdf < PDFBase
  def initialize(hosts_matrices, title, sub_title)
    super()

    @hosts_matrices = hosts_matrices

    header(title)
    title(sub_title)
    body(rows)
  end

  def rows
    [['Time', 'Metric', 'Value (%)']] +
        @hosts_matrices.map do |host_metric|
          [host_metric.collection_time_humanize, host_metric.type_humanize, host_metric.usage]
        end
  end
end