load File.join(__dir__, '../lib/v2web/model_extensions.rb')
load File.join(__dir__, 'v2plus.rb')
load File.join(__dir__, 'v2plus_toc.rb')

V2_VERSION = '2023.0' unless defined?(V2_VERSION)

V2Pub.build_site(:demo)
