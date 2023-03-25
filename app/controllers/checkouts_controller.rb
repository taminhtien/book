class CheckoutsController < ApplicationController
  layout 'checkout'

  def cancel_callback
    @order = Order.find_by(code: params[:order_code])

    if @order
      @order.update(payment_status: :cancelled)
    else
      render :file => 'public/404.html', :status => :not_found, :layout => false
    end
  end

  def notify_callback
    @order = Order.find_by(code: params[:order_code])

    if NganLuong::Payment.valid_return_request?(params[:transaction_info], params[:order_code], params[:price], params[:payment_id], params[:payment_type], params[:error_text], params[:secure_code])
      @order.update(payment_status: :paid)
    end

    render plain: "1"
  end

  def return_callback
    @order = Order.find_by(code: params[:order_code])

    if NganLuong::Payment.valid_return_request?(params[:transaction_info], params[:order_code], params[:price], params[:payment_id], params[:payment_type], params[:error_text], params[:secure_code])
      @order.update(payment_status: :paid)
    else
      redirect_to cancel_callback_checkout_path(order_code: params[:order_code])
    end
  end
end
