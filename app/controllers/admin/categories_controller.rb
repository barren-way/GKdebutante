class Admin::CategoriesController < Admin::BaseController

  def index
  	@categories = Category.roots.page(params[:page] || 1).per_page(params[:per_page] || 10).order(id: "desc")

  end

  def new
  	@category = Category.new
  	@root_categories = Category.roots.order(id:"desc")#现有一🐔分类
  end

  def create
  	@category = Category.new(params.require(:category).permit!)
  	@root_categories = Category.roots.order(id:"desc")#现有一🐔分类
  	if @category.save
  		flash[:notice] ="保存成功"
  		redirect_to admin_categories_path
  	else
  		render action: :new
  	end
  end
end
