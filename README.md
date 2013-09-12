# em-parallel

Library for combinate sync and async code parts.

## Examples of using

```ruby
require "em-synchrony/em-http"
require "em-http-request"
require 'em-parallel'
require 'em-parallel/http_helpers'

EM.run{

  EM.parallel{|s|
    s.fiber_resume{
      response 'http://yandex.ru'
      p 'bbb1'
    }
    s.fiber_resume{
      response 'http://google.ru'
      p 'bbb2'
    }
    p 'aaa'
    s.wait #waiting above requests
    p 'ccc'

    s.fiber_resume{
      response 'http://ya.ru'
      p '222a'
    }
    s.fiber_resume{
      response 'http://yahoo.ru'
      p '222b'
    }
    p '111'
    s.wait #again waiting above requests
    p '333'

    EventMachine.stop #the end
  }

}
#result
"aaa"
"bbb2"
"bbb1"
"ccc"
"111"
"222a"
"222b"
"333"

```

```ruby
require "em-synchrony/em-http"
require "em-http-request"
require 'em-parallel'
require 'em-parallel/http_helpers'

EM.run{

  EM.parallel{|s|
    s.fiber_resume{
      response 'http://yandex.ru'
      p 'bbb1'
    }
    s.fiber_resume{
      response 'http://google.ru'
      p 'bbb2'
    }
    p 'aaa'
    s.wait
    p 'ccc'
  }

  EM.parallel{|s|
    s.fiber_resume{
      response 'http://ya.ru'
      p '222a'
    }
    s.fiber_resume{
      response 'http://yahoo.ru'
      p '222b'
    }
    p '111'
    s.wait
    p '333'
  }

  #non stop

}
#pretty parallel ^_^
"aaa"
"111"
"bbb2"
"222a"
"222b"
"333"
"bbb1"
"ccc"
```

```ruby
require "em-synchrony/em-http"
require "em-http-request"
require 'em-parallel'
require 'em-parallel/http_helpers'

EM.run{

  EM.parallel{|s|
    s.fiber_resume{
      Fiber.new{
        response 'http://yandex.ru'
        p 'no mather query'
      }.resume
      response 'http://google.ru'
      p 'bbb1'
    }
    s.fiber_resume{
      response 'http://yahoo.ru'
      response 'http://yandex.ru'
      p 'bbb2'
    }
    p 'aaa'
    s.wait
    p 'ccc'
    EventMachine.stop
  }

}
```

## Contributing to em-parallel
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## TODO
* Probably I think about clean beautiful framework for doing stuff like this.
* tests

## Copyright

Copyright (c) 2013 Kirill Jakovlev. See LICENSE.txt for
further details.

