class CheckoutsController < ApplicationController
  layout 'checkout'

  def cancel_callback
    @order = Order.find_by(code: params[:order_code])
    @order.update(payment_status: :cancelled)
  end

  def notify_callback
  end

  def return_callback
    @order = Order.find_by(code: params[:order_code])
    @order.update(payment_status: :paid)
  end
end
