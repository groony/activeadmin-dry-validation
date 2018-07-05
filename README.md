# Activeadmin::Dry::Validation

[![Gem Version](https://badge.fury.io/rb/activeadmin-dry-validation.svg)](https://badge.fury.io/rb/activeadmin-dry-validation) ![travis](https://travis-ci.com/groony/activeadmin-dry-validation.svg?branch=master)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'activeadmin-dry-validation'
```

## Usage

```ruby
ActiveAdmin.register SomeResource do
  permit_params :title, :announcement, :some_attr
  
  schema do
    required(:announcement).filled(:str?)
    required(:title).filled(:str?)
    required(:some_attr).filled(:str?)
  end
  
  form do |f|
    f.semantic_errors(*f.object.errors.keys)
    f.inputs do
      f.input :title
      f.input :announcement, as: :text
    end
  end
end
```

If you have outer schema you can use it too

```ruby
outer_schema = ::Dry::Validation.Schema(::Dry::Validation::Schema::Params) do
  required(:announcement).filled(:str?)
  required(:title).filled(:str?)
  required(:some_attr).filled(:str?)
end

schema(outer_schema: outer_schema)
```

### Customizing error messages

Create `config/initializers/dry-validation.rb`


```ruby
Dry::Validation::Schema::Params.configure do |config|
  config.messages_file = Rails.root.join('config', 'locales', 'errors.yml')
end
```

Create `config/locales/errors.yml` from [source](https://github.com/dry-rb/dry-validation/blob/master/config/errors.yml).

Now you can customize basic errors.


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/groony/activeadmin-dry-validation.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
