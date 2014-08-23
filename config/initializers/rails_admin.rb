RailsAdmin.config do |config|
  config.authenticate_with do
    if current_user
      redirect_to '/' unless current_user.admin?
    else
      redirect_to '/login'
    end
  end
  config.current_user_method { current_user }

  config.actions do
    dashboard
    index
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app
  end
end
