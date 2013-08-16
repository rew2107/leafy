class RegistrationsController < Devise::RegistrationsController
  def update
    # required for settings form to submit when password is left blank
    if params[:user][:password].blank?
      params[:user].delete("password")
      params[:user].delete("password_confirmation")
    end

    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    if resource.update_attributes(resource_params)
      if is_navigational_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      sign_in resource_name, resource, :bypass => true
      redirect_to after_update_path_for(resource)
    else
      clean_up_passwords resource
      render "edit"
    end
  end

  def edit
    number_of_new_foreign_products = FavoriteProduct::MAX_ALLOWED_PER_TYPE - resource.foreign_favorites.count
    number_of_new_local_products = FavoriteProduct::MAX_ALLOWED_PER_TYPE - resource.local_favorites.count

    number_of_new_local_products.times { resource.local_favorites.build }
    number_of_new_foreign_products.times { resource.foreign_favorites.build }
    render :edit
  end
end
