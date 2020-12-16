class Admin::CategoriesController < Admin::BaseController

	before_action :find_root_categories, only: []
  before_action :find_category, only: []

  def index
  	if params[:id].blank?
  		@categories = Category.roots.page(params[:page] || 1).per_page(params[:per_page] || 10).order(id: "desc")
  	else
  		@category = Category.find(params[:id])
  		@categories = @category.children.page(params[:page] || 1).per_page(params[:per_page] || 10).order(id: "desc")
  	end

  end

  def new
  	@category = Category.new
  	@root_categories = Category.roots.order(id:"desc")#现有一🐔分类
  end

  def create#🛏️建分类
  	@category = Category.new(params.require(:category).permit!)
  	@root_categories = Category.roots.order(id:"desc")#现有一🐔分类
  	if @category.save
  		flash[:notice] ="保存成功，🐂🍺"
  		redirect_to admin_categories_path
  	else
  		render action: :new
  	end
  end

  def edit#编🐔分类
  	@category = Category.find(params[:id])
  	@root_categories = Category.roots.order(id:"desc")#现有一🐔分类
  	render action: :new
  end

  def update#更🆕分类
  	@category = Category.find(params[:id])
  	@root_categories = Category.roots.order(id:"desc")#现有一🐔分类
  	@category.attributes = params.require(:category).permit!
  	if @category.save
  		flash[:notice] ="修改成功👌"
  		redirect_to admin_categories_path
  	else
  		render action: :new
  	end
  end

  def show#为了解决某奇怪的bug，虽然名字叫show，实际上是⛰️除；
  	@category = Category.find(params[:id])
  	if @category.destroy
  		flash[notice] = "删除成功😊"
  		redirect_to admin_categories_path
  	else
  		flash[:notice] = "删除失败😭"
  		redirect_to :back #退回上1⃣️个页面
  	end

  end
  private
  def find_root_categories
    @root_categories = Category.roots.order(id: "desc")
  end

  def find_category
    @category = Category.find(params[:id])
  end


end
