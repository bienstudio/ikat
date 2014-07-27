module Ikat
  class API
    get '/products/:id.json' do
      @product = Product.find(params[:id])

      rabl :'products/show'
    end

    post '/products/add.json' do
      params[:product][:category] = Category.find(params[:product][:category][:id])

      action = ProductAdd.run(
        current_user: auth_user,
        product: params[:product],
        list: List.find(params[:list][:id])
      )

      @product = action.result

      rabl :'products/show'
    end
  end
end
