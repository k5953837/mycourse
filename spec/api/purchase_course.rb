require 'rails_helper'

describe '/api' do
  describe '/purchase_course' do
    let(:user) { create(:user) }
    let!(:course) { create :course }
    let(:original_params) { { course_id: course.id } }
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
      post '/api/v1/purchase_course', params: params, headers: headers
    end

    context 'invalid request' do
      context 'authenticated failed' do
        it_behaves_like 'returns MissingJwtToken', 'Missing JWT Token'
        it_behaves_like 'returns InvalidToken when jti not exist', 'Invalid Token'
        it_behaves_like 'returns InvalidToken when user_id not exist', 'Invalid Token'
        it_behaves_like 'returns AuthorizationFailed', 'Authorization Failed'
      end

      context 'invalid params' do
        context 'missing course_id' do
          let(:params) { original_params.except(:course_id) }
          it_behaves_like '400'
        end
        context 'invalid course_id' do
          let(:params) { original_params.merge(course_id: 0) }
          it_behaves_like '404', '404 Not found'
        end
      end

      context 'invalid use cases' do
        it 'course offline' do
          course.offline!
          api_call params, headers
          json = JSON.parse(response.body)
          expect(response.status).to eq(403)
          expect(json['error']['message']).to eq('Offline Course')
        end

        it 'user course available' do
          create(
            :order,
            user: user,
            subject: course.subject,
            category: course.category,
            snapshot: course.as_json.slice('subject', 'price', 'currency', 'category', 'url', 'description', 'duration')
          )
          api_call params, headers
          json = JSON.parse(response.body)
          expect(response.status).to eq(403)
          expect(json['error']['message']).to eq('Exist Available Course')
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
