class ActiveSupport::Logger::SimpleFormatter

  def call(severity, time, progname, msg)
    formatted_severity = sprintf('%-7s', "[#{severity}]")
    formatted_time = time.strftime('%Y-%m-%d %H:%M:%S.') << time.usec.to_s[0..2].rjust(3)
    "[#{formatted_time}]#{formatted_severity} #{msg}\n"
  end

end