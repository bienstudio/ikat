module BookmarkletHelper

  # Get the correct bookmarklet URL for the environment.
  def bookmarklet_url
    add_digest = Rails.application.assets.find_asset('bookmarklet/load.js').digest
    add_path = ActionController::Base.helpers.asset_path("bookmarklet/load.js")

    add_path.slice!("-#{add_digest}") # account for dash

    "javascript:void((function()%7Bvar hsb%3Ddocument.createElement(%27script%27)%3Bhsb.setAttribute(%27src%27,%27#{add_path}%27)%3Bhsb.setAttribute(%27type%27,%27text/javascript%27)%3Bdocument.getElementsByTagName(%27head%27)%5B0%5D.appendChild(hsb)%3B%7D)())%3B"
  end
end
