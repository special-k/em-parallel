require "eventmachine"
begin
  require "fiber"
rescue LoadError => error
  raise error unless defined? Fiber
end

module EM
  module Parallel
    class Scope

      attr_reader :fibers, :fiber

      def initialize
        @fibers = []
        @fiber_resume = []
        @is_waiting = false

        @fiber = Fiber.new{
          yield self
        }
      end

      def wait
        @is_waiting = true
        until @fibers.empty?
          Fiber.yield
        end
        @is_waiting = false
      end

      def fiber_resume
        f = Fiber.new{
          yield
          @fibers.delete Fiber.current
          if @is_waiting
            @fiber.resume
          end
        }
        @fibers << f
        f.resume
      end

    end # class Scope
  end # module Parallel
end # module EM

module EM
  def self.parallel &block
    Parallel::Scope.new( &block ).fiber.resume
  end
end
