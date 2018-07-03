require "activeadmin"
require "dry-validation"
require "activeadmin/dry/validation/version"
require "activeadmin/dry/validation/dsl"

module ActiveAdmin
  module Dry
    module Validation
    end
  end
end

::ActiveAdmin::ResourceDSL.send(:include, ActiveAdmin::Dry::Validation::DSL)