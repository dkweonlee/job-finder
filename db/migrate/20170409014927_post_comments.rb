class PostComments < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :name
      t.string :title
      t.text :descripition
      t.string :job_type
      t.string :level
      t.string :location
      t.belongs_to :user
    end

    create_table :comments do |t|
      t.belongs_to :user
      t.belongs_to :post
      t.string :comment
    end
  end
end
