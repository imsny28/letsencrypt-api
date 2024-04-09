class CertificatesController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :set_certificate, only: %i[ show edit update destroy ]

  # GET /certificates or /certificates.json
  def index
    @certificates = Certificate.all
    render json: @certificates
  end

  # GET /certificates/1 or /certificates/1.json
  def show
    render json: @certificate
  end

  # GET /certificates/new
  def new
    @certificate = Certificate.new
  end

  # GET /certificates/1/edit
  def edit
  end

  # POST /certificates or /certificates.json
  def create
    @certificate = Certificate.new(certificate_params)
    if @certificate.save
      GetCertificateJob.perform_async(@certificate.domain)
      render json: { message: 'SSL will be genrated soon ...' }, status: :created
    else
      render json: @certificate.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /certificates/1 or /certificates/1.json
  def update
    if @certificate.update(certificate_params)
      render json: { message: 'SSL will update soon' }, status: :created
    else
      render json: @certificate.errors, status: :unprocessable_entity
    end
  end

  # DELETE /certificates/1 or /certificates/1.json
  def destroy
    @certificate.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_certificate
      @certificate = Certificate.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def certificate_params
      params.require(:certificate).permit(:domain)
    end
end
