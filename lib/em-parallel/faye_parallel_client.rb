require 'bundler/setup'
require 'securerandom'
require 'faye/websocket'
require 'msgpack'

class FayeParallelClient
  PACK_KEY = 'c*'
  attr_reader :ws
  def initialize url, use_fiber_on_start = false
    @fibers = {}
    @ws = Faye::WebSocket::Client.new url


    @ws.on :message do |event|
      #data = Yajl::Parser.parse( event.data )
      data = MessagePack.unpack event.data.pack PACK_KEY
      k = data[0]
      if  @fibers.include? k
        @fibers.delete(k).resume data[1]
      end
    end

    if use_fiber_on_start
      @ws.on :open do |event|
        @open_fiber.resume
      end

      @open_fiber = Fiber.current
      Fiber.yield
    end
  end

  def response v
    k = SecureRandom.base64
    fiber = Fiber.current
    @fibers[k] = fiber
    #@ws.send Yajl::Encoder.encode([k,v])
    @ws.send MessagePack.dump([k,v]).bytes
    Fiber.yield
  end
end
