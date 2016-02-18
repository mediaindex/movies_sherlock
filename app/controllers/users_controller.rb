class UsersController < ApplicationController
  get '/:id' do
    if current_user
      @user = User.find(params[:id])
      site_statistics
      user_statistics
      slim :'users/index'
    else
      redirect("/auth/log_in")
    end
  end
end
