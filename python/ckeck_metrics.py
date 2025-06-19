import paramiko

def get_metrics(host, user, password):
    client = paramiko.SSHClient()
    client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    client.connect(host, username=user, password=key_path)
    
    # Сбор CPU, памяти, диска
    stdin, stdout, stderr = client.exec_command("mpstat 1 5 | grep 'Average'")
    cpu_load = float(stdout.read().decode().split()[-2])
    
    stdin, stdout, stderr = client.exec_command("free -m | awk '/Mem:/ {print $3/$2*100}'")
    mem_usage = float(stdout.read().decode().strip())
    
    return {'cpu': cpu_load, 'memory': mem_usage}

if __name__ == "__main__":
    servers = [
        {
            # alt linux
            "host":"192.168.0.191",
            "user":"root",
            "password":"root"
        },
        {
            # astra linux
            "host":"192.168.0.192",
            "user":"devops",
            "password":"astradevops"   
        },
        {
            #redos
            "host":"192.168.0.193",
            "user":"root",
            "password":"root" 
        }
    ]

    for server in servers:
        print(get_metrics(server["host"], server["user"], server["password"]))