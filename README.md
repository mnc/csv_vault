# CsvVault

CsvVault is a Ruby gem to encrypt/decrypt CSV. You can specify target columns to encrypt/decrypt.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'csv_vault'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install csv_vault

## Usage

### Simple Encryption
**original csv**
*users.csv*
```
1,mnc,password1
2,sample,password2
```

**encrypt command**
```shell
csv_vault encrypt users.csv -o encrypted_users.csv -c 2
```

**encrypted csv**
```
1,mnc,N28wam1wTjhnV3RwUXRMRFlqczI1emdNbmNXV2RyN3YrMmpRYytSN04xQT0tLVc5TXNGcUlwaFN4ZnpkSmxYVzZEdkE9PQ==--4f865737f808ed54d303c96f39ebc0bae1247edf7fb9befc59597b598836ec21
2,sample,V1dDM2FKYlF6TWdiL2ZsTXVGQkRUWVBWUDZIV2oxL0pyMzdjcW5pMVQ5TT0tLVJYN1VnVHA3OUJCU2VHY2RyUzJNMmc9PQ==--dcbe6e8a49513be26062aa1b5b6542ea804dafdf9815b2c72d8c0e84704438a0
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/csv_vault. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the CsvVault project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/csv_vault/blob/master/CODE_OF_CONDUCT.md).
