class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  def edit
  end

  def index
    @orders = Order.all
  end

  def create
    @order_item = @order.order_items.new(quantity: 1, product_id: params[:product_id])
    
    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Successfully added product to cart.' }
        format.json { render action: 'show', status: :created, location: @order }
      else
        format.html { render action: 'new' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end

  private
    
  def set_order
    @order = Order.find(params[:id])
  end

  def load_order
    @order = Order.find_or_initialize_by_id(session[:order_id], status: "unsubmitted")
    if @order.new_record?
      @order.save!
      session[:order_id] = @order.id
    end 
  end

  def order_params
    params.require(:order).permit(:user_id, :status)
  end
end
