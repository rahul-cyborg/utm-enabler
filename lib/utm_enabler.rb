require "utm_enabler/version"
require "utm_enabler/railtie" if defined?(Rails)
require "rubygems"
require "active_record"

module UtmEnabler

  def wtire_params(cookies)
    if cookies[:utm_source]
      CampaignDatum.create(:user_id => id,:utm_source => cookies[:utm_source],:utm_medium => cookies[:utm_medium],
        :utm_term => cookies[:utm_term],:utm_content => cookies[:utm_content],:utm_campaign => cookies[:utm_campaign],
        :channel => cookies[:channel])
    end
  end
  
  class UtmEnabler 
    def initialize(app)
      @app = app
    end 
   
    def call(env)
       request = Rack::Request.new(env)
       if request.params['utm_source'] && request.cookies['utm_source'].nil?
           status, headers, body = @app.call(env)
           response = Rack::Response.new body, status, headers
           set_parmas_cookie(response, request.params)
           response.finish 
      else
          @app.call(env)
      end
    end 

    def set_parmas_cookie(response, params)
      response.set_cookie("utm_source", {:value => params['utm_source'], :expires => Time.now+360*24*60*60})
      response.set_cookie("utm_medium", {:value => params['utm_medium'], :expires => Time.now+360*24*60*60})
      response.set_cookie("utm_term", {:value => params['utm_term'], :expires => Time.now+360*24*60*60})
      response.set_cookie("utm_content", {:value => params['utm_content'], :expires => Time.now+360*24*60*60})
      response.set_cookie("utm_campaign", {:value => params['utm_campaign'], :expires => Time.now+360*24*60*60})
      response.set_cookie("channel", {:value => params['channel'], :expires => Time.now+360*24*60*60})
    end
  end
end

