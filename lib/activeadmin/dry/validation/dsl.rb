module ActiveAdmin
  module Dry
    module Validation
      module DSL
        def schema(outer_schema: nil, &block)
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
              build_resource
              schema.call(resource_params.first.to_h).errors.each do |rule, messages|
                messages.each { |message| resource.errors.add(rule, message) }
              end
              return render :new unless resource.errors.empty?
            end
          end
        end
      end
    end
  end
end
