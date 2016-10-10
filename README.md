# Ikat

Ikat is an easy way to collect the products you love.

## Installation

### Development

Right now it's a pretty basic Ruby on Rails install. The follow dependencies are required:

- Ruby 2.1.1 (through [rbenv](http://rbenv.org/), preferrably)
- MongoDB 2.3.6
- Redis 2.8.12

You'll need a few environment variables. Add them as Yaml in `.env`.

Variable              | Description
----------------------|------------------
AWS_ACCESS_KEY_ID     | An AWS access key ID.
AWS_SECRET_ACCESS_KEY | An AWS secret access key.
AWS_S3_BUCKET         | The bucket you want to save uploads to.
PUSHER_APP_ID         | A Pusher app ID.
PUSHER_KEY            | A Pusher app key.
PUSHER_SECRET         | A Pusher app secret.
SENTRY_DSN            | DSN from Sentry. Not entirely necessary in development.

After those are all installed, just use Bundler and the built-in Rails rake tasks:

1. `bundle install`
2. `bundle exec rake db:create`
3. `bundle exec rake db:seed`

After that, it may be wise to run the test suite to make sure everything it working properly:

- `bundle exec rspec spec`

To start the server and workers:

- `bundle exec foreman start -f Procfile.development`

