class ResourceSerializer < ActiveModel::Serializer
  attributes *(::Resource::ATTRIBUTES + [:id, :response_code, :response_body])
end
