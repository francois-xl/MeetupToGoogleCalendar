require 'spec_helper'

module MeetupToGoogleCalendar
  describe TransfertControler do
    before do
      meetup_group_urlname = "GeekZoneLondon"
      api_key = "0" # Change it for your own usage
      calendar_id =  "nothing@group.calendar.google.com" # Change it for your own usage
      if api_key == "0"
        puts "##### The Meetup API key and Calendar ID are not set. Edit the file 'spec/transfertcontroler_spec.rb' to define your own api key and calendar ID. For more information, check the README file. #####"
      end
      @transfert_controler = MeetupToGoogleCalendar::TransfertControler.new(meetup_group_urlname, api_key, calendar_id)
    end

    describe "#events" do
      it "returns the list of public meetup events" do
        result = @transfert_controler.events(3)
        expect(result).not_to be nil
        expect(result).to be_a(Array)
      end
    end

    describe "#synchronize" do
      it "add the event to the google calendar" do
      expect(@transfert_controler.synchronize(3)).to eq(true)
      end
    end

  end
end