# GemfileUtils

gemfile_utils provides command line interface to modify Gemfile with annotations and comments

```
gemfile_utils help comments
Usage:
  gemfile_utils comments

Options:
  [--gemfile=GEMFILE]
                         # Default: Gemfile
  [--licenses=LICENSES]
                         # Default: false

Comment Gemfile with gems descriptions fetched from rubygems
```


```
gemfile_utils help licenses
Usage:
  gemfile_utils licenses

Options:
  [--gemfile=GEMFILE]
                       # Default: Gemfile

Comment Gemfile with gems all dependency licences fetched from rubygems
```

## Results
[Initial Gemfile](https://github.com/Fivell/gemfile_utils/blob/master/spec/fixtures/initial/Gemfile)

[Annotated Gemfile](https://github.com/Fivell/gemfile_utils/blob/master/spec/fixtures/result/Gemfile)


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gemfile_utils'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gemfile_utils

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

