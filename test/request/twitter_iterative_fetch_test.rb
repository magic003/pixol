require File.expand_path(File.dirname(__FILE__)) + '/../helper'

require 'piper'

describe 'TwitterIterativeFetch test' do
  before do
    @app = Pixol::Request::TwitterIterativeFetch.new(Proc.new {})
    @env = Piper::Env.new
  end

  it 'should raise exception if since_id is not set' do
    proc { @app.call(@env) }.must_raise RuntimeError
  end

  it 'should raise exception if request is not set' do
    @env.extra[:since_id] = '0'
    proc { @app.call(@env) }.must_raise RuntimeError
  end

  it 'should raise exception if there is not response' do
    @env.request = Piper::Request.new(:get, '/foo')
    proc { @app.call(@env) }.must_raise RuntimeError
  end

  # TODO: test the normal case after it is implemented
end
