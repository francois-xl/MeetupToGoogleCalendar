require 'spec_helper'

module MeetupToGoogleCalendar
  describe TransfertControler do
    before do
      meetup_group_urlname = "GeekZoneLondon"
      api_key = "457814a4b4336503971717b681f3f7b"
      calendar_id =  "tr35eq66n1hlp8eg35avto1350@group.calendar.google.com"
      @transfert_controler = MeetupToGoogleCalendar::TransfertControler.new(meetup_group_urlname, api_key, calendar_id)
    end

    describe "#events" do
      it "returns the list of public meetup events" do
        expect(@transfert_controler.events).not_to be nil
        expect(@transfert_controler.events).to be_a(Array)
      end
    end

    describe "#synchronize" do
      it "add the event to the google calendar" do
      @transfert_controler.synchronize
      end
    end

  end
end