require 'csv'
require 'active_support'
require 'csv_vault/encryptor'
require 'csv_vault/decryptor'

module CsvVault
  class Main
    def self.from_file(input_file:, col_nums: [], passphrase:, salt: nil)
      original_rows = CSV.read(input_file)
      self.new(original_rows: original_rows, col_nums: col_nums, passphrase: passphrase, salt: salt)
    end

    def initialize(original_rows: [], col_nums: [], passphrase:, salt: nil)
      @original_rows = original_rows
      @col_nums      = col_nums.map(&:to_i)
      @passphrase    = passphrase
      @salt          = salt.to_s
    end

    def encrypt
      CsvVault::Encryptor.new(original_rows: @original_rows, 
                              col_nums: @col_nums, 
                              passphrase: @passphrase, 
                              salt: @salt).run
    end

    def decrypt
      CsvVault::Decryptor.new(original_rows: @original_rows, 
                              col_nums: @col_nums, 
                              passphrase: @passphrase, 
                              salt: @salt).run
    end
  end
end
