class LocalesController < ActionController::Base
  protect_from_forgery with: :exception

  def update
    if I18n.available_locales.include? chosen_locale.to_sym
      current_user.update locale: chosen_locale if current_user
      cookies[:locale] = chosen_locale
    else
      flash[:error] = t('locales.error')
    end
    redirect_to :back
  end

  private

  def chosen_locale
    @locale ||= params[:locale]
  end
end