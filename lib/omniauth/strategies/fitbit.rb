require 'omniauth'
require 'omniauth/strategies/oauth'

module OmniAuth
  module Strategies
    class Fitbit < OmniAuth::Strategies::OAuth

      option :name, "fitbit"

      option :client_options, {
          :site => 'http://api.fitbit.com',
          :request_token_path => '/oauth/request_token',
          :access_token_path => '/oauth/authorize',
          :authorize_path => '/oauth/oauth_allow'
      }

      uid do
        request.params['oauth_token']
        puts ">>>>>>>>>>>>>>>>>>>>>>>>>>> REQUEST PARAMS: #{request.params.to_s}"
        puts ">>>>>>>>>>>>>>>>>>>>>>>>>>> ACCESS TOKEN: #{access_token.to_s}"
      end

      info do
        {
            :display_name => raw_info #['user']['displayName']
        }
      end

      extra do
        { 
            :raw_info => raw_info 
        }
      end

      def raw_info
        #@raw_info ||= MultiJson.load(access_token.get("http://api.fitbit.com/1/user/-/profile.json").body)
        @raw_info ||= MultiJson.load(access_token.get("http://api.fitbit.com/1/user/-/profile.json").body)
        puts ">>>>>>>>>>>>>>>>>>>>>>>>>>> RAW INFO: #{raw_info.to_s}"
      end
    end
  end
end