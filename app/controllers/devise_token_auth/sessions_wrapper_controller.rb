module DeviseTokenAuth
  class SessionsWrapperController < ::DeviseTokenAuth::SessionsController
    # Prevent session parameter from being passed
    # Unpermitted parameter: session
    wrap_parameters format: []
  end
end
