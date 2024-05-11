class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  def index
     @user=current_user
    @books=Book.all
    @users=User.all
  end

    def show
 @user = User.find(params[:id])
 @books = @user.books
    end


  def edit
      @user = User.find(params[:id])
  end

   def create
    @user = User.new
    @user.user_id = current_user.id
   if  @user.save
       flash[:notice] = " Welcome! You have signed up successfully."
    redirect_to user_path
   else  flash[:notice] = " Signed in successfully. "
    redirect_to user_path


   end
   end

   def update
  @user = User.find(params[:id])
  @user.update(user_params)
   if  @user.save
       flash[:notice] = "You have updated user successfully."
       redirect_to user_path(@user)
   else
       render :edit
   end
   end

 private

 def user_params
  params.require(:user).permit(:name, :introduction, :profile_image)
 end
 def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user)
    end
 end
end