module Environment
  ENV_VARIABLE = 'GPS_SERVER_ENVIRONMENT'

  module_function

  def set_environment(env)
    case env
    when 'development'
      ENV[ENV_VARIABLE] = 'development'
    when 'production'
      ENV[ENV_VARIABLE] = 'production'
    end
  end

  def current
    ENV.fetch(ENV_VARIABLE, 'production')
  end

  def development?
    current == 'development'
  end
end
