$:<< File.expand_path(File.dirname(__FILE__) + '/../..')
require 'test_helper.rb'

class QBWCJobsTest < ActiveSupport::TestCase
  def setup
    QBWC.clear_jobs
  end

  test "add job with nil result" do
    QBWC.add_job(:model_test, true, '', QBWC::Worker)
    job = QBWC.get_job(:model_test)
    assert_nil job.requests
    assert_nil job.data
  end

  test "add job with qbxml string" do
    QBWC.add_job(:model_test, true, '', QBWC::Worker, '<?xml version="1.0" encoding="utf-8"?><?qbxml version="12.0"?><QBXML><QBXMLMsgsRq onError="stopOnError"><CustomerQueryRq></CustomerQueryRq></QBXMLMsgsRq></QBXML>')
    job = QBWC.get_job(:model_test)
    assert job.requests.is_a? String
    assert_match /QBXML/, job.requests
    assert_nil job.data
  end
end

