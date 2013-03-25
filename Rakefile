require 'logger'
require 'fileutils'
require 'awesome_print'


@logger = Logger.new(STDOUT)
@logger.level = Logger::DEBUG

def log
  @logger
end

task :default do
  puts 'run: rake check'
end

desc 'creating the links to config files'
task :link do
  target = "#{ENV['HOME']}/.tmux.conf"
  source = "#{ENV['PWD']}/tmux/tmux.conf"

  if not File.exists?(target)
    log.debug('creating a link from ~/.tmux.conf')
    `ln -s "#{source}" "#{target}"`
  elsif File.identical?(source, target)
    log.debug('~/.tmux.conf is already pointing at the right place')
  else
    log.debug('~/.tmux.conf is already there, not linking')
  end

end

desc 'checking for installed software'
task :check do
  log.debug('tmux: checking ...')
  tmux_ver = `tmux -V`
  if tmux_ver.nil? or tmux_ver.empty?
    log.debug('tmux: FAIL')
  else
    log.debug("tmux: OK (found version:#{tmux_ver.strip!})")
  end
end

