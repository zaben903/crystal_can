lib LibC
  struct CanFrame
    can_id : UInt32 # 32 bit CAN_ID + EFF/RTR/ERR flags
    len : UInt8     # frame payload length in byte
    flags : UInt8   # additional flags for CAN FD
    res0 : UInt8    # reserved / padding
    res1 : UInt8    # reserved / padding
    data : StaticArray(UInt8, 64) # FD payload length: ISO 11898-7
  end
end

module CrystalCan
  class Client
    include IO::Evented
    include IO::Buffered

    def initialize
      @socket = LibC.socket(PF_CAN, Socket::Type::RAW, CAN_RAW)

      addr = can_address
      @check_open = false
      if LibC.bind(@socket, pointerof(addr), sizeof(LibC::Sockaddr))
    		@check_open = true
    	end
    end

    def can_address : LibC::Sockaddr
      addr = LibC::Sockaddr.new()
      addr.sa_family = 29
      addr
    end

    def receive : LibC::CanFrame
      frame = LibC::CanFrame.new
      LibC.read(@socket, pointerof(frame), sizeof(LibC::CanFrame))
      frame
    end

    # def receive : Array(Char)
    #   max_message_size = 64
    #   message = String.new(max_message_size) do |buffer|
    #     bytes_read = unbuffered_read(Slice.new(buffer, max_message_size))
    #     {bytes_read, 0}
    #   end
    #   message.chars
    # end

    private def unbuffered_read(slice : Bytes)
      evented_read(slice, "Error reading socket") do
        LibC.read(@socket, slice, slice.size)
      end
    end

    private def unbuffered_write(slice : Bytes)
    end

    private def unbuffered_flush()
    end

    private def unbuffered_close()
    end

    private def unbuffered_rewind()
    end

    def fd
      @socket
    end
  
  	def check_open : Bool
  		@check_open
  	end
  end
end
