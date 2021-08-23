class UsersController < ApplicationController

  # userアクションを追加
  def show
    @user = User.find_by(id: params[:id])
  end

end
