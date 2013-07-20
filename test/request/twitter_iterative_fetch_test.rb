require File.expand_path(File.dirname(__FILE__)) + '/../helper'

require 'piper'

describe 'TwitterIterativeFetch test' do
  before do
    @app = Pixol::Request::TwitterIterativeFetch.new(Proc.new {})
    @env = {}
  end

  it 'should raise exception if since_id is not set' do
    proc { @app.call(@env) }.must_raise RuntimeError
  end

  it 'should raise exception if request is not set' do
    @env['piper.extra'] = {} if @env['piper.extra'].nil?
    @env['piper.extra'][:since_id] = '0'
    proc { @app.call(@env) }.must_raise RuntimeError
  end

  it 'should raise exception if there is not response' do
    @env['piper.request'] = Piper::Request.new(:get, '/foo')
    proc { @app.call(@env) }.must_raise RuntimeError
  end

  # TODO: test the normal case after it is implemented
end
