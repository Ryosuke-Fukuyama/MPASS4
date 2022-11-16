worker_processes  2
 working_directory "/var/www/MPASS4/current"
 stderr_path "log/unicorn.stderr.log"
 stdout_path "log/unicorn.stdout.log"
 timeout 30
 listen "/var/www/MPASS4/current/tmp/sockets/unicorn.sock"
 pid '/var/www/MPASS4/current/tmp/pids/unicorn.pid'
 preload_app true

 before_fork do |server, worker|
   defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
   old_pid = "#{server.config[:pid]}.oldbin"
   if old_pid != server.pid
     begin
       sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
       Process.kill(sig, File.read(old_pid).to_i)
     rescue Errno::ENOENT, Errno::ESRCH
     end
   end
 end

 after_fork do |server, worker|
   defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
 end