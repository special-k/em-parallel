require "em-synchrony/em-http"
require "em-http-request"

def response url
  EventMachine::HttpRequest.new(url).get.response
end

#TODO
#def post; end
#def put; end
#def delete; end
