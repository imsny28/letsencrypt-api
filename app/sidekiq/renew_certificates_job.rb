class RenewCertificatesJob
  include Sidekiq::Job

  def perform account_id
    LetsEncrypt.certificate_model.renewable.each do |certificate|
      next if certificate.renew
      certificate.update(renew_after: 1.day.from_now)
    end
  end
end
