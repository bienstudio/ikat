module ApplicationHelper
  def helpful_link(text = "Support")
    if current_user
      mail_to "ikat@helpful.io", text, "data-helpful" => "ikat", "data-helpful-modal" => "on", "data-helpful-name" => current_user.name, "data-helpful-email" => current_user.email
    else
      mail_to "ikat@helpful.io", text, "data-helpful" => "ikat", "data-helpful-modal" => "on"
    end
  end
end
