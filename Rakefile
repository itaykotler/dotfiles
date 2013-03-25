require 'logger'
require 'fileutils'
require 'awesome_print'

# import Rakefiles from the subdirs
Dir.glob("*/Rakefile").each {|r| import r}

@logger = Logger.new(STDOUT)
@logger.level = Logger::DEBUG
@logger.formatter = proc do |severity, datetime, progname, msg|
  "#{severity}: #{msg}\n"
end

def log
  @logger
end

task :default do
  puts 'run: rake check'
end

desc 'Install configuration, binaries, plagins, etc.'
task :install do
  linkables.each do |linkable|
    file = linkable.split('/').last
    source = "#{ENV["PWD"]}/#{linkable}"
    target = "#{ENV["HOME"]}/.#{file}"

    log.info("link: #{target} -> #{source}")

    if link_already_there?(target, source)
      log.debug('the link is already there, skiping.')
      log.info('OK')
      next
    end

    if File.exists?(target)
      log.info('target exists, do you want to (o)verwrite or (s)kip?')
      case STDIN.gets.chomp
      when 'o'
        log.info('will overwrite');
      when 's'
        log.info('will skip')
        next
      else
        log.info('did not understand the input, cowardly skiping ...')
        next
      end
      log.debug("removing #{target}")
      FileUtils.rm_rf(target)
    end

    log.debug("creating link #{target} -> #{source}")
    `ln -s "#{source}" "#{target}"`
    log.info('OK')
  end
end

def linkables
  linkables = []
  linkables += Dir.glob('git/*')
  linkables += Dir.glob('tmux/*')
  # linkables += Dir.glob('irb/*') if want_to_install?('irb/pry')
  # linkables += Dir.glob('ruby/*') if want_to_install?('ruby (gems)')
  # linkables += Dir.glob('ctags/*') if want_to_install?('ctags config (better js/ruby support)')
  # linkables += Dir.glob('vimify/*') if want_to_install?('vimification of mysql/irb/command line')
  # linkables += Dir.glob('{vim,vimrc}') if want_to_install?('vim')
  # linkables += Dir.glob('zsh/zshrc') if want_to_install?('zsh')
end

def link_already_there?(target, source)
  return false unless File.exists?(target)
  return false unless File.symlink?(target)
  return false unless File.identical?(target, source)
  return true
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

