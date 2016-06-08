# RSpec::Matchers.define :serialize_object do |object|
#   match do |response|
#     @serializer_klass.new(object).to_json == response.body
#   end
#
#   chain :with do |serializer_klass|
#     @serializer_klass = serializer_klass
#   end
# end

RSpec::Matchers.define :match_json_schema do |against|
  match do |object_to_be_validated|
    file_name = Rails.root.join('json_schemas', "#{against}.json").to_s

    fail "Could not find schema file #{file_name}" unless File.exist?(file_name)

    @errors = validate(file_name, object_to_be_validated)

    return true if @errors.empty?
  end

  failure_message do
    @errors.join("\n")
  end

  private

  def validate(file_name, response_or_json)
    json = if response_or_json.is_a?(ActionController::TestResponse)
                 JSON.parse(response_or_json.body).with_indifferent_access
               else
                 response_or_json
               end

    JSON::Validator.fully_validate(file_name, json)
  end
end
