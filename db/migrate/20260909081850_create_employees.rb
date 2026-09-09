class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.string :name, null: false
      t.references :department, null: false, foreign_key: true
      t.date :expected_delivery_date, null: false
      t.date :delivery_date
      t.date :maternity_leave_start_date
      t.date :maternity_leave_end_date
      t.date :childcare_leave_start_date
      t.date :childcare_leave_end_date

      t.timestamps
    end
  end
end
