class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Method called by any endpoint to render a JSON response using the
  # BaseSerializer construct.
  def render_json (args={})
    # http_status
    http_status = args[:http_status]
    if http_status.nil?
      http_status = :ok
    end

    # Set the HTTP status in the render hash (for Rails rendering) and in the meta hash (for the API client).
    render_hash = { status: http_status, scope: current_user }
    render_hash.merge!({ current_user_data: args[:current_user_data] })
    meta_hash = { http_status: Rack::Utils.status_code(http_status) }

    unless args[:object].nil?
      meta_hash.merge!(args[:meta]) if args[:meta]

      # Add the object and the meta hash to the render hash for serialization.
      render_hash.merge!({ json: args[:object], meta: meta_hash })
      args[:root] = 'data' # TODO: Ian, I assume this should be forced set elsewhere?
      render_hash.merge!({ root: args[:root] }) if args[:root]

      # There should be a serializer or an each_serializer, but not both.
      if !args[:serializer].nil?
        render_hash.merge!({ serializer: args[:serializer] })
      elsif !args[:each_serializer].nil?
        render_hash.merge!({ each_serializer: args[:each_serializer] })
      end
    else
      # The JSON is the just the meta hash. (This doesn't pass through a serializer.)
      if !args[:errors].nil?
        # Add errors to the meta hash.
        meta_hash.merge!({ errors: args[:errors] })
      end

      render_hash.merge!({ json: { meta: meta_hash } })
    end

    return render(render_hash)
  end

end
