require 'logger'

@logger = Logger.new(STDOUT)
@logger.level = Logger::DEBUG

def log
  @logger
end

task :default do
  puts 'run: rake check'

end

task :check do
  log.debug('tmux: checking ...')
  tmux_ver = `tmux -V`
  if tmux_ver.nil? or tmux_ver.empty?
    log.debug('tmux: FAIL')
  else
    log.debug("tmux: OK (found version:#{tmux_ver.strip!})")
  end
end





