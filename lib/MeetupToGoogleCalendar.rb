require "MeetupToGoogleCalendar/version"
require "rmeetup"
require "GoogleCalendarApiWrapper/googlecalendarapiwrapper"

module MeetupToGoogleCalendar
  class TransfertControler
    def initialize(meetup_group_urlname, api_key, calendarid)
      @meetup_group_urlname = meetup_group_urlname
      @api_key = api_key
      @googlewrapper = GoogleCalendarApiWrapper::GoogleCalendarApiWrapper.new(calendarid)
    end

    ##
    # TODO:
    #
    # @return the list of event for the given meetup group
    def events
      get_events
      @event_list
    end

    ##
    # Push all the retreive events to the given google calendar
    #
    def synchronize
      get_events unless @event_list

      puts "Count : " + @event_list.count.to_s
      @event_list.each do |event|
        #puts "Event : " + event.inspect
        #event.duration = 10800000;
        @googlewrapper.add_event(event.name, event.time, event.time + Rational(3 * 60 * 60, 24* 60 * 60), event.timezone)
        puts "Ajouté !"
      # TODO: Warning, event.duration may sometimes not be set, will it be nil ? or 0 ? will the addition work ? need to test this
      end
    end

    private

    ##
    # Verify that the application have authorization to access the google calendar
    #
    def verify_google_authorization
      #TODO:
    end

    ##
    # Retreive and store the upcoming meetup event list from the given meetup group using the meetup API
    #
    def get_events
      client = RMeetup::Client.new do |config|
        config.api_key = @api_key
      end

      @event_list = client.fetch(:events, { :group_urlname => @meetup_group_urlname,
                                            :status => 'upcoming',
                                            :fields => 'timezone',
                                            :page => 3 })
    end
  end
end
