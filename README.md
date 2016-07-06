# Abacus App

Abacus is a rails application for software project management.

**IMPORTANT!** This project is under development.

Because it's at an early stage can be used it as an example of application in Rails 5.

## Features
- Project management
- Tasks management
- Working time management
- Multi-user interface
- Invoice management

### Visual style
It has been used a open source admin dashboard & control panel theme [AdminLTE](https://almsaeedstudio.com/preview).

Built on top of Bootstrap 3, AdminLTE provides a range of responsive, reusable, and commonly used components.     
Thanks to [AlmsaeedStudio](https://almsaeedstudio.com)

## Instalation
```sh
$ git clone https://github.com/guzmanweb/abacus
$ cd abacus
$ bundle
$ cp config/database.yml.example config/database.yml
$ rake db:setup
$ rails server -b 0.0.0.0
```
## Contribution

1. Fork ( https://github.com/[my-github-username]/abacus/fork )
2. Create new feature branch (`git checkout -b my-new-feature`)
3. Commita your changes (`git commit -am 'Add some feature'`)
4. Push branch (`git push origin my-new-feature`)
5. Create new Pull Request