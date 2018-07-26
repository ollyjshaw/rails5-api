# frozen_string_literal: true

require 'test_helper'

class Api::PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @api_post = posts(:one)
    @user = users(:one)
  end

  test 'should get index' do
    get api_posts_url, as: :json
    assert_response :success
  end

  test 'should create api_post' do
    assert_difference('Post.count') do
      post api_posts_url,
        headers: {
          'HTTP_AUTHORIZATION' => 'Token token=WhatEva' 
        },
        params: {
          post: {
            title: 't', body: 'b'
          }
        }, as: :json
    end

    assert_response 201
  end


  test 'should fail with no params api_post' do
    assert_no_difference('Post.count') do
      post api_posts_url, headers: { 'HTTP_AUTHORIZATION' => 'Token token=WhatEva' }, params: { post: { titlex: 't', bodyx: 'b'  } }, as: :json
    end

    assert_response 422
  end
  # test 'should show api_post' do
  #   get api_post_url(@api_post), as: :json
  #   assert_response :success
  # end

  # test 'should update api_post' do
  #   patch api_post_url(@api_post), params: { api_post: {  } }, as: :json
  #   assert_response 200
  # end

  test 'should destroy api_post' do
    assert_difference('Post.count', -1) do
      delete api_post_url(@api_post), headers: { 'HTTP_AUTHORIZATION' => 'Token token=WhatEva' }, as: :json
    end
    assert_response 204
  end

  test 'should fail to find destroy api_post' do
    assert_no_difference('Post.count') do
      delete api_post_url(99), headers: { 'HTTP_AUTHORIZATION' => 'Token token=WhatEva' }, as: :json
    end
    puts api_post_url(id: 12)
    assert_response 404
  end
end
