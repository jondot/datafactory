# Datafactory

Build elegant scenarios that generate load a ton of data (fake or real) into various databases and tables. Supports ActiveRecord, Sequel and Mongoid.


## Quickstart

```
$ gem install datamapper
$ mkdir mydatadomain && cd mydatadomain
```

Generate your flows:

```
$ datamapper init myflow
$ datamapper domain billing
$ datamapper domain analytics
$ datamapper domain registrations
```

And a sample flow:

```
require 'datafactory/dataflow'

class Main
  include Datafactory::Dataflow

  def up
    use :billing
    users = create_list(:user, 20)

    use :analytics
    users.each do |user|
      puts "creating admin user with email #{user.email}"
      u = create(:admin, email: user.email)
      puts u.inspect
    end

    use :registrations
    users.each do |user|
      puts "creating registrant user with email #{user.email}"
      u = create(:registrant, email: user.email)
      puts u.inspect
    end
  end

  def down
    use :billing
    Billing::User.delete_all

    use :analytics
    Analytics::User.delete_all

    use :registrations
    Registrations::User.delete_all
  end
end
```

Done.

# Contributing

Fork, implement, add tests, pull request, get my everlasting thanks and a respectable place here :).

### Thanks:

To all [contributors](https://github.com/jondot/datafactory/graphs/contributors)

# Copyright

Copyright (c) 2016 [Dotan Nahum](http://gplus.to/dotan) [@jondot](http://twitter.com/jondot). See [LICENSE](LICENSE.txt) for further details.
