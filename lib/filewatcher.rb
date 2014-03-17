require 'fileutils'
require 'digest'

module Filewatcher
  ROOT_PATH = File.join ENV['FW_BUFFER_PATH'] || [Dir.home, ".filewatcher"]
  BUFFER_PATH = File.join(ROOT_PATH, 'buffer')
  MAX_BUFFER_SIZE = (ENV['FW_BUFFER_SIZE'] || 100).to_i

  class Record
    attr_reader :file

    def initialize(path)
      @file = File.new path

      FileUtils.ln_sf file.to_path, link_path

      email if entries.size >= MAX_BUFFER_SIZE
    end

    def buffer
      return @buffer if @buffer

      FileUtils.mkdir_p BUFFER_PATH unless Dir.exists? BUFFER_PATH
      @buffer = Dir.new BUFFER_PATH
    end

    def file_digest
      Digest::MD5.hexdigest file.path + file.read
    end

    def link_path
      [buffer.path, file_digest].join '/'
    end

    def entries
      # Remove . and .. from entries
      buffer.entries.reject { |entry| entry =~ /^[.]+$/ }
    end

    def files
      entries.map do |entry|
        link_path = "#{buffer.path}/#{entry}"
        readlink = File.readlink(link_path)
        readlink if File.unlink link_path
      end
    end

    def email
      require 'pony'
      require 'letter_opener'

      Pony.options = {
        via: LetterOpener::DeliveryMethod,
        via_options: { location: "#{ROOT_PATH}/email" }
      }

      Pony.mail(
        from: self.class.name,
        to: 'blendle',
        body: files.join("\n")
      )
    end
  end
end

