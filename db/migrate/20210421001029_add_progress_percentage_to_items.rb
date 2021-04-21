class AddProgressPercentageToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :progress_percentage, :float
  end
end
