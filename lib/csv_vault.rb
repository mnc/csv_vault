require "csv_vault/version"
require "csv_vault/main"
require "csv_vault/cli"

module CsvVault
  def self.from_file(input_file:, col_nums: [], passphrase:, salt: nil)
    CsvVault::Main.from_file(input_file: input_file, col_nums: col_nums, passphrase: passphrase, salt: salt)
  end
end
