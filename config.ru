require './index'
require 'rack/contrib'

# Overwrite server header for security reasons...
# NB: must be > 0 length string to prevent Thin server
# setting its own value
use Rack::ResponseHeaders do |headers|
  headers['Server'] = ' '
end

run Sinatra::Application
$stdout.sync = true
$stderr.sync = true