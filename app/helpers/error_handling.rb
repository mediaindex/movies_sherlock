def display_error
  error = session[:error]
  session[:error] = nil

  if error
    return slim :'error_display', layout: false, locals: {errors: error}
  else
    return ""
  end
end

def set_error(msg)
  session[:error] = [msg]
end
