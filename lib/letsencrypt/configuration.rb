# frozen_string_literal: true

module LetsEncrypt
  # :nodoc:
  class Configuration
    include ActiveSupport::Configurable

    config_accessor :use_staging do
      !Rails.env.production?
    end
    config_accessor :private_key_path
    config_accessor :use_env_key do
      false
    end

    config_accessor :save_to_redis
    config_accessor :redis_url

    config_accessor :certificate_model do
      'LetsEncrypt::Certificate'
    end

    # Returns true if enabled `save_to_redis` feature
    def use_redis?
      save_to_redis == true
    end

    # Returns true if under development mode.
    def use_staging?
      use_staging
    end
  end
end

