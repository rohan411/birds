module Concerns::Errors
  extend ActiveSupport::Concern

  included do
    rescue_from Mongoid::Errors::DocumentNotFound, with: :render_not_found
    rescue_from Mongoid::Errors::Validations, with: :render_bad_request
    rescue_from RailsParam::Param::InvalidParameterError, with: :render_bad_request
  end
end
