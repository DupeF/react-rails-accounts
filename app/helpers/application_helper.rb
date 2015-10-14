module ApplicationHelper

  def bootstrap_class_for(flash_type)
    case flash_type
      when "error"
        "alert-danger"    # Red
      when "alert"
        "alert-warning"   # Yellow
      when "notice"
        "alert-info"      # Blue
      else
        "alert-#{flash_type.to_s}"
    end
  end

end
