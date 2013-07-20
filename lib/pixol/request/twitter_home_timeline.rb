require 'piper'

module Pixol ; module Request
  class TwitterHomeTimeline < Piper::Middleware

    REQUEST_PATH = 'https://api.twitter.com/1.1/statuses/home_timeline.json'

    DEFAULT_OPTS = {
      count: 200,
      trim_user: true,
      exclude_replies: true,
      contributor_details: false,
      include_entities: true
    }

    def initialize(app)
      super(app)
    end

    def call(env)
      req = env['piper.request']
      if req.nil?
        req = Piper::Request.new(:get, REQUEST_PATH)
      else
        fail 'Request method is already set in env' if req.method
        fail 'Request path is already set in env' if req.path
        req.method, req.path = :get, REQUEST_PATH
      end
      
      req.queries.merge!(DEFAULT_OPTS) do |_, oldval, newval| 
        oldval.nil? ? newval : oldval
      end

      env['piper.request'] = req

      @app.call(env)
    end
  end
end ; end
