module Ikat
  class API
    before do
      authorize!
    end

    # GET /collections.json
    #
    # Get the collections for the authenticated user.
    get '/collections.json' do
      @collections = auth_user.collections

      rabl :'collections/index'
    end

    # POST /collections.json
    #
    # Create a new Collection for the authenticated user.
    post '/collections.json' do
      action = CollectionCreate.run(
        current_user: auth_user,
        collection: params[:collection]
      )

      if action.success?
        @collection = action.result

        rabl :'collections/show'
      else
        return action.errors.to_json
      end
    end
  end
end
