# frozen_string_literal: true

require "test_helper"

class TestPIDCache < Minitest::Test
  def test_resets_cache_on_fork
    skip("Fork isn't supported") unless Process.respond_to?(:fork)

    r, w = IO.pipe

    pid = Process.pid
    pid = Process.fork do
      r.close
      w << "ok: #{Process.pid}"
      w.close
    ensure
      exit!
    end

    w.close
    assert_equal("ok: #{pid}", r.read)
    r.close
    Process.waitpid(pid)
  end
end
