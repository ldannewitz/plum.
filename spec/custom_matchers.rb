RSpec::Matchers.define :serialize_object do |object|
  match do |response|
    @serializer_klass.new(object).to_json == response.body
  end

  chain :with do |serializer_klass|
    @serializer_klass = serializer_klass
  end
end
