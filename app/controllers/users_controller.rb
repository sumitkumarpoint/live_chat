class UsersController < ApplicationController

  def search_users
    if request.get?
      @users = []
      if params[:term].present?
        term    = params[:term]
        @users = User.where('(lower(users.email) LIKE  :term OR lower(users.user_name) LIKE  :term) AND id != :user_id', :term => "%#{term.downcase}%",:user_id=>current_user.id)
        OnlineUsersJob.perform_later({online: true,current_user: current_user})
      end
    end
  end

end
