module ApiV1
  class OrderList < Grape::API
    desc 'End-points for the OrderList'
    namespace :order_list do
      desc 'List all orders of user.'
      params do
        optional :category, type: String, values: Course.categories.keys
        optional :available, type: Integer, values: [0, 1]
      end
      get do
        # Authenticate user
        authenticate!

        # Get params
        category = params[:category]
        available = params[:available]

        # Check if course is available for user
        orders = current_user.orders.send(category) if available
        orders = orders.send(category) if category

        # Return order
        status 200
        present orders, with: ApiV1::Entities::Order
      end
    end
  end
end
