# frozen_string_literal: true

require_relative "pid_cache/version"

module PIDCache
  if Process.respond_to?(:_fork) # Ruby 3.1+
    ORIGINAL_METHOD = Process.method(:pid)

    class << self
      def pid
        @pid ||= ORIGINAL_METHOD.call
      end

      def reset
        @pid = nil
      end
    end

    module CoreExt
      def _fork
        child_pid = super
        ::PIDCache.reset if child_pid == 0
        child_pid
      end

      def pid
        ::PIDCache.pid
      end
    end

    Process.singleton_class.prepend(PIDCache::CoreExt)
  end
end
