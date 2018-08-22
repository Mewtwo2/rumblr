class CreatePostsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
        t.string :title
        t.text :text_content
        t.belongs_to :user, index: true
    end
  end
end
