require "jekyll-assets"
require "uglifier"
Sprockets.register_compressor 'application/javascript',
  :my_uglifier, Uglifier.new(:mangle => false)