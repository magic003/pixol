require File.expand_path(File.dirname(__FILE__)) + '/../helper'

require 'piper'

class TwitterHomeTimelineTest < Test::Unit::TestCase
  def test_call
    env = Piper::Env.new

    app = Pixol::Request::TwitterHomeTimeline.new(Proc.new {})
    assert_nothing_raised do
      app.call(env)
    end
    assert_not_nil env.request
    assert_equal 5, env.request.queries.size

    env.request = Piper::Request.new(:get, '/foo')
    assert_raise RuntimeError do
      app.call(env)
    end

    env.request = Piper::Request.new(nil,'/foo')
    assert_raise RuntimeError do
      app.call(env)
    end

    env.request = Piper::Request.new(nil,nil,
                                     {count:100,
                                      trim_user: false,
                                      exclude_replies: false,
                                      contributor_details: true,
                                      include_entities: false})
    assert_nothing_raised do
      app.call(env)
    end
    assert_equal 100, env.request.queries[:count]
    assert_equal false, env.request.queries[:trim_user]
    assert_equal false, env.request.queries[:exclude_replies]
    assert_equal true, env.request.queries[:contributor_details]
    assert_equal false, env.request.queries[:include_entities]
  end
end
