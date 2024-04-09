class LetsencryptJob
  include Sidekiq::Job
  sidekiq_options queue: :certificates, backtrace: true

  def perform(*args)
    # Do something
    logger.info 'Performing MyJob'
    puts args
  end
end
