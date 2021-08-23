class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      # references型で保存すると、user_idを外部キーとして明示的に指定できる
      t.string :caption
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
  end
end
