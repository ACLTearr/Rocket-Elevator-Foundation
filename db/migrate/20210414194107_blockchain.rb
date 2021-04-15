class Blockchain < ActiveRecord::Migration[5.2]
  def change
    create_table :blockchain do |t|
      t.string :contract_name
      t.string :contract_address
    end
  end
end
