class OauthClientsController < ApplicationController
  before_action :set_oauth_client, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /oauth_clients or /oauth_clients.json
  def index
    @oauth_clients = OauthClient.where(deleted_at: nil)
  end

  # GET /oauth_clients/1 or /oauth_clients/1.json
  def show
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
  end

  # GET /oauth_clients/new
  def new
    @oauth_client = OauthClient.new
  end

  # GET /oauth_clients/1/edit
  def edit
    
  end

  # POST /oauth_clients or /oauth_clients.json
  def create
    
    @oauth_client = OauthClient.new(oauth_client_params)

    respond_to do |format|
      if @oauth_client.save
        format.html { redirect_to oauth_client_url(@oauth_client), notice: "Oauth client was successfully created." }
        format.json { render :show, status: :created, location: @oauth_client }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @oauth_client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /oauth_clients/1 or /oauth_clients/1.json
  def update
    
    respond_to do |format|
      if @oauth_client.update(oauth_client_params)
        format.html { redirect_to oauth_client_url(@oauth_client), notice: "Oauth client was successfully updated." }
        format.json { render :show, status: :ok, location: @oauth_client }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @oauth_client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /oauth_clients/1 or /oauth_clients/1.json
  def destroy
    @oauth_client.deleted_at = Time.now
    @oauth_client.save

    redirect_to oauth_clients_path
  end

  def generate_token(client)
    payload = { user_id: 1, exp: 1.hour.from_now.to_i }
    token = Jwt.encode(payload, OauthClient.jwt_secret_key(client), 'HS256')
    render json: { token: token }
  end

  def validate_token(client)
    token = params[:token]
    begin
      payload = Jwt.decode(token, OauthClient.jwt_secret_key(client), ['HS256'])
      render json: { payload: payload }
    rescue Jwt::VerificationError
      render json: { error: 'Token inválido' }, status: :unauthorized
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_oauth_client
    
    @oauth_client = OauthClient.find(params[:id])
  end

    # Only allow a list of trusted parameters through.
  def oauth_client_params
    
    params.require(:oauth_client).permit(:name, :app_id, :app_secret)
  end

  def jwt_secret_key(client_id)
    OauthClient.find_by(client_id: client_id).secret_key
  end
end
