class ProfilesController < ApplicationController
  before_action :find_user

  def show
  end

  def update
    @subscribe = current_user.subscriptions.build
    @subscribe.update(friend_id: @user.id)
    if @subscribe.save
      redirect_to profile_path(@user), notice: 'true'
    else
      redirect_to profile_path(@user), notice: 'false'
    end
  end

  def destroy
    @unsubscribe
  end

  private

    def find_user
      @user = User.find(params[:id])
    end
end
