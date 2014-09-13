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

After those are all installed, just use Bundler and the built-in Rails rake tasks:

1. `bundle install`
2. `bundle exec rake db:create`
3. `bundle exec rake db:seed`

After that, it may be wise to run the test suite to make sure everything it working properly:

- `bundle exec rspec spec`

To start the server and workers:

- `bundle exec foreman start -f Procfile.development`

### Production

We run all of our servers on [Amazon Web Services](https://aws.amazon.com). Here's our current list of EC2 instances:

Name      | Full Name        | Instance ID  | Purpose                  | Active  
----------|------------------|--------------|--------------------------|---------------
`lmd`     | Life-Model Decoy | `i-f959d8d4` | Staging                  | Yes
`fury`    | Nick Fury        |              | Load-balancer, utility   | No
`ironman` | Ironman          |              | Application              | No
`thor`    | Thor             |              | Application              | No
`coulson` | Agent Coulson    |              | MongoDB, Redis, Memcache | No

To deploy to staging or production, it's as easy as using Capistrano:

```
$ bundle exec cap [production|staging] deploy
```
