import asyncio
import datetime
import random
import websockets
import json
import daemon
import psutil
import os
from termcolor import colored


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
    data['sensor_temperatures'] = psutil.sensors_temperatures(fahrenheit=False)
    data['battery_percentage'] = battery.percent
    data['plugged'] = battery.power_plugged
    data['approx_sec_left'] = battery.secsleft
    
    return data
    

async def sendBatteryLevel(websocket, path):
    while True:
        deviceInfo = getDeviceInfo()
        await websocket.send(json.dumps(deviceInfo))
        await asyncio.sleep(random.random() * 5)


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
        
    