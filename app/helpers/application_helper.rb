module ApplicationHelper
  def body_id
    "#{controller.controller_name}"
  end
end
