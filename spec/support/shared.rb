RSpec.shared_examples 'json result' do
  specify 'returns JSON' do
    api_call params, headers
    expect { JSON.parse(response.body) }.not_to raise_error
  end
end

RSpec.shared_examples 'contains error msg' do |msg|
  specify "error msg is #{msg}" do
    api_call params, headers
    json = JSON.parse(response.body)
    expect(json['error_msg']).to eq(msg)
  end
end

RSpec.shared_examples '200' do
  specify 'returns 200' do
    api_call params, headers
    expect(response.status).to eq(200)
  end
end

RSpec.shared_examples '400' do
  specify 'returns 400' do
    api_call params, headers
    expect(response.status).to eq(400)
  end
end

RSpec.shared_examples '401' do
  specify 'returns 401' do
    api_call params, headers
    expect(response.status).to eq(401)
  end
end

RSpec.shared_examples '404'  do |msg|
  specify 'returns 404' do
    api_call params, headers
    json = JSON.parse(response.body)
    expect(response.status).to eq(404)
    expect(json['message']).to eq(msg)
  end
end

RSpec.shared_examples 'returns MissingJwtToken' do |msg|
  specify 'returns MissingJwtToken' do
    api_call params, {}
    json = JSON.parse(response.body)
    expect(response.status).to eq(403)
    expect(json['error']['message']).to eq(msg)
  end
end

RSpec.shared_examples 'returns InvalidToken when jti not exist' do |msg|
  specify 'returns InvalidToken when jti not exist' do
    invalid_token = JWT.encode(encoded_jwt_params.except(:jti), Rails.application.secrets.secret_key_base)
    api_call(params, { 'Authorization' => "Bearer #{invalid_token}" })
    json = JSON.parse(response.body)
    expect(response.status).to eq(403)
    expect(json['error']['message']).to eq(msg)
  end
end

RSpec.shared_examples 'returns InvalidToken when user_id not exist' do |msg|
  specify 'returns InvalidToken when user_id not exist' do
    invalid_token = JWT.encode(encoded_jwt_params.except(:user_id), Rails.application.secrets.secret_key_base)
    api_call(params, { 'Authorization' => "Bearer #{invalid_token}" })
    json = JSON.parse(response.body)
    expect(response.status).to eq(403)
    expect(json['error']['message']).to eq(msg)
  end
end

RSpec.shared_examples 'returns AuthorizationFailed' do |msg|
  specify 'returns AuthorizationFailed' do
    invalid_token = JWT.encode(
      encoded_jwt_params.merge(jti: 'invalid_jti'),
      Rails.application.secrets.secret_key_base
    )
    api_call(params, { 'Authorization' => "Bearer #{invalid_token}" })
    json = JSON.parse(response.body)
    expect(response.status).to eq(401)
    expect(json['error']['message']).to eq(msg)
  end
end
