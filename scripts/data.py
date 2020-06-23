import psutil

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