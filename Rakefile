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

desc 'Install configuration, binaries, plagins, etc.'
task :install do
  log.info 'Checking for updates ...'
  if self_update_needed?
    log.info 'Updates are available. Please run \'git pull\''
  else
    log.info 'OK'
  end

  linkables.each do |linkable|
    file = linkable.split('/').last
    source = "#{ENV["PWD"]}/#{linkable}"
    target = "#{ENV["HOME"]}/.#{file}"

    install_one_link(target, source)
  end

  vundle_install unless vundle_installed?
  vundle_update()
end

desc 'Check is all needed software is installed'
task :check do
  log.debug('tmux: checking ...')
  tmux_ver = `tmux -V`
  if tmux_ver.nil? or tmux_ver.empty?
    log.debug('tmux: FAIL')
  else
    log.debug("tmux: OK (found version:#{tmux_ver.strip!})")
  end
end

desc 'Update vim bundles managed by vundle.'
task :vundle_update do 
  vundle_update
end

def vundle_installed?
  File.exist?("#{File.dirname(__FILE__)}/vim/vim/bundle/vundle")
end

def vundle_install
  FileUtils.cd("#{File.dirname(__FILE__)}/vim") do
    `git clone https://github.com/gmarik/vundle.git vim/bundle/vundle`
  end
end

def vundle_update
  `vim --noplugin -u vim/vim/vundles.vim -N \"+set hidden\" \"+syntax on\" +BundleClean +BundleInstall +qall`
end

def linkables
  linkables = []
  linkables += Dir.glob('git/*')
  linkables += Dir.glob('tmux/*')
  linkables += Dir.glob('vim/*')
  linkables += Dir.glob('irb/*')
  linkables += Dir.glob('ruby/*')
  # linkables += Dir.glob('ctags/*') if want_to_install?('ctags config (better js/ruby support)')
  # linkables += Dir.glob('vimify/*') if want_to_install?('vimification of mysql/irb/command line')
  # linkables += Dir.glob('zsh/zshrc') if want_to_install?('zsh')
end

def link_already_there?(target, source)
  return false unless File.exists?(target)
  return false unless File.symlink?(target)
  return false unless File.identical?(target, source)
  return true
end

def install_one_link(target, source)

  log.info("link: #{target} -> #{source}")

  if link_already_there?(target, source)
    log.debug('the link is already there, skiping.')
    log.info('link: OK')
    return
  end

  if File.exists?(target)
    log.info('target exists, do you want to (o)verwrite or (s)kip?')
    case STDIN.gets.chomp
    when 'o'
      log.info('will overwrite');
    when 's'
      log.info('will skip')
      return
    else
      log.info('did not understand the input, cowardly skiping ...')
      return
    end
    log.debug("removing #{target}")
    FileUtils.rm_rf(target)
  end

  log.debug("creating link #{target} -> #{source}")
  `ln -s "#{source}" "#{target}"`
  log.info('link: OK')
end

def submodules_update
  `git submodule update --init`
end

def self_update_needed?
  `git remote update`
  status = `git status -b --porcelain`
  #status =~ /\[ahead \d+\]/
  status =~ /\[behind \d+\]/
end
