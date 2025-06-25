#Make practice script that prints current directory's path (pwd);
# automatically changes directory (cd) to some specific directory; 
# and prints all files in the current directory (ls) using subprocess.
import subprocess

subprocess.Popen("pwd")
#subprocess.Popen(['cd', 'examples/debuggerIshaan'], shell=True)
subprocess.Popen("ls", cwd='examples/debuggerIshaan')


