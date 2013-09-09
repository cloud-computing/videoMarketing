class CreateVideos < ActiveRecord::Migration
	def change
		create_table :videos do |t|
			t.string :video
			t.string :message
			t.datetime :converted_at
			t.string :state

			t.timestamps
		end
	end
end
