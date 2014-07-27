module Ikat
  class API
    get '/users/:id/collections.json' do
      @collections = User.find(params[:id]).collections

      rabl :'users/collections/index'
    end
  end
end
