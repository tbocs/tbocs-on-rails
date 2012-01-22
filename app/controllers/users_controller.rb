class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user, :only => [:destroy]

  def new
    @user = User.new
    @title = "Sign up"
  end

  def index
    @users = User.paginate(:page => params[:page])
    @title = "All users yay"
  end

  def show
    @user = User.find(params[:id])
    @title = @user.name
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      @title = "Sign Up"
      render 'new'
    end
  end

  def edit
    @title = "Edit user"
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end

  def destroy
    user = User.find(params[:id]).destroy
    flash[:success] = "User #{user.name} destroyed."
    redirect_to users_path
  end
 private

  def authenticate
    require_access unless signed_in?
  end

  def correct_user
    @user = User.find(params[:id])
    deny_access unless current_user?(@user)
  end

  def admin_user
    deny_access unless current_user.admin?
  end

  def deny_access
    flash[:error] = "You do not have the permission for this operation!"
    redirect_to(root_path)
  end

end
