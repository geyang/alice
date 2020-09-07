import asyncio
import yaml
import sys

block_size = 64


async def handle_echo(reader, writer):
    header_str = None
    while True:
        data = await reader.read(block_size)
        if data == b'':
            break
        if header_str is None:
            *header_str, data = data.split(b'\n---\n')
            if header_str:
                print("header >>>", header_str)
                header = yaml.load(b''.join(header_str).decode('utf-8'), Loader=yaml.FullLoader)
                print(header)

        message = data.decode()
        # addr = writer.get_extra_info('peername')
        print(message, end="")
        sys.stdout.flush()

    print("Closed the connection")
    writer.close()


async def main():
    server = await asyncio.start_server(handle_echo, '0.0.0.0', 8888)

    addr = server.sockets[0].getsockname()
    print(f'Serving on {addr}')

    async with server:
        await server.serve_forever()


asyncio.run(main())
