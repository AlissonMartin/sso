class SessionsController < Devise::SessionsController
    def destroy

        sign_out(current_user)
        redirect_to params[:redirect], notice: "Você foi desconectado com sucesso!"
    end
end
