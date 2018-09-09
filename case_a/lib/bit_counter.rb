module BitCounter
  class Parser
    def initialize(file_path)
      @file_path = file_path
    end

    def zero_count
      file_size - one_count
    end

    def one_count
      @one_count ||= file_unpacked.count('1')
    end

    def file_size
      file_unpacked.size
    end

    private
    def file_unpacked
      file.unpack('b*').first
    end

    def file
      File.binread(@file_path)
    end
  end
end
