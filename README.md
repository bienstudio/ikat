# Ikat

Ikat is an easy way to collect the products you love.

## Installation

### Development

Right now it's a pretty basic Ruby on Rails install. The follow dependencies are required:

- Ruby 2.1.1 (through [rbenv](http://rbenv.org/), preferrably)
- MongoDB 2.3.6
- Redis 2.8.12

After those are all installed, just use Bundler and the built-in Rails rake tasks:

1. `bundle install`
2. `bundle exec rake db:create`
3. `bundle exec rake db:seed`

After that, it may be wise to run the test suite to make sure everything it working properly:

- `bundle exec rspec spec`

To start the server and workers:

- `bundle exec foreman start -f Procfile.development`

### Production

We run all of our servers on [Digital Ocean](https://digitalocean.com). We have bundled [tugboat](https://github.com/pearkes/tugboat), a gem used for easy access to Digital Ocean, along with Ikat. To set up Tugboat, you'll need to first go to the Access Tokens spreadsheet in Google Drive and get the Digital Ocean client ID and access token. Then, you'll create `~/.tugboat` with this information:

```yaml
---
authentication:
  client_key: [CLIENT KEY]
  api_key: [ACCESS TOKEN]
ssh:
  ssh_user: root
  ssh_key_path: "/Users/ethan/.ssh/ikat.pem"
  ssh_port: '22'
defaults:
  region: '1'
  image: '350076'
  size: '66'
  ssh_key: ''
  private_networking: 'true'
  backups_enabled: 'false'
```

Then, download the `ikat.pem` file from Google Drive as well and stick it in your `~/.ssh` folder. Now, you should be able to get a list of the droplets that are running:

```
$ bundle exec tugboat droplets
fury (ip: 104.131.33.41, status: active, region: 8, id: 2484986)
```
