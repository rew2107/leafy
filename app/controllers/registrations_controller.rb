class RegistrationsController < Devise::RegistrationsController
  def update
    # required for settings form to submit when password is left blank
    if params[:user][:password].blank?
      params[:user].delete("password")
      params[:user].delete("password_confirmation")
    end

    @user = User.find(current_user.id)
    if @user.update_attributes(params[:user])
      set_flash_message :notice, :updated
      # Sign in the user bypassing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to after_update_path_for(@user)
    else
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
