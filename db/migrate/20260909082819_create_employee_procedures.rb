class CreateEmployeeProcedures < ActiveRecord::Migration[7.0]
  def change
    create_table :employee_procedures do |t|
      t.references :employee, null: false, foreign_key: true
      t.references :procedure_type, null: false, foreign_key: true
      t.date :deadline
      t.integer :status, null: false
      t.text :notes

      t.timestamps
    end

    add_index :employee_procedures,
              [:employee_id, :procedure_type_id],
              unique: true
  end
end
