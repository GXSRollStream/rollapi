class ResourceSerializer < ActiveModel::Serializer
  attributes :id, :api_key, :target_kind, :target_type, :target_id
end
