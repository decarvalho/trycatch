class AddTempPasswordToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :temp_password, :integer
  end
end
