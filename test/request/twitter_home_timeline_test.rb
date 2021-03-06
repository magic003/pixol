require File.expand_path(File.dirname(__FILE__)) + '/../helper'

require 'piper'

describe 'TwitterHomeTimeline test' do
  before do
    @env = {}
    @app = Pixol::Request::TwitterHomeTimeline.new(Proc.new {})
  end

  it 'should create a default request if there is no one in env' do
    @app.call(@env)
    @env['piper.request'].wont_be_nil
    @env['piper.request'].queries.size.must_equal 5
  end

  it 'should raise exception if request already has a method' do
    @env['piper.request'] = Piper::Request.new(:get, '/foo')
    proc { @app.call(@env) }.must_raise RuntimeError
  end 

  it 'should raise exception if request already has a path' do
    @env['piper.request'] = Piper::Request.new(nil, '/foo')
    proc { @app.call(@env) }.must_raise RuntimeError
  end

  it 'should merge the queries if they are already set in the request' do
    @env['piper.request'] = Piper::Request.new(nil,nil,
                                       {count:100,
                                        trim_user: false,
                                        exclude_replies: false,
                                        contributor_details: true,
                                        include_entities: false})
    @app.call(@env)
    @env['piper.request'].queries[:count].must_equal 100
    @env['piper.request'].queries[:trim_user].must_equal false
    @env['piper.request'].queries[:exclude_replies].must_equal false
    @env['piper.request'].queries[:contributor_details].must_equal true
    @env['piper.request'].queries[:include_entities].must_equal false
  end
end
