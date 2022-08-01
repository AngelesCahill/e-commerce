class CartsController < ApplicationController
    before_action :authenticate_admin!
    before_action :authenticate_user!

    def update
        product = params[:cart][:product_id]
        quantity = params[:cart][:quantity]
        user_order.add_product(product, quantity)
        redirect_to root_url, notice: "Product added successfuly"
    end
    def show
        @order = user_order
    end

    def pay_with_paypal
        cart = CartsController.find(params[:cart][:cart_id])
        #price must be in cents
        price = cart.total * 100
        response = EXPRESS_GATEWAY.setup_purchase(price,
            ip: request.remote_ip,
            return_url: process_paypal_payment_cart_path_url,
            cancel_return_url: root_url,
            allow_guest_checkout: true,
            currency: "USD"
        )
        payment_method = PaymentMethod.find_by(code: "PEC")
            Payment.create(
            order_id: cart.id,
            payment_method_id: payment_method.id,
            state: "processing",
            total: cart.total,
            token: response.token
            )
            redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
        end


        def process_paypal_payment
            details = EXPRESS_GATEWAY.details_for(params[:token])
            express_purchase_options =
            {
            ip: request.remote_ip,
            token: params[:token],
            payer_id: details.payer_id,
            currency: "USD"
            }
            price = details.params["order_total"].to_d * 100
            response = EXPRESS_GATEWAY.purchase(price, express_purchase_options)
            if response.success?
                payment = Payment.find_by(token: response.token)
                cart = payment.cart
                payment.state = "completed"
                cart.state = "completed"
                ActiveRecord::Base.transaction do
                    order.save!
                    payment.save!
                    your_account.add(10)
                    my_account.substract(10)
                end
            end
        end

end
