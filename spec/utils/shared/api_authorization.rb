shared_examples_for 'API Authorizable' do
  context 'unauthorized' do
    it 'returns 401 if no access_token' do
      do_request(method, api_path, headers: headers)
      expect(response.status).to eq 401
    end

    it 'returns 401 if access_token invalid' do
      do_request(method, api_path, params: { access_token: '1' }, headers: headers)
      expect(response.status).to eq 401
    end
  end
end

shared_examples_for 'Return successful' do
  it 'return 200 status' do
    expect(response).to be_successful
  end
end

shared_examples 'Public fields' do
  it 'return all public fields' do
    attrs.each do |attr|
      expect(resource_response[attr]).to eq resource.send(attr).as_json
    end
  end
end
