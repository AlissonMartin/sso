class OauthClientsController < ApplicationController
  before_action :set_oauth_client, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /oauth_clients or /oauth_clients.json
  def index
    @oauth_clients = OauthClient.all
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
    @oauth_client.destroy

    respond_to do |format|
      format.html { redirect_to oauth_clients_url, notice: "Oauth client was successfully destroyed." }
      format.json { head :no_content }
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
end
