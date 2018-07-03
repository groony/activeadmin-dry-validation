
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "activeadmin/dry/validation/version"

Gem::Specification.new do |spec|
  spec.name          = "activeadmin-dry-validation"
  spec.version       = ActiveAdmin::Dry::Validation::VERSION
  spec.authors       = ["Ivan Novikov"]
  spec.email         = ["ivan.novikov@saltpepper.ru"]

  spec.summary       = "Validate your ActiveAdmin resources through dry-validation"
  spec.homepage      = "https://github.com/groony/activeadmin-dry-validation"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activeadmin"
  spec.add_runtime_dependency "dry-validation", "~> 0.12", ">= 0.12.0"
  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
