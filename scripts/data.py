import psutil
import platform

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
        data['sensor_temperatures'] = psutil.sensors_temperatures(fahrenheit=False)
    else: 
        data['sensor_temperatures'] = {"acpitz":[["", 0.0, 0.0, 0.0]]}
    data['battery_percentage'] = battery.percent
    data['plugged'] = battery.power_plugged
    data['approx_sec_left'] = str(battery.secsleft)

    print(data["battery_percentage"], data["plugged"], data['approx_sec_left'])
    return data
    

