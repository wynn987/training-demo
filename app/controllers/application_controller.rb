class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include RenderErrors

  before_action :set_origin
  before_action :set_headers

  private

  def set_origin
    @origin = request.headers['HTTP_ORIGIN']
  end

  def set_headers
    if @origin
      allowed = ['localhost']
      allowed.each do |host|
        if @origin.match /^https?:\/\/#{Regexp.escape(host)}/i
          headers['Access-Control-Allow-Origin'] = @origin
          break
        end
      end
      # or '*' for public access
      # headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'GET, OPTIONS'
      headers['Access-Control-Request-Method'] = '*'
      headers['Access-Control-Allow-Headers'] = 'Content-Type'
    end
  end
end
