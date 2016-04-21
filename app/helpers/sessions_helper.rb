module SessionsHelper

  def log_in(user)
    session[:user_id] = user.id
  end

  #ユーザーを永続的にセッションに記憶する
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  #与えられたユーザーがログイン済みかユーザーであればtrueを返す
  def current_user?(user)
    user == current_user
  end

  #現在ログイン中のユーザーを返す(ログイン中のユーザーがいる場合)
  def current_user
    if(user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif(user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  #永続的セッションを破棄する
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  #現在のユーザーがログアウトをする
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  #フレンドリーフォワーディングの為に記憶したURL(またはデフォルト値)にリダイレクト
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  #アクセスしようとしたURLを覚えておく
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end
end
