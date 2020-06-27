## Running the server
**There are three ways to run the server on your machine:**
1. Download the single executable binary from `dist`

  [Download executable](https://github.com/therexone/linux-mon/scripts/dist/)

2. Run the `linux-dae-mon.py` file which creates a daemon, given all the requirements are installed frim `requirements.txt`

3. Run `server.py` separately, which runs just the server without creating a daemon

If you create a daemon, use below command to check the process details and Process ID
```
~$ ps axuw | grep linux-dae-mon
therexo+ 10308  0.0  0.4 127652 32304 ?        S    18:16   0:01 python linux-dae-mon.py
therexo+ 13081  0.0  0.0  14428  1040 pts/6    S+   18:50   0:00 grep --color=auto linux-dae-mon
```
Kill the process with 
```
~$ kill 10308
```

