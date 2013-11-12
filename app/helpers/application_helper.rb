module ApplicationHelper

  def bootstrap_class_for flash_type
    {
      success: 'alert-success',
      error: 'alert-error',
      alert: 'alert-block',
      notice: 'alert-info'
    }[flash_type] || flash_type.to_s
  end

  def next_event_info
    {
      title: 'Asset Mapping For Artists',
      date: 'Tuesday, December 17th',
      time: '6:30-8:30pm',
      venue: 'New York Live Arts',
      address: '219 W 19th St (btw 7th and 8th Aves)',
    }
  end

end
