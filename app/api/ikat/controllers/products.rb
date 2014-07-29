module Ikat
  class API
    before do
      authorize!
    end

    # POST /products/add.json
    #
    # Add a Product to a List.
    post '/products/add.json' do
      params[:product][:category] = Category.find(params[:product][:category][:id])

      action = ProductAdd.run(
        current_user: auth_user,
        product: params[:product],
        list: List.find(params[:list][:id])
      )

      if action.success?
        @product = action.result

        rabl :'products/show'
      else
        return action.errors.symbolic.to_json
      end
    end
  end
end
