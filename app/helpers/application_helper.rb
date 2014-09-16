module ApplicationHelper

  # A link to Helpful.io.
  def helpful_link(text = "Support")
    if current_user
      mail_to "ikat@helpful.io", text, "data-helpful" => "ikat", "data-helpful-modal" => "on", "data-helpful-name" => current_user.name, "data-helpful-email" => current_user.email
    else
      mail_to "ikat@helpful.io", text, "data-helpful" => "ikat", "data-helpful-modal" => "on"
    end
  end

  # An outgoing link. Adds an icon and makes it open a new window.
  def outgoing_link_to(text, url, options = {})
    classes = 'outgoing '

    if options[:class]
      classes = classes + options[:class]
    end

    link_to url, class: classes, target: '_blank' do
      "#{text} <i class='ss-icon'>out</i>".html_safe
    end
  end
end
