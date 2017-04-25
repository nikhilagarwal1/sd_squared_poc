class SecretCodesController < ApplicationController
    
    load_and_authorize_resource
    def new
    end
   
    def index
        @secrets = SecretCode.all
    end
    
    def create
        (1..params[:secret_code][:frequency].to_i).each do |count|
            @new_secret_code = SecretCode.new(secret_code_params)
            @new_secret_code.secret_code = SecretCode.generate_code
            @new_secret_code.save
        end
        redirect_to @new_secret_code
    end
    
    def show
        @secret_code = SecretCode.all
    end
    
     private

     def secret_code_params
        params.require(:secret_code).permit(:frequency)
      end
end
