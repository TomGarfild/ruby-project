class CreateStudents < ActiveRecord::Migration[7.0]
  def change
    create_table :students do |t|
      t.string :last_name
      t.string :first_name
      t.string :middle_name
      t.boolean :sex
      t.integer :age
      t.integer :year

      t.timestamps
    end
  end
end
