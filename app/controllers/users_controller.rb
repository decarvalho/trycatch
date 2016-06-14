class UsersController < ApplicationController
  http_basic_authenticate_with :email => "email@email.com", :password => "1234"
  before_filter :authenticate_user!

  def fetch_user
    @user = User.find_by_id(params[:id])
  end

  # GET /users
  def index
    @users = User.all
    respond_to do |format|
      format.json { render json: @users }
    end
  end

  # GET /users/1
  def show
    respond_to do |format|
      format.json { render json: @user }
    end
  end

  # POST /users
  def create
    @user = User.new(params[:user])
    @user.temp_password = Devise.friendly_token
    respond_to do |format|
      if @user.save
        format.json { render json: @user, status: :created }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  def update
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.json { head :no_content, status: :ok }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  def destroy
    respond_to do |format|
      if @user.destroy
        format.json { head :no_content, status: :ok }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
end
