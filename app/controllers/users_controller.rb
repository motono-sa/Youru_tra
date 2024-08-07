class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  before_action :set_user, only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, success: t('users.create.success')
    else
      flash.now[:error] = t('users.create.failure')
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user
    @user_video_searches = @user.user_video_searches.includes(video: :training_part)
    @current_month = Time.zone.today.beginning_of_month
    @monthly_training_counts = @user.monthly_training_counts_for_month(@current_month)
  end

  def edit
    @user
  end

  def update
    if @user.update(user_params)
      redirect_to mypage_path, success: 'ユーザー情報が更新されました'
    else
      render :edit
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
