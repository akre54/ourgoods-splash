module ApplicationHelper

  def bootstrap_class_for flash_type
    {
      success: 'alert-success',
      error:   'alert-warning',
      alert:   'alert-block',
      notice:  'alert-info'
    }[flash_type.to_sym] || flash_type.to_s
  end

  def active_events
    # Always the most recent event
    Event.active
  end
end
