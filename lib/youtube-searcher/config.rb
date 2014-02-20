require "psych"
require "singleton"
require "erb"

class YoutubeSearcher::Config
  include Singleton

  CONFIG_FILE = ".ytsrc"

  def config
    @config ||= Psych.load(raw).inject({}) { |memo, (k, v)| memo[k.to_sym] = v; memo }
  end
  alias_method :get, :config

  def generate
    default_config = raw.gsub(/download_directory.*\n/, "download_directory: \"#{ENV["HOME"]}\"\n")
    File.open(File.join(ENV["HOME"], ".ytsrc"), "w") do |f|
      f.puts default_config
    end
  end

  def raw
    @raw ||= ERB.new(File.read(config_file)).result
  end

  private

  def config_file
    unless @config_file
      if File.file?(File.join(ENV["HOME"], CONFIG_FILE))
        @config_file = File.join(ENV["HOME"], CONFIG_FILE)
      else
        @config_file = File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "ytsrc"))
      end
    end

    @config_file
  end
end
