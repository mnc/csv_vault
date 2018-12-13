require 'csv_vault'
require 'csv_vault/main'
require 'thor'

module CsvVault
  class Cli < Thor
    class_option :output,     type: :string, aliases: "-o", banner: 'output',     required: true
    class_option :col_nums,   type: :array,  aliases: "-c"
    class_option :passphrase, type: :string, aliases: "-p", banner: 'passphrase', required: true
    class_option :salt,       type: :string, aliases: "-s", banner: 'randomsalt'

    desc "encrypt csv", "encrypt"
    def encrypt(input_file)
      rows = CsvVault.from_file(input_file: input_file, col_nums: options[:col_nums], passphrase: options[:passphrase], salt: options[:salt]).encrypt
      output(rows)
    end

    desc "decrypt csv", "decrypt"
    def decrypt(input_file)
      rows = CsvVault.from_file(input_file: input_file, col_nums: options[:col_nums], passphrase: options[:passphrase], salt: options[:salt]).decrypt
      output(rows)
    end

    private

    def output(rows)
      CSV.open(options[:output], 'w') do |csv|
        rows.each { |row| csv << row }
      end
    end
  end
end
