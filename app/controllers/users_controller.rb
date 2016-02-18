class UsersController < ApplicationController
  get '/:id' do
    if current_user
      begin
        @user = User.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        nil
      end
      site_statistics
      user_statistics
      slim :'users/index'
    else
      redirect("/auth/log_in")
    end
  end
end
