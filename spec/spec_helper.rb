require_relative '../config/environment.rb'
Bundler.require(:development)

def capture_puts
  begin
    old_stdout = $stdout
    $stdout = StringIO.new('','w')
    yield
    $stdout.string
  ensure
    $stdout = old_stdout
  end
end

def silence
	begin
	  # Store the original stderr and stdout in order to restore them later
	  old_stderr = $stderr
	  old_stdout = $stdout

	  # Redirect stderr and stdout
	  $stderr = $stdout = StringIO.new

	  yield
	ensure
	  $stderr = old_stderr
	  $stdout = old_stdout
	end
end