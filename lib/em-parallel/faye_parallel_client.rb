require 'bundler/setup'
require 'securerandom'
require 'faye/websocket'
require 'msgpack'

class FayeParallelClient
  PACK_KEY = 'c*'
  attr_reader :ws, :url
  def initialize url, use_fiber_on_start = false
    @fibers = {}
    @url = url
    @ws = Faye::WebSocket::Client.new "ws://#{ url }"

    @ws.on :message do |event|
      data = Marshal.load event.data.pack PACK_KEY
      k = data[0]
      if  @fibers.include? k
        @fibers.delete(k).resume data[1]
      end
    end

    #to send the message immediately after a connection (for example)
    #(initialization must occur within a fiber)
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
    @ws.send Marshal.dump([k,v]).bytes
    Fiber.yield
  end

  def simple_send v
    @ws.send Marshal.dump(v).bytes
  end

  def to_hash
    { url: @url }
  end

  def close
    @ws.close
  end

end
