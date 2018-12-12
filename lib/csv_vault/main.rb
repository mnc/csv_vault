require 'csv'
require 'active_support'

module CsvVault
  class Main
    def initialize(input_file:, output_file: nil, col_nums: [], passphrase:, salt: nil)
      @input_file  = input_file
      @output_file = output_file
      @col_nums    = col_nums.map(&:to_i)
      @passphrase  = passphrase
      @salt        = salt.to_s
      @cryptor     = cryptor
    end

    def encrypt
      @processed_rows = CSV.foreach(@input_file).map{ |row| encrypt_row(row) }
      self
    end

    def output
      CSV.open(@output_file, 'w') do |csv|
        @processed_rows.each do |encrypted_row|
          csv << encrypted_row
        end
      end
    end

    def decrypt
      @processed_rows = CSV.foreach(@input_file).map{ |row| decrypt_row(row) }
      self
    end

    private

    def encrypt_row(row)
      if @col_nums.empty?
        encrypt_all(row)
      else
        encrypt_partially(row)
      end
    end

    def decrypt_row(row)
      if @col_nums.empty?
        decrypt_all(row)
      else
        decrypt_partially(row)
      end
    end

    # TODO: parameterize length, digest and cipher
    def cryptor
      key = ActiveSupport::KeyGenerator.new(@passphrase).generate_key(@salt, 32)
      ActiveSupport::MessageEncryptor.new(key, cipher: "aes-256-cbc", digest: "SHA256")
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
