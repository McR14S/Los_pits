class AddHiddenToCategories < ActiveRecord::Migration[7.0]
  def change
    add_column :categories, :hidden, :boolean
  end
end
