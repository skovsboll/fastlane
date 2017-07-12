module Spaceship
  module Portal
    # Represents a device from the Apple Developer Portal
    class DeviceBenefit < PortalBase
      # @return (String) The ID given from the developer portal. You'll probably not need it.
      # @example
      #   "42"
      attr_accessor :id

      # @return (Integer) The maximum number of slots for this class of devices in the account
      attr_accessor :max

      # @return (Integer) The number of slots left in the account for this class of devices
      attr_accessor :available

      # @return (String) The platform of the device. This is probably always "ios"
      # @example
      #   "ios"
      attr_accessor :platform

      # @return (String) Device class enum
      # @example
      #   'AppleTV'
      #   'WATCH'
      #   'IPAD'
      #   'IPOD'
      #   'IPHONE'
      attr_accessor :device_class

      # @return (String) Device type
      # @example
      #   'watch'  - Apple Watch
      #   'ipad'   - iPad
      #   'iphone' - iPhone
      #   'ipod'   - iPod
      #   'tvOS'   - Apple TV
      attr_accessor :device_type

      attr_mapping({
        'benefitId' => :id,
        'deviceClassEnum' => :device_class,
        'platform' => :platform,
        'maxQuantity' => :max,
        'availableQuantity' => :available
      })

      class << self
        # @return (Array) Returns all device benefits registered for this account
        def all()
          client.device_benefits().map { |device_benefit| self.factory(device_benefit) }
        end

        # @return (DeviceBenefit) Returns Apple TV benefits information for this account
        def apple_tvs
          all.first{ |benefit| benefit.device_class == "AppleTV" }
        end

        # @return (DeviceBenefit) Returns Apple Qatch benefits information for this account
        def watches
          all.first{ |benefit| benefit.device_class == "WATCH" }
        end

        # @return (DeviceBenefit) Returns iPad benefits information for this account
        def ipads
          all.first{ |benefit| benefit.device_class == "IPAD" }
        end

        # @return (DeviceBenefit) Returns iPhone benefits information for this account
        def iphones
          all.first{ |benefit| benefit.device_class == "IPHONE" }
        end

        # @return (DeviceBenefit) Returns iPod benefits information for this account
        def ipod_touches
          all.first{ |benefit| benefit.device_class == "IPOD" }
        end

        # @return (Array<DeviceBenefit>) Returns all device benefits that support iOS profiles (all devices except TVs)
        def all_ios_profile_devices
          all.reject { |device| device.device_type == "AppleTV" }
        end
      end

      def full?
        return self.available == 0
      end

      def empty?
        return self.available == self.max
      end

    end
  end
end
