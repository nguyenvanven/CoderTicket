class ModifyTableEvent < ActiveRecord::Migration
  def change
    add_column :events, :publish_at, :datetime
    add_column :events, :created_by, :integer
  end
end
