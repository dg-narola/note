# frozen_string_literal: true

ActiveAdmin.register Sharenote do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end


index do
  column :id
  column :email
  column :user
  column :note
  column :description
  column :edit
  column :view
  column :created_at
  column :updated_at
end

end
