module RequestSpecHelper
  def json_response
    JSON.parse(response.body)
  end

  def struct_response
    return json_to_struct unless array_response?
    json_array_to_struct
  end

  private

  def json_to_struct
    OpenStruct.new(json_response)
  end

  def json_array_to_struct
    json_response.map do |json|
      OpenStruct.new(json)
    end
  end

  def array_response?
    json_response.is_a? Array
  end
end
