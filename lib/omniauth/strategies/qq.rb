require "omniauth-oauth2"
module OmniAuth
  module Strategies
    class Qq < OmniAuth::Strategies::OAuth2
      option :client_options, {
        :site            => "https://graph.qq.com",
        :authorize_url   => "/oauth2.0/authorize",
        :token_method    => :get,
        :token_url       => "/oauth2.0/token",
        :token_formatter => lambda {|hash|
          hash[:expires_in]    = hash['expires_in'].to_i
          hash.delete('expires_in')
        }
      }

      option :authorize_params, {
        :response_type => "code"
      }

      option :authorize_options, []
      option :token_params,      {
        :grant_type => "authorization_code",
        :parse => :query,
        :state => "state"
      }
      option :token_options,     []

      uid do
        response = access_token.get(
          '/oauth2.0/me'
        )
        data = MultiJson.decode(response.body.gsub(/callback\(/, "").gsub(/\);\n/, "").strip, :symbolize_keys => true)
        @user_id = data[:openid]
      end

      info do
        {
          :nickname => raw_info['nickname'],
          :avatar => raw_info['figureurl_1'],
          :gender => raw_info['gender']
        }
      end

      extra do
        {
          :raw_info => raw_info
        }
      end

      def raw_info
        response =  access_token.get(
          '/user/get_user_info', {:params => {:openid => @user_id, :oauth_consumer_key => access_token.client.id, :format => :json}, :parse => :json}
        ).parsed
      end

      def build_access_token
        verifier = request.params['code']
        client.auth_code.get_token(
          verifier,
          {:redirect_uri => callback_url}.merge(token_params.to_hash(:symbolize_keys => true)),
          {:mode => :query, :param_name => 'access_token'}
        )
      end
    end
  end
end

