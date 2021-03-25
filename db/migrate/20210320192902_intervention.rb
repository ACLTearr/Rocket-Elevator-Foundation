class Intervention < ActiveRecord::Migration[5.2]
  def change
    create_table :interventions do |t|
      t.references :author, foreign_key: { to_table: :employees }
      t.references :customer, foreign_key: true
      t.references :building, foreign_key: true
      t.references :battery, foreign_key: true
      t.references :column, foreign_key: true
      t.references :elevator, foreign_key: true
      t.references :employee, foreign_key: true
      t.datetime :intervention_start_date
      t.datetime :intervention_end_date
      t.string :result
      t.string :report
      t.string :status
      t.timestamps
    end
    rename_column :interventions, :author_id, :author
  end
end
