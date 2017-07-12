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
          client.device_benefits.map { |device_benefit| self.factory(device_benefit) }
        end

        # @return (DeviceBenefit) Returns Apple TV benefits information for this account        
        # @param candidates (Array<DeviceBenefit>) searches through a list that was previously retrieved from Apple 
        def apple_tv(candidates = all)
          Array(candidates).select{ |benefit| benefit.device_class == "AppleTV" }.first
        end

        # @return (DeviceBenefit) Returns Apple Qatch benefits information for this account
        # @param candidates (Array<DeviceBenefit>) searches through a list that was previously retrieved from Apple 
        def watch(candidates = all)
          Array(candidates).select{ |benefit| benefit.device_class == "WATCH" }.first
        end

        # @return (DeviceBenefit) Returns iPad benefits information for this account
        # @param candidates (Array<DeviceBenefit>) searches through a list that was previously retrieved from Apple 
        def ipad(candidates = all)
          Array(candidates).select{ |benefit| benefit.device_class == "IPAD" }.first
        end

        # @return (DeviceBenefit) Returns iPhone benefits information for this account
        # @param candidates (Array<DeviceBenefit>) searches through a list that was previously retrieved from Apple 
        def iphone(candidates = all)
          Array(candidates).select{ |benefit| benefit.device_class == "IPHONE" }.first
        end

        # @return (DeviceBenefit) Returns iPod benefits information for this account
        # @param candidates (Array<DeviceBenefit>) searches through a list that was previously retrieved from Apple 
        def ipod_touch(candidates = all)
          Array(candidates).select{ |benefit| benefit.device_class == "IPOD" }.first
        end

        # @return (Array<DeviceBenefit>) Returns all device benefits that support iOS profiles (all devices except TVs)
        # @param candidates (Array<DeviceBenefit>) searches through a list that was previously retrieved from Apple 
        def all_ios_profile_devices(candidates = all)
          Array(candidates).reject { |device| device.device_type == "AppleTV" }
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
