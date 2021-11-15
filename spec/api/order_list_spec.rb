require 'rails_helper'

describe '/api' do
  describe '/order_list' do
    let(:user) { create(:user) }
    let!(:course) { create :course }
    let(:original_params) { {} }
    let(:params) { original_params }
    let!(:headers) do
      { 'Authorization' => "Bearer #{Jwt::Encoder.new(user).encode!}" }
    end
    let!(:encoded_jwt_params) do
      {
        user_id: user.id,
        jti: user.jti,
        iat: Time.now.to_i
      }
    end

    def api_call(params, headers = {})
      get '/api/v1/order_list', params: params, headers: headers
    end

    context 'invalid request' do
      context 'authenticated failed' do
        it_behaves_like 'returns MissingJwtToken', 'Missing JWT Token'
        it_behaves_like 'returns InvalidToken when jti not exist', 'Invalid Token'
        it_behaves_like 'returns InvalidToken when user_id not exist', 'Invalid Token'
        it_behaves_like 'returns AuthorizationFailed', 'Authorization Failed'
      end

      context 'invalid params' do
        context 'invalid category' do
          let(:params) { original_params.merge(category: 'invalid_category') }
          it_behaves_like '400'
        end
        context 'invalid available' do
          let(:params) { original_params.merge(available: 5) }
          it_behaves_like '400'
        end
      end
    end

    context 'valid request' do
      context 'valid params' do
        it_behaves_like '200'
        it_behaves_like 'json result'
      end
    end
  end
end
