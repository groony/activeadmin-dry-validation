module ActiveAdmin
  module Dry
    module Validation
      module DSL
        def schema(outer_schema: nil, resource_key: nil, &block)
          if block_given?
            result = ::Dry::Validation.Schema(::Dry::Validation::Schema::Params, {}, &block)
          elsif outer_schema.present? && outer_schema.is_a?(::Dry::Validation::Schema)
            result = outer_schema
          else
            result
          end
          controller do
            before_action :ensure_schema, only: %i[create update]

            define_method(:schema) do
              result
            end

            define_method(:ensure_schema) do
              resource_key = resource_class.to_s.downcase if resource_key.blank?
              @errors = schema.(params[resource_key].to_unsafe_h).errors
              @resource = resource_class.new(permitted_params[resource_key])
              @errors.each { |rule, messages| messages.each { |message| @resource.errors.add(rule, message) } }
              return render :new if @errors.present?
            end
          end
        end
      end
    end
  end
end