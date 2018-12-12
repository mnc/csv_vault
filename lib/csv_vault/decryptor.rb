require 'active_support'

module CsvVault
  class Decryptor
    def initialize(original_rows: [], col_nums: [], passphrase:, salt: nil)
      @original_rows = original_rows
      @col_nums      = col_nums.map(&:to_i)
      @passphrase    = passphrase
      @salt          = salt.to_s
      @cryptor       = init_cryptor
    end

    def run
      @original_rows.map{ |row| process(row) }
    end

    private

    # TODO: parameterize length, digest and cipher
    def init_cryptor
      key = ActiveSupport::KeyGenerator.new(@passphrase).generate_key(@salt, 32)
      ActiveSupport::MessageEncryptor.new(key, cipher: "aes-256-cbc", digest: "SHA256")
    end

    def process(row)
      if @col_nums.empty?
        decrypt_all(row)
      else
        decrypt_partially(row)
      end
    end

    def decrypt_all(row)
      row.map do |column_data|
        @cryptor.decrypt_and_verify(column_data)
      end
    end

    def decrypt_partially(row)
      row.map.with_index do |column_data, i|
        @col_nums.include?(i) ? @cryptor.decrypt_and_verify(column_data) : column_data
      end
    end
  end
end
