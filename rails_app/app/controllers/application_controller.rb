class ApplicationController < ActionController::Base
  def patient_required
    redirect_back(fallback_location: root_path) unless patient_signed_in?
  end
end
