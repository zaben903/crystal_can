require "socket"

require "./crystal_can/client"

# TODO: Write documentation for `CrystalCan`
module CrystalCan
  VERSION = "0.1.0"

  PF_CAN  = Socket::Family.new(29)
  CAN_RAW = Socket::Protocol.new(1)
end
