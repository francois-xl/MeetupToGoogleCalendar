require "MeetupToGoogleCalendar/version"
require "rmeetup"
require "GoogleCalendarApiWrapper/googlecalendarapiwrapper"

module MeetupToGoogleCalendar
  class TransfertControler
    def initialize(meetup_group_urlname, api_key, calendarid, client_secrets_path = nil)
      @meetup_group_urlname = meetup_group_urlname
      @api_key = api_key
      @googlewrapper = GoogleCalendarApiWrapper::GoogleCalendarApiWrapper.new(calendarid, client_secrets_path)
    end

    ##
    # Print the name of the 
    #
    # @return the list of event for the given meetup group
    def events(limit = nil)
      get_events(limit)
      
      count = @event_list.count
      puts "A total of #{count.to_s} upcoming event(s) found on the Meetup group '#{@meetup_group_urlname}'"
      i = 1
      @event_list.each do |event|
        puts "- #{i}: #{event.name}; start date : #{event.time.to_s}"
        i+=1
      end
      
      @event_list
    end

    ##
    # Push all the retreived events to the given google calendar
    #
    def synchronize(limit = nil)
      get_events(limit) unless @event_list
      count = @event_list.count
      puts count.to_s + " will be added to the google calendar"
      result = true
      @event_list.each do |event|
        #event.duration = 10800000 unless event.duration;
        # TODO: Warning, event.duration may sometimes not be set, will it be nil ? or 0 ? will the addition work ? need to test this
        if @googlewrapper.add_event(event.name, event.time, event.time + Rational(3 * 60 * 60, 24* 60 * 60), event.timezone)
          result = result && true
        else
          result = result && false
        end
      end
      result
    end

    private

    ##
    # Retreive and store the upcoming meetup event list from the given meetup group using the meetup API
    #
    def get_events(limit = nil)
      client = RMeetup::Client.new do |config|
        config.api_key = @api_key
      end
      if limit == nil
        page_limit = 10
      else
        page_limit = limit
      end
      @event_list = client.fetch(:events, { :group_urlname => @meetup_group_urlname,
                                            :status => 'upcoming',
                                            :fields => 'timezone',
                                            :page => page_limit })
    end
  end
end
