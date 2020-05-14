class ProfilesController < ApplicationController
  before_action :find_user
  before_action :double_sub,   only: [:subscribe]
  before_action :double_unsub, only: [:unsubscribe]
  before_action :sub_action_with_my_profile, except: [:show]
  before_action :authenticate_user!, except: [:show]

  def show
  end

  def subscribe
    current_user.subscriptions.create(friend_id: @user.id)
    redirect_to profile_path(@user), notice: 'subscribe'
  end

  def unsubscribe
    unsubscribe = current_user.subscriptions.find_by(friend_id: @user.id)
    unsubscribe.destroy
    redirect_to profile_path(@user), notice: 'unsubscribe'
  end

  private

    def double_sub
      redirect_to profile_path(@user) if current_user.subscriptions.exists?(friend_id: @user.id)
    end

    def double_unsub
      redirect_to profile_path(@user) unless current_user.subscriptions.exists?(friend_id: @user.id)
    end

    def sub_action_with_my_profile
      redirect_to profile_path(@user) if current_user == @user
    end

    def find_user
      @user = User.find(params[:id])
    end
end
