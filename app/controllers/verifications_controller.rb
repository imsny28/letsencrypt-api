# frozen_string_literal: true
class VerificationsController < ApplicationController
  def show
    return render_verification_string if certificate.present?
    render plain: 'Verification not found', status: 404
  end

  protected

  def render_verification_string
    render plain: certificate.verification_string
  end

  def certificate
    Certificate.find_by(verification_path: filename)
  end

  def filename
    ".well-known/acme-challenge/#{params[:verification_path]}"
  end
end

