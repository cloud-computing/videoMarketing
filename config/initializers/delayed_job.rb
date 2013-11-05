if Rails.env.production?
  Delayed::Worker.configure do |config|
    config.region = 'us-east-1'
    config.queue_path = '838985714596/productionQueue'
    #config.default_queue_name = 'productionQueue' # Specify an alternative default queue name
    #config.visibility_timeout = 30 # The length of time (in seconds) that a message received from a queue will be invisible to other receiving components when they ask to receive messages. Valid values: integers from 0 to 43200 (12 hours).
    #config.message_retention_period = 345600 # The number of seconds Amazon SQS retains a message. Must be an integer from 3600 (1 hour) to 1209600 (14 days). The default for this attribute is 345600 (4 days).
  end
elsif Rails.env.development?
  Delayed::Worker.configure do |config|
    config.region = 'us-east-1'
    config.queue_path = '838985714596/developmentQueue'
    #config.default_queue_name = 'developmentQueue' # Specify an alternative default queue name
    #config.visibility_timeout = 30 # The length of time (in seconds) that a message received from a queue will be invisible to other receiving components when they ask to receive messages. Valid values: integers from 0 to 43200 (12 hours).
    #config.message_retention_period = 345600 # The number of seconds Amazon SQS retains a message. Must be an integer from 3600 (1 hour) to 1209600 (14 days). The default for this attribute is 345600 (4 days).
  end
elsif Rails.env.test?
  Delayed::Worker.configure do |config|
    #config.default_queue_name = 'default' # Specify an alternative default queue name
    #config.visibility_timeout = 30 # The length of time (in seconds) that a message received from a queue will be invisible to other receiving components when they ask to receive messages. Valid values: integers from 0 to 43200 (12 hours).
    #config.message_retention_period = 345600 # The number of seconds Amazon SQS retains a message. Must be an integer from 3600 (1 hour) to 1209600 (14 days). The default for this attribute is 345600 (4 days).
  end
end