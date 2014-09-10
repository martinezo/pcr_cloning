class PcrCloningMailer < ActionMailer::Base
  default from: "computo@inb.unam.mx"

  def user_notification(request, attach_file)
    attachments[attach_file] = File.read(attach_file)
    @name = request.name
    mail(to: request.mail, subject: t('titles.request_cloning'))
  end

  def admin_notification(request, attach_file)
    attachments[attach_file] = File.read(attach_file)
    Admin::SystemConfig.get
    @name = request.name
    @mail = request.mail
    @institution = request.company
    mail(to: Admin::SystemConfig.new_request_mails , subject: t('titles.new', param: t('titles.request_cloning')))
  end

  def deposit_notification(request, attach_file)
    attachments[attach_file] = File.read(attach_file)
    Admin::SystemConfig.get
    @name = request.name
    @mail = request.mail
    @institution = request.company
    mail(to: Admin::SystemConfig.new_deposit_slip_mail , subject: t('titles.new', param: t('titles.request_cloning')))
  end

end
