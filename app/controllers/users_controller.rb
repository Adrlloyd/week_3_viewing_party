class UsersController <ApplicationController 
    before_action :check_user, only: [:show]
    before_action :find_user, only: [:show]

    def new 
        @user = User.new()
    end 

    def show 
        # @user = User.find(params[:id])
    end 

    def create 
        user = User.create(user_params) 
        if user.save
            session[:user_id] = user.id
            redirect_to user_path(user)
        else  
            flash[:error] = user.errors.full_messages.to_sentence
            redirect_to register_path
        end 
    end

    def login_form
    end

    def login_user
        user = User.find_by(email: params[:email])
        if user.authenticate(params[:password])
            session[:user_id] = user.id
            flash[:success] = "Welcome #{user.name}!"
            redirect_to user_path(user)
        else
            flash[:error] = "Sorry your credentials are bad"
            redirect_to login_path
        end
    end

    def logout_user
        @current_user = session[:user_id] = nil
        flash[:success] = "Succesfully logged out"
        redirect_to root_path
    end

    private 

    def user_params 
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def check_user
        unless current_user
          flash[:error] = "Login required"
          redirect_to root_path
        end
    end

    def find_user
        @user = current_user
      end
end 