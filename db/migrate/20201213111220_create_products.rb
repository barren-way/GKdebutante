class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.integer :category_id #分类
      t.string :title#名称
      t.string :status, default: 'off' #状态
      t.integer :amount, default: 0 #库存
      t.string :uuid #编号
      t.decimal :msrp, precision: 10, scale: 2 #原价
      t.decimal :price, precision: 10, scale: 2 #现价
      t.text :description #介绍
      t.timestamps
    end

    add_index :products, [:status, :category_id]
    add_index :products, [:category_id]
    add_index :products, [:uuid], unique: true
    add_index :products, [:title]
  end
end
