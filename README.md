# MeetupToGoogleCalendar

Retreive a list of public upcoming event from a Meetup group and add these events to an authorized Google Calendar. For this alpha version, there is a default limit of 10 events processed.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'MeetupToGoogleCalendar'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install MeetupToGoogleCalendar

## Usage

To be able to use this gem (or its command-line version), you will need to setup some configuration in the Meetup APi and Google API.

- On Meetup, you will need to login and generate an API key to authorize this gem to access the Meetup API. You can do this on this page : https://secure.meetup.com/meetup_api/key/

- On Google Calendar, you will have to login and then register a new client ID, which will provide you with a client secret file that will be use to authenticate you using the gem. You can do this on this page : https://console.developers.google.com/project/static-welder-101600/apiui/credential
Follow the step 1 described here : https://developers.google.com/google-apps/calendar/quickstart/ruby

- Finaly, you will have to get the calendar ID you want to modify using this gem. You can find your calendar ID by following these steps : http://googleappstroubleshootinghelp.blogspot.co.uk/2012/09/how-to-find-calendar-id-of-google.html

```ruby
transfert_controler = MeetupToGoogleCalendar::TransfertControler.new(meetup_group_urlname, api_key, calendar_id)
```

```ruby
	transfert_controler#events			#Returns the list of public meetup event for the given meetup group
	transfert_controler#synchronize		#Add the event list to the given google calendar account
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Command-line

After the gem installed, you will be able to use the command-line application for this gem. The executable is located in the lib/exe directory.

### Usage

    $ MeetupToGoogleCalendar [options] meetup_group_urlname meetup_api_key google_calendar_id

* meetup_group_urlname : Name of the Meetup group as it appear in the URL to this group
* meetup_api_key : Required key provided by Meetup to identify an user remotely using Meetup services
* google_calendar_id : Required Google calendar ID provided by Google to use one specific user's calendar

Use `MeetupToGoogleCalendar -h` to see other options

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/francois-xl/MeetupToGoogleCalendar.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

