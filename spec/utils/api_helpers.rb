module ApiHelpers
  def json
    @json ||= JSON.parse(response.body)
  end

  def do_request(method, path, options = {})
    # byebug
    send(method, path, params: options)
  end
end
