class Category < ApplicationRecord

	validates :title, presence: {message: "名称不能为空💢"}
	validates :title, uniqueness: {message: "名称不能重复💢"}
	has_ancestry orphan_strategy: :destroy

	has_many :products, dependent: :destroy
	before_validation :correct_ancestry

	private
	def correct_ancestry
		self.ancestry = nil if self.ancestry.blank?
	end

end
