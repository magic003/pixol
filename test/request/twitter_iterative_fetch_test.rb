require File.expand_path(File.dirname(__FILE__)) + '/../helper'

require 'piper'

class TwitterIterativeFetchTest < Test::Unit::TestCase
  def test_call
    app = Pixol::Request::TwitterIterativeFetch.new(Proc.new {})
    env = Piper::Env.new
    assert_raise RuntimeError do
      app.call(env)
    end

    env.extra[:since_id] = '0'
    assert_raise RuntimeError do
      app.call(env)
    end

    env.request = Piper::Request.new(:get, '/foo')
    assert_raise RuntimeError do
      app.call(env)
    end

    # TODO: test the normal case after it is implemented
  end
end
