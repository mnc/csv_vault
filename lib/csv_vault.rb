require "csv_vault/version"
require "csv_vault/main"

module CsvVault
  def self.from_file(input_file:, output_file: nil, col_nums: [], passphrase:, salt: nil)
    CsvVault::Main.new(input_file: input_file, output_file: output_file, col_nums: col_nums, passphrase: passphrase, salt: salt)
  end
end
