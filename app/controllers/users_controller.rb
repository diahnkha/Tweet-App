class UsersController < ApplicationController
  before_action :authenticate_user, { only: %i[index show edit update] }
  before_action :forbid_login_user, { only: %i[new create login login_form] }
  before_action :ensure_correct_user, { only: %i[edit update destroy] }

  def ensure_correct_user
    if params[:id].to_i != @current_user.id
      flash[:notice] = 'Unauthorized access'
      redirect_to('/posts/index')
    end
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def new
    @user = User.new
  end

  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy
    flash[:notice] = 'User successfully deleted'
    redirect_to('/users/index')
  end

  def create
    @user = User.new(name: params[:name], email: params[:email], image_name: 'default_user.jpg', password: params[:password])

    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = 'You have signed up successfully'
      redirect_to("/users/#{@user.id}")
    else

      render('users/new')
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]

    if params[:image]
      @user.image_name = "#{@user.id}.jpg"
      image = params[:image]
      File.binwrite("app/assets/images/user_images/#{@user.image_name}", image.read)

    end
    if @user.save
      redirect_to("/users/#{@user.id}")
      flash[:notice] = 'Your account has been updated successfully'
    else
      render('users/edit')

    end
  end

  def login_form; end

  def login
    @user = User.find_by(email: params[:email])

    if @user && @user.authenticate(params[:password]) 
      session[:user_id] = @user.id
      flash[:notice] = 'You have logged in successfully'
      redirect_to('/posts/index')
    else
      @error_message = 'Invalid email/password combination'
      @email = params[:email]
      @password = params[:password]
      render('users/login_form')
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = 'You have logged out successfully'
    redirect_to('/login')
  end
  def likes
    # Define the @user variable
  @user=User.find_by(id:params[:id])

  # Define the @likes variable
  @likes=Like.where(user_id:@user.id)
  end
end
