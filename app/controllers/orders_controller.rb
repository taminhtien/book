class OrdersController < ApplicationController
  def show
    @order = Order.find_by(code: params[:id])

    if @order.nil?
      render :file => 'public/404.html', :status => :not_found, :layout => false
    else
      @checkout_url = NganLuong::Payment.get_checkout_url(
        order_code: @order.code,
        price: @order.price,
        currency: @order.currency,
        quantity: @order.quantity,
        tax: @order.tax,
        discount: @order.discount,
        fee_cal: @order.fee_cal,
        fee_shipping: @order.fee_shipping,
        buyer_info: @order.buyer_info,
        order_description: @order.description,
        cancel_url: cancel_callback_checkout_url(order_code: @order.code),
        return_url: return_callback_checkout_url,
        notify_url: notify_callback_checkout_url,
      )
    end
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to order_url(@order.code), notice: "Order was successfully created." }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def order_params
    params.require(:order).permit(:name, :phone_number, :shipping_address, :quantity, :bank_account_number, :bank_name)
  end
end
