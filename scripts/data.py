import psutil

def getDeviceInfo():
    data = {}
    battery = psutil.sensors_battery()
    data['user'] = psutil.users()[0].name
    data['cpu_freq'] = psutil.cpu_freq()
    data['ram_usage'] = psutil.virtual_memory().percent
    data['disk_usage'] = psutil.disk_usage('/').percent
    data['sensor_temperatures'] = psutil.sensors_temperatures(fahrenheit=False)
    data['battery_percentage'] = battery.percent
    data['plugged'] = battery.power_plugged
    data['approx_sec_left'] = battery.secsleft
    
    return data