module ApplicationHelper
  def new_url_from_model(model_name)
    Rails.application.routes.url_helpers.send('new_' + model_name.to_s.downcase + '_path')
  end

  def view_url_from_instance(instance)
    Rails.application.routes.url_helpers.send(instance.to_s.downcase + '_path')
  end

  def edit_url_from_instance(instance)
    Rails.application.routes.url_helpers.send('edit_' + instance.model_name.to_s.downcase + '_path', instance.id)
  end

  def method_path(parent_obj, attr_path)
    object = parent_obj
    attr_path.to_s.split('.').each do |item|
      object = object.send(item)
      return if object.nil?
    end
    object.to_s
  end

  def attr_foreign_key?(attr_name)
    attr_name[-3..-1].eql?('_id')
  end
end
