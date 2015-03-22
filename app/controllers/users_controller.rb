class UsersController < ApplicationController
  before_action :select_user, only: [:show, :edit, :update, :destroy]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Aramıza Hoş Geldin!"
      redirect_to profile_path(@user)
    else
      render :new
    end
  end

  def show
    @data = []

    if params[:sayfa]
      render layout: "profile", locals: { page: params[:sayfa] }
    else
      render layout: "profile", locals: { page: 'konular' }
    end
    #render layout: 'profile'
  end

  def edit

    render layout: 'profile'
  end

  def update


    params[:user].except!(:password,:password_confirmation) if params[:user][:password] == "" && params[:user][:password_confirmation] == ""

    if @user.update(params.require(:user).permit!)
      flash[:notice] = "Profil Bilgileriniz Güncellendi"
      redirect_to profile_path(@user)
    else
      render :edit, layout: "profile"
    end
  end

  def destroy
    @user.destroy
    redirect_to '/'
  end

  def select_user
    @user = User.find_by_username(params[:id])
  end

  private
  def user_params
    params.require(:user).permit!
  end
end
