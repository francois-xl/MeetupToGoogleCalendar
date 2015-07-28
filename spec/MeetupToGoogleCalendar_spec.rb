require 'spec_helper'

describe MeetupToGoogleCalendar do
  it 'has a version number' do
    expect(MeetupToGoogleCalendar::VERSION).not_to be nil
  end

  it 'loads a website class' do
    expect(MeetupToGoogleCalendar::TransfertControler).to be_a(Class)
  end
end
