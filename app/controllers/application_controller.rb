class ApplicationController < ActionController::Base
    def user_order
        if current_user
            order = Cart.where(user_id: current_user.id).where(state:
            "created").last
            if order.nil?
                order = Cart.create(user: current_user, state: "created")
            end
            return order
        end
    end
end
