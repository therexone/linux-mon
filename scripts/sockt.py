import asyncio
import datetime
import random
import websockets
import json
from data import getDeviceInfo

async def sendBatteryLevel(websocket, path):
    while True:
        deviceInfo = getDeviceInfo()
        await websocket.send(json.dumps(deviceInfo))
        await asyncio.sleep(random.random() * 20)

start_server = websockets.serve(sendBatteryLevel, "0.0.0.0", 5678)

asyncio.get_event_loop().run_until_complete(start_server)
asyncio.get_event_loop().run_forever()