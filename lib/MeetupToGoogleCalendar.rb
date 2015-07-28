require "MeetupToGoogleCalendar/version"
require "rmeetup"

module MeetupToGoogleCalendar
  class TransfertControler
    def initialize(meetup_group_url, api_key)
      @meetup_group_url = meetup_group_url
      @api_key = api_key
    end
    
    def events     
      []
    end
  end
end
