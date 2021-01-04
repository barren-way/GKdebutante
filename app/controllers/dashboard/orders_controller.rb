#!/usr/bin/ruby
# @Author: Marte
# @Date:   2021-01-04 18:14:12
# @Last Modified by:   Marte
# @Last Modified time: 2021-01-04 18:50:34
class Dashboard::OrdersController < Dashboard::BaseController

  def index
    @orders = current_user.orders.page(params[:page] || 1).per_page(params[:per_page] || 10)
      .includes([[:product => [:main_product_image]], :address]).order("id desc")
  end

end
