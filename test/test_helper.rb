require 'minitest'
require 'minitest/reporters'

$LOAD_PATH << File.join(File.dirname(__FILE__), "..", "lib")
$LOAD_PATH << File.join(File.dirname(__FILE__), "..", "lib", "simple_mvc")

Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new({detailed_skip: false})]
