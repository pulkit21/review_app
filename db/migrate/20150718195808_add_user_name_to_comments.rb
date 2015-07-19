class AddUserNameToComments < ActiveRecord::Migration
  def change
    add_column :comments, :user_name, :string
    add_column :comments, :negative_analysis, :string
    add_column :comments, :positive_analysis, :string
    add_column :comments, :neutral_analysis, :string
    add_column :comments, :analysis_label, :string
  end
end
