class Admin::ProductsController < Admin::BaseController

  before_action :find_product, only: [:edit, :update, :show]
    before_action :fetch_home_data

  def index
    @products = Product.page(params[:page] || 1).per_page(params[:per_page] || 10)
      .order("id desc")
  end

  def new
    @product = Product.new
    @root_categories = Category.roots
  end

  def create
    @product = Product.new(params.require(:product).permit!)
    @root_categories = Category.roots

    if @product.save
      flash[:notice] = "创建成功"
      redirect_to admin_products_path
    else
      render action: :new
    end
  end

  def edit
    @root_categories = Category.roots
    render action: :new
  end

  def update
    @product.attributes = params.require(:product).permit!
    @root_categories = Category.roots
    if @product.save
      flash[:notice] = "修改成功"
      redirect_to admin_products_path
    else
      render action: :new
    end
  end

  def show#虽然叫show，但实际上是删除
    if @product.destroy
      flash[:notice] = "删除成功"
      redirect_to admin_products_path
    else
      flash[:notice] = "删除失败"
      redirect_to :back
    end
  end

  def search
    @products = Product.where("title like :title", title: "%#{params[:w]}%")
      .order("id desc").page(params[:page] || 1).per_page(params[:per_page] || 12)
      .includes(:main_product_image)

    unless params[:category_id].blank?
      @products = @products.where(category_id: params[:category_id])
    end

    render file: 'welcome/index'
  end

  private
  def find_product
    @product = Product.find(params[:id])
  end

end