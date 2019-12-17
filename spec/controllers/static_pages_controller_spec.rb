# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  describe 'GET #privacy_policy' do
    it 'returns http success' do
      get :privacy_policy
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #terms_conditions' do
    it 'returns http success' do
      get :terms_conditions
      expect(response).to have_http_status(:success)
    end
  end
end
