class CreateTicketTicketTypes < ActiveRecord::Migration
  def change
    create_table :ticket_ticket_types do |t|
      t.integer :ticket_id
      t.integer :ticket_type_id
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
