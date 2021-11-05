# crystal_can

Crystal CAN adds the ability to read from a Linux SocketCAN interface.

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     crystal_can:
       github: zaben903/crystal_can
   ```

2. Run `shards install`

## Usage

```crystal
require "crystal_can"

client = CrystalCan::Client.new
response = client.receive
```

Returned from the receive action is a LibC::CanFrame struct using the struct from `/linux/can.h`

## Development

setting up `vcan0` interface:
```bash
sudo ip link add dev vcan0 type vcan
sudo ifconfig vcan0 up
```

Testing reading CAN packets can be done using:
```bash
apt install can-utils
cansend vcan0 "01a#11223344"
```

## Contributing

1. Fork it (<https://github.com/zaben903/crystal_can/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Zach Bensley](https://github.com/zaben903) - creator and maintainer
