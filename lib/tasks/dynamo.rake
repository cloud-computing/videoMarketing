namespace :dynamo do
  desc "TODO"
  task create_tables: :environment do
    puts "DynamoDB Deletion"

    #@vi = Video.all
    #@vi.each do |vi|
    #  vi.delete()
    #end
    puts "Video Deleted"

    puts ""
    puts "DynamoDB Creation"

    video = Video.create_table
    puts "Video table created"

    user = User.create_table
    puts "User table created"
  end

end
