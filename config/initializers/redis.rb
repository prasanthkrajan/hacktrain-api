$redis = Redis::Namespace.new("hacktrain-api", :redis => Redis.new)
#$cache = ActiveSupport::Cache::MemoryStore.new