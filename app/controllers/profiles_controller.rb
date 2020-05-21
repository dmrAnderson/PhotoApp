class ProfilesController < ApplicationController
  before_action :find_user
  before_action :authenticate_user!, except: [:show]
  before_action :subscribe_on_my,    only: %i[subscribe unsubscribe]
  before_action :double_sub,         only: [:subscribe]
  before_action :double_unsub,       only: [:unsubscribe]

  def show
  end

  def subscribe
    current_user.subscriptions.create(friend_id: @user.id)
    respond_to do |format|
      format.js
    end
  end

  def unsubscribe
    unsubscribe = current_user.subscriptions.find_by(friend_id: @user.id)
    unsubscribe.destroy
    respond_to do |format|
      format.js
    end
  end

  def subscribes_list
    @friends = User.where(id: current_user.subscriptions.pluck(:friend_id))
  end

  def friends_photo
    @photos = Photo.where(
      user_id:   
      current_user.subscriptions.pluck(:friend_id)
    ).paginate(page: params[:page], per_page: 5).order(created_at: :desc)
  end

  private

    def double_sub
      redirect_to profile_path(@user) if current_user.subscriptions.
                                         exists?(friend_id: @user.id)
    end

    def double_unsub
      redirect_to profile_path(@user) unless current_user.subscriptions.
                                             exists?(friend_id: @user.id)
    end

    def subscribe_on_my
      redirect_to profile_path(@user) if current_user == @user
    end

    def find_user
      if @user = User.find_by_name(params[:name])
        @user
      else
        redirect_to :root, notice: "This profile doesn't exist"
      end
    end
end
