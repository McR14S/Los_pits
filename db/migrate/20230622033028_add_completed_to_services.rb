class AddCompletedToServices < ActiveRecord::Migration[7.0]
  def change
    add_column :servicios, :completed, :boolean, default: false
  end
end
