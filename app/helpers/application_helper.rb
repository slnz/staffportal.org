module ApplicationHelper
  def title(page_title, options = {})
    content_for(:title, page_title.to_s)
    content_tag(:h1, page_title, options)
  end
  def flash_messages(_opts = {})
    return if flash.empty?
    flash.map do |msg_type, message|
      concat(
        content_tag(:div,
                    message,
                    class: "alert #{bootstrap_class_for(msg_type)}"))
    end.join.html_safe
  end

  def destroy_link_to(path, options)
    link_to options[:content] || t('action.destroy.link', item: options[:item]),
            path,
            destroy_link_to_options(item: options[:item])
  end

  private

  def destroy_link_to_options(item)
    { method: :delete,
      class: 'btn btn-danger btn-sm',
      'data-confirm' => t('action.destroy.confirm.body', item),
      'data-confirm-fade' => true,
      'data-confirm-title' => t('action.destroy.confirm.title', item),
      'data-confirm-cancel' => t('action.destroy.confirm.cancel', item),
      'data-confirm-cancel-class' => 'btn-default',
      'data-confirm-proceed' => t('action.destroy.confirm.proceed', item),
      'data-confirm-proceed-class' => 'btn-danger' }
  end

  def bootstrap_class_for(flash_type)
    { success: 'alert-success',
      error: 'alert-danger',
      alert: 'alert-warning',
      info: 'alert-info',
      notice: 'alert-info' }[flash_type.to_sym] || flash_type.to_s
  end
end
