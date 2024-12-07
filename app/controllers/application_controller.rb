class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  # allow_browser versions: { safari: 20, firefox: 110, ie: 9 ,  }
end
