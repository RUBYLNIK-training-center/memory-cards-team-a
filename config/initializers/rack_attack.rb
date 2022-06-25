class Rack::Attack
   if !ENV['REDIS_URL'] || Rails.env.test?
    cache.store = ActiveSupport::Cache::MemoryStore.new
   end
   cache.store = Redis.new(url: ENV['REDIS_FOR_RACK_ATTACK_URL']) if ENV['REDIS_FOR_RACK_ATTACK_URL']
  # Rack::Attack.cache.store = Rack::Attack::StoreProxy::RedisStoreProxy.new(Redis.current)
    def remote_ip
        @remote_ip ||= (env['HTTP_CF_CONNECTING_IP'] || env['action_dispatch.remote_ip'] || ip).to_s
    end

  throttle("limit logins per email", :limit => 2, :period => 20.seconds) do |req|
     if req.path == "en/users/sign_in" && req.post?
      if (req.params["user"].to_s.size > 0) and (req.params["user"]["email"].to_s.size > 0)
        req.params["user"]["email"]
      end
    end
      end

    throttle("/", :limit => 2, :period => 20.seconds) do |req|
      req.ip if req.path == "/" or req.path == "/en/instructions"
    end

  (3..5).each do |level|
    throttle("req/ip/#{level}",
             limit: (30 * (2 ** level)),
             period: (0.9 * (8 ** level)).to_i.seconds) do |req|
      req.remote_ip unless req.path.starts_with?('/') || req.path.include?('/en/instructions') || req.path.starts_with?('user_data')
    end
  end

  self.throttled_responder = lambda do |env|
    [ 503,  # status
      {},   # headers
      ['']] # body
  end

      ActiveSupport::Notifications.subscribe(/rack_attack/) do |name, start, finish, request_id, payload|
        puts payload[:request].inspect
      end
end