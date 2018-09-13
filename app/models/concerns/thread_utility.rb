module ThreadUtility
  extend ActiveSupport::Concern

  def thread(&block)
    Thread.new { db(&block) }
  end

  def db(&block)
    yield block
  ensure
    # Check the connection back in to the connection pool
    ActiveRecord::Base.connection&.close
  end
end
