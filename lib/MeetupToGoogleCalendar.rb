require "MeetupToGoogleCalendar/version"
require "rmeetup"

module MeetupToGoogleCalendar
  class TransfertControler
    def initialize(meetup_group_url, api_key)
      @meetup_group_url = meetup_group_url
      @api_key = api_key
      event_list
      
    end
    
    def events     
      event_list.each do |result|
        # Do something with the result
      end 
      event_list
    end
    
    private
    
    def get_events
      client = RMeetup::Client.new do |config|
        config.api_key = @api_key
      end
    
      event_list = client.fetch(:events, { event_id: 'some_id' })      
    end
  end
end
