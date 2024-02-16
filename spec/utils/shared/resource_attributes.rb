shared_examples 'Public fields' do
  it 'return all public fields' do
    attrs.each do |attr|
      expect(resource_response[attr]).to eq resource.send(attr).as_json
    end
  end
end

shared_examples 'Return list' do
  it 'returns list of resources' do
    expect(resource_response.size).to eq resource.size
  end
end
