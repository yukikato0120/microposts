class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :followings, :followers]
  before_action :login_auth, only:[:edit,:update]

  def show # 追加
    @user = User.find(params[:id]) #ここがあるか否かでエラーがでる
    @microposts = @user.microposts.order(created_at: :desc).page(params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit #自分で追加
  # @user = User.find(params[:id])
  end

  def update
  # @user = User.find(params[:id])
     if @user.update_attributes(user_params)
       flash[:success] = "success"
       redirect_to user_path(@user) #追加項目
     else
      render 'edit'
     end
  end

  def followings
    @title = "Followings"
    @users = @user.following_users.page(params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Folowers"
    @users = @user.follower_users.page(params[:page])
    render 'show_follow'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation ,:area ,:age)
  end

  def login_auth
    redirect_to root_path if @user != current_user
  end

  def set_user
    @user = User.find(params[:id])
  end


end