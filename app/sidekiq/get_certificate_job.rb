class GetCertificateJob
  include Sidekiq::Job
  sidekiq_options retry: 15
  def perform(domain)
  certificate = LetsEncrypt.certificate_model.find_by(domain: domain)
  certificate.get
  challenge = certificate.order.authorizations.first.http
  unless challenge.status == "valid"
    raise challenge.error["detail"]
  end
  end
end
