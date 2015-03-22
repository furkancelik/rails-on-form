class SessionsController < ApplicationController
  def new
    redirect_to profile_path(@current_user) if signed_in?
  end

  def create
    user = User.find_by_username(params[:session][:user_name])
    if user && user.authenticate(params[:session][:password])
      login(user)
      redirect_to profile_path(user), notice: 'Oturum Açıldı'
    else
      flash[:error] = "Kullanıcı adı yada parola hatalı."
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: "Oturumunuz Sonlandırıldı";
  end
end
