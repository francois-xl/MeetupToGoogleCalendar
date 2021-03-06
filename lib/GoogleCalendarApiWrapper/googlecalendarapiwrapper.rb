require 'google/api_client'
require 'google/api_client/client_secrets'
require 'google/api_client/auth/installed_app'
require 'google/api_client/auth/storage'
require 'google/api_client/auth/storages/file_store'
require 'fileutils'

module GoogleCalendarApiWrapper
  class GoogleCalendarApiWrapper
    def initialize(calendarId, client_secrets_path = nil)
      @APPLICATION_NAME = 'MeetupToGoogleCalendar'
      @CREDENTIALS_PATH = File.join(Dir.home, '.credentials',
                               "meetuptogooglecalendar.json")
      @SCOPE = 'https://www.googleapis.com/auth/calendar'

      @calendarId = calendarId
      if client_secrets_path
        @CLIENT_SECRETS_PATH = client_secrets_path
      else
        @CLIENT_SECRETS_PATH = File.join(Dir.home, 'client_secret.json')
      end
      puts "Client secret is here : #{@CLIENT_SECRETS_PATH}"

      # Initialize the API
      @client = Google::APIClient.new(:application_name => @APPLICATION_NAME)
      @client.authorization = authorize
      @calendar_api = @client.discovered_api('calendar', 'v3')
    end

    ##
    # Ensure valid credentials, either by restoring from the saved credentials
    # files or intitiating an OAuth2 authorization request via InstalledAppFlow.
    # If authorization is required, the user's default browser will be launched
    # to approve the request.
    #
    # @return [Signet::OAuth2::Client] OAuth2 credentials
    def authorize
      FileUtils.mkdir_p(File.dirname(@CREDENTIALS_PATH))

      file_store = Google::APIClient::FileStore.new(@CREDENTIALS_PATH)
      storage = Google::APIClient::Storage.new(file_store)
      auth = storage.authorize

      if auth.nil? || (auth.expired? && auth.refresh_token.nil?)
        app_info = Google::APIClient::ClientSecrets.load(@CLIENT_SECRETS_PATH)
        flow = Google::APIClient::InstalledAppFlow.new({
          :client_id => app_info.client_id,
          :client_secret => app_info.client_secret,
          :scope => @SCOPE})
        auth = flow.authorize(storage)
        puts "Credentials saved to #{@CREDENTIALS_PATH}" unless auth.nil?
      end
      auth
    end

    def add_event(name, starttime, endtime, timezone)
      # TODO:
      event = {
        'summary' => name,
        'start' => {
          'dateTime' => starttime,
          'timeZone' => timezone,
        },
        'end' => {
          'dateTime' => endtime,
          'timeZone' => timezone,
        },
      }

      results = @client.execute!(
      :api_method => @calendar_api.events.insert,
      :parameters => {
        :calendarId => @calendarId},
      :body_object => event)
      event = results.data
      puts "Event created: #{event.htmlLink}"
      event
    end
  end
end
