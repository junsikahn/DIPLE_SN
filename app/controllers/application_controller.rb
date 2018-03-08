class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, unless: -> { request.format.json? }

  def index
    render text: nil, layout: 'application'
  end
end
