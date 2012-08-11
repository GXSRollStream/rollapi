require 'spec_helper'


describe Resource, "#transalte" do
  it "should map find to get" do
    r = Resource.new(request_method: 'find')
    r.api_method.should eq('get')
  end

  it "should map search to post" do
    r = Resource.new(request_method: 'search')
    r.api_method.should eq('post')
  end

  it "should map create to post" do
    r = Resource.new(request_method: 'create')
    r.api_method.should eq('post')
  end

  it "should map update to put" do
    r = Resource.new(request_method: 'update')
    r.api_method.should eq('put')
  end
end

describe Resource, "#require_target_id" do
  it "when request is find" do
    r = Resource.new(request_method: 'find')
    r.should be_member_method
  end

  it "when request is update" do
    r = Resource.new(request_method: 'update')
    r.should be_member_method
  end

  it "when request is search" do
    r = Resource.new(request_method: 'search')
    r.should_not be_member_method
  end

  it "when request is create" do
    r = Resource.new(request_method: 'create')
    r.should_not be_member_method
  end
end

describe Resource, "#api_url" do
  it "should construct get url" do
    r = Resource.new({ request_method: 'find', 
                       request_id: 1, 
                       request_owner: 'company', 
                       url: 'http://localhost:3000'})

    r.api_url.should eql('http://localhost:3000/api/v2000/company/1')
  end

  it "should construct update url" do
    r = Resource.new({ request_method: 'update', 
                       request_id: 1, 
                       request_owner: 'company', 
                       url: 'http://localhost:3000'})

    r.api_url.should eql('http://localhost:3000/api/v2000/company/1')
  end

  it "should construct create url" do
    r = Resource.new({ request_method: 'create', 
                       request_id: 1, 
                       request_owner: 'company', 
                       url: 'http://localhost:3000'})

    r.api_url.should eql('http://localhost:3000/api/v2000/company')
  end

  it "should construct search url" do
    r = Resource.new({ request_method: 'search', 
                       request_id: 1, 
                       request_owner: 'company', 
                       url: 'http://localhost:3000'})

    r.api_url.should eql('http://localhost:3000/api/v2000/company')
  end
end

describe Resource, "#search", vcr: { cassette_name: "get-succ", record: :new_episodes } do
  it "with successful request" do
    r = Resource.new({ request_method: 'find', 
                       request_id: 1, 
                       api_key: 'apiKey',
                       user: 'joe_user@example.org',
                       password: 'Newpassword212',
                       request_owner: 'contact', 
                       url: 'http://localhost:3000'})
    r.search

    r.response_code.should  eq(200)
  end
end

describe Resource, "#search", vcr: { cassette_name: "get-auth", record: :new_episodes } do
  it "with authorization error" do
    r = Resource.new({ request_method: 'find', 
                       request_id: 1, 
                       api_key: 'apiKey',
                       user: 'joe_user@example.org',
                       password: 'Newpassword21',
                       request_owner: 'contact', 
                       url: 'http://localhost:3000'})
    r.search

    r.response_code.should  eq(401)
  end
end

describe Resource, "#search" do
  it "with successful request" do
    r = Resource.new({ request_method: 'find', 
                       request_id: 1, 
                       api_key: 'apiKey',
                       user: 'joe_user@example.org',
                       password: 'Newpassword212',
                       request_owner: 'contact' })
    r.search

    r.response_code.should  eq(500)
  end
end

describe Resource, "#search", vcr: { cassette_name: "get-auth", record: :new_episodes } do
  it "with authorization error" do
    r = Resource.new({ request_method: 'find', 
                       request_id: 1, 
                       api_key: 'apiKey',
                       user: 'joe_user@example.org',
                       password: 'Newpassword21',
                       request_owner: 'contact', 
                       url: 'http://localhost:3000'})
    r.search

    r.response_code.should  eq(401)
  end
end
