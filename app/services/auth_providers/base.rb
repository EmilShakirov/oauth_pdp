module AuthProviders
  class Base
    include Concord.new(:auth)

    delegate :extra, :info, to: :auth
  end
end
