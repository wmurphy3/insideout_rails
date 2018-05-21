require 'active_model_serializers'

ActiveModel::Serializer.config.adapter = :json_api
ActiveModel::Serializer.config.key_transform = :underscore
ActiveModel::Serializer.config.jsonapi_resource_type = :singular
ActiveModel::Serializer.config.serializer_lookup_enabled = false

ActiveSupport::Notifications.unsubscribe(ActiveModelSerializers::Logging::RENDER_EVENT)
