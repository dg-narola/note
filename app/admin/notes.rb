# frozen_string_literal: true

ActiveAdmin.register Note do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
#permit_params :title, :description, :status
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
  column :title
  column :description
  column :status
  column :user
  column :important
  column :created_at
  column :updated_at
end

end
