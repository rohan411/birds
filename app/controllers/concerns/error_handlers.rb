module Concerns::ErrorHandlers
  extend ActiveSupport::Concern

  def render_bad_request(e)
    render json: { meta: { success: false, errors: e.message } }, status: :not_found
  end

  def render_not_found(e)
    render json: { meta: { success: false, errors: e.message } }, status: :not_found
  end

end
