import asyncio
import datetime
import random
import websockets
import json
import daemon
import psutil
import os
from termcolor import colored
from data import *

   

async def sendBatteryLevel(websocket, path):
    while True:
        deviceInfo = getDeviceInfo()
        await websocket.send(json.dumps(deviceInfo))
        await asyncio.sleep(1)


def daemon_process():
    start_server = websockets.serve(sendBatteryLevel, "0.0.0.0", 5678)

    asyncio.get_event_loop().run_until_complete(start_server)
    asyncio.get_event_loop().run_forever()
    


if __name__ == '__main__':
    print('--------LINUX MON-------')
    print('Starting server daemon at port 5678...')
    print(colored('Started websocket server at ws://localhost:5678', 'green'))
    print('To stop the server get daemon PID')
    print(colored('ps axuw | grep linux-dae-mon', 'yellow'))
    print(colored('kill <pid>\n', 'red'))    
    with daemon.DaemonContext():
        daemon_process()
        print(os.getpid())
        
    
