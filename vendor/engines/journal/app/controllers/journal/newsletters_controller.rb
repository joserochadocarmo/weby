module Journal
  class NewslettersController < Journal::ApplicationController
    layout :choose_layout

    def new
      @comp = current_site.active_skin.components.find_by_name("newsletter")
      if not params[:email].blank?
        if params[:opt].to_s == "delete"
          user = Newsletter.where("email = ? AND site_id = ?", params[:email], current_site.id.to_s)[0]
          NewsletterMailer.delete_email(Weby::Components.factory(@comp).send_as, user, current_site.url).deliver
          redirect_to :back, flash: { success: t('deactivation_sent_successful') }
        else
          ntr = Newsletter.where("email = ? AND site_id = ?", params[:email], current_site.id.to_s)[0]
          ntr = Newsletter.new(site_id: current_site.id,
                                 group: params[:group],
                                 email: params[:email],
                                 token: Digest::SHA1.hexdigest([Time.now, rand].join),
                               confirm: false) if ntr.nil?
          respond_to do |format|
            if ntr.save
              NewsletterMailer.confirm_email(ntr, current_site.url).deliver
              format.html { redirect_to :back, flash: { success: t('activation_sent_successful') } }
              format.js
            else
              format.html { redirect_to :back, flash: { error: t('error_creating_object') } }
              format.js
            end
          end
        end
      end
    end

    def show
      if params[:token]
        val = params[:token].split(':')
        user = Newsletter.where("id = ? AND token = ?", val[1], val[0])[0]
        redirect_to :root, flash: { error: t('error_creating_object') } if user.nil?
        user.token = Digest::SHA1.hexdigest([Time.now, rand].join)

        case params[:id]
        when 'confirmation'
          user.confirm = true
          user.save
          redirect_to :root, flash: { success: t('enable') }
        when 'getout'
          user.confirm = false
          user.save
          redirect_to :root, flash: { success: t('disable') }
        end
      end
    end
  end
end

