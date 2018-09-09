require 'rails_helper'

describe TransactionsController do
  login_user

  describe 'GET new' do
    it 'should render correct template' do
      get :new
      assert_response :success
    end
  end

   describe 'POST create' do
    it 'should return 200' do
      user_recipient = create(:user)
      post :create, params: { transaction: { amount: 25 }, user_id: user_recipient.id }

      assert_response :redirect
    end
  end
end