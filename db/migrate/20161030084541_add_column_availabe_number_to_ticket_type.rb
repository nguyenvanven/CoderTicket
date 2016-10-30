class AddColumnAvailabeNumberToTicketType < ActiveRecord::Migration
  def change
    add_column :ticket_types, :available_number, :integer
  end
end
