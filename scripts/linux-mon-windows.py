# WINDOWS specific script

import psutil
import platform
import asyncio
import datetime
import random
import websockets
import json

def getDeviceInfo():
    data = {}
    battery = psutil.sensors_battery()
    ram =  psutil.virtual_memory()
    disk = psutil.disk_usage('/')
    swap = psutil.swap_memory()
    data['user'] = psutil.users()[0].name
    data['cpu_freq'] = psutil.cpu_freq()
    data['ram_data'] = {
        'percentage_used': ram.percent,
        'total': ram.total,
        'available': ram.available
    }
    data['disk_data'] = {
        'percentage_used': disk.percent,
        'total': disk.total,
        'free': disk.free
    }
    data['swap_data'] = {
        'percentage_used': swap.percent,
        'total': swap.total,
        'free': swap.free
    }
    if platform.system() != 'Windows':
        data['sensor_temperatures'] = psutil.sensor_temperatures(fahrenheit=False)
    else: 
        data['sensor_temperatures'] = {"acpitz":[["", 0.0, 0.0, 0.0]]}
    data['battery_percentage'] = battery.percent
    data['plugged'] = battery.power_plugged
    data['approx_sec_left'] = battery.secsleft
    
    return data
    


async def sendBatteryLevel(websocket, path):
    while True:
        deviceInfo = getDeviceInfo()
        await websocket.send(json.dumps(deviceInfo))
        await asyncio.sleep(2)

start_server = websockets.serve(sendBatteryLevel, "0.0.0.0", 5678)
print('---------- [L I N U X M O N] -------------\n Server started\n Press Ctrl + C or Close this window to stop the server')

asyncio.get_event_loop().run_until_complete(start_server)   
asyncio.get_event_loop().run_forever()