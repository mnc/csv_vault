require 'active_support'

module CsvVault
  class Encryptor
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
        encrypt_all(row)
      else
        encrypt_partially(row)
      end
    end

    def encrypt_all(row)
      row.map do |column_data|
        @cryptor.encrypt_and_sign(column_data)
      end
    end

    def encrypt_partially(row)
      row.map.with_index do |column_data, i|
        @col_nums.include?(i) ? @cryptor.encrypt_and_sign(column_data) : column_data
      end
    end
  end
end
