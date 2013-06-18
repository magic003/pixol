require 'piper'

module Pixol ; module Request
  class TwitterIterativeFetch < Piper::Middleware
    def initialize(app)
      super(app)
    end

    def call(env)
      last_id = env.extra[:since_id]
      if last_id.nil?
        fail 'The since_id is not set'
      end

      req = env.request
      if req.nil?
        fail 'The request is not created yet'
      end

      loop do
        req.queries[:since_id] = last_id
        @app.call(env)
        res = env.response
        if res.nil? #|| res.parsed_body.nil?
          fail 'Response is not available or not successfully parsed.'
        end

        # TODO: read the latest id from response and update it in env
        break
      end
    end
  end
end ; end
