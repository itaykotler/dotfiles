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

desc 'Install configuration, binaries, plugging, etc.'
task :install do
  if self_update_needed?
    puts 'Looks like your git repo is either ahead or behind or dirty, ' \
      'wanna stop and fix? [y]es/[n]o:'
    exit if STDIN.gets.chomp == 'y'
  end

  install_fonts

  linkables.each do |linkable|
    file = linkable.split('/').last
    source = "#{ENV["PWD"]}/#{linkable}"
    target = "#{home}/.#{file}"

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
  log.info 'Installing Vundle...'
  FileUtils.cd("#{File.dirname(__FILE__)}/vim") do
    `git clone https://github.com/gmarik/vundle.git vim/bundle/vundle`
  end
  log.info 'done'
end

def vundle_update
  log.info 'Updating Vundle...'
  system "vim --noplugin -u #{home}/.vim/vundles.vim -N \"+set hidden\" \"+syntax on\" +BundleClean +BundleInstall +qall"
  log.info 'done.'
end

def linkables
  linkables = []
  linkables += Dir.glob('git/*')
  linkables += Dir.glob('tmux/*')
  linkables += Dir.glob('vim/*')
  linkables += Dir.glob('irb/*')
  linkables += Dir.glob('ruby/*')
  linkables += Dir.glob('bash/*')
  linkables += Dir.glob('lua/*')
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
    log.info('link: done')
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
  check_git_status[0]
end

def check_git_status
  log.debug 'Checking git status ...'

  `git remote update`
  status = `git status -b --porcelain`
  ahead = status =~ /\[ahead \d+\]/
  behind = status =~ /\[behind \d+\]/
  dirty = status =~ /^\sM|^\s\?\?/

  log.debug status
  log.debug("behind:%s ahead:%s dirty:%s" %
            [!behind.nil?, !ahead.nil?, !dirty.nil?])
  [behind, ahead, dirty]
end

task :install_fonts do
  install_fonts
end

def install_fonts

  source = "#{File.dirname(__FILE__)}/fonts"
  case
  when on_linux
    FileUtils.mkdir("#{home}/.fonts") unless File.exist?("#{home}/.fonts")
    target = "#{home}/.fonts/my_fonts"
  when on_mac
    target = "#{home}/Library/Fonts/my_fonts"
  else
    raise 'We are running on an unknown platform!'
  end

  install_one_link(target, source)

  # I think there is nothing to do for the MacOS
  if on_linux
    log.info 'updating font cache ...'
    `fc-cache -fv`
    log.info 'done.'
  end
end

def on_linux
  RUBY_PLATFORM.downcase.include?('linux')
end

def on_mac
  RUBY_PLATFORM.downcase.include?('darwin')
end

def home
  "#{ENV['HOME']}"
end
