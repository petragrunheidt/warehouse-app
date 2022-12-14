class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order_and_check_user, only: [:show, :edit, :update, :set_pending, :set_canceled, :set_delivered]
  def index
    @orders = current_user.orders
  end

  def show; end

  def new
    @order = Order.new
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end

  def create
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
    order_params = params.require(:order).permit(:warehouse_id, :supplier_id, :estimated_delivery_date)
    @order = Order.new(order_params)
    @order.user = current_user
    if @order.save
      redirect_to @order, notice: 'Pedido registrado com sucesso.'
    else
      render:new
    end
  end

  def search
    @query = params["query"]
    @orders = Order.where("code LIKE ?", "%#{@query}%")
  end

  def edit
    @warehouses = Warehouse.all
    @suppliers = Supplier.all

  end

  def update

    order_params = params.require(:order).permit(:warehouse_id, :supplier_id, :estimated_delivery_date)
    if @order.update(order_params)
      return redirect_to @order, notice: 'Pedido Atualizado com Sucesso.'
    else
      @warehouses = Warehouse.all
      @suppliers = Supplier.all
      render :new
    end
  end

  def set_delivered
    @order.delivered!
    @order.order_items.each do |item|
      item.quantity.times do
        StockProduct.create!(order: @order, product_model: item.product_model, warehouse: @order.warehouse)
      end
    end

    return redirect_to @order, notice: 'Status do Pedido atualizado.'
  end

  def set_canceled
    @order.canceled!
    return redirect_to @order, notice: 'Status do Pedido atualizado.'
  end

  private

  def set_order_and_check_user
    @order = Order.find(params[:id])
    if @order.user != current_user
      return redirect_to root_path, notice: "Permissão negada, pedido de outro usuário"
    end
  end
end


