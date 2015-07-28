require 'spec_helper'

module MeetupToGoogleCalendar
  describe TransfertControler do
    before do
     @transfert_controler = MeetupToGoogleCalendar::TransfertControler.new("http://www.meetup.com/GeekZoneLondon/")
    end
      
    describe "#events" do
      it "returns the list of public meetup events" do
        #expect(@transfert_controler.events).not_to be nil
        expect(@transfert_controler.events).to be_a(Array)
      end
    end

=begin
    describe "#synchronize" do
      it "returns the http status of the page" do
        expect(@transfert_controler.status).to eql("200 OK")
      end
    end
=end
    
  end
end