class CreatePostsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
        t.string :title
        t.string :text_content
    end
  end
end
