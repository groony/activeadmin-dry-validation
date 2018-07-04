ActiveAdmin.register Article do
  permit_params :title, :announcement

  config.batch_actions = false

  schema do
    configure do
      config.type_specs = true
    end
    required(:announcement).filled(:str?)
    required(:title).filled(:str?)
  end

  filter :id
  filter :title

  index do
    id_column
    column :title
  end

  form do |f|
    f.semantic_errors(*f.object.errors.keys)
    f.inputs do
      f.input :title
      f.input :announcement, as: :text
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :title
      row :announcement
    end
  end
end
