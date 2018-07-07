#pyinstaller --onefile --icon=lightning.png THUNKIT_GAIT.pyw

from tkinter import *
from tkinter import ttk
from tkinter import messagebox
from tkinter import filedialog
import tkinter as tk
import time
import serial
import re
import serial.tools.list_ports
import sys
import matplotlib
matplotlib.use("TkAgg")
from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg, NavigationToolbar2TkAgg
from matplotlib.figure import Figure

ser = "null"

globalPortSelect = ""

ports = list(serial.tools.list_ports.comports())

def serialAvailable():
    global ser #really Python...
    flag = 0
    try:
        flag = ser.inWaiting()
    except:
        print("Error reading from COM port")
        messagebox.showerror("Error", "Error reading from COM port")
        flag = 0
    return flag

def saveData():
    csvFile = filedialog.asksaveasfile(mode='w', defaultextension=".csv")
    if csvFile is None:
        return
    print("Saving data...")
    for i in range(0, len(x_axis)):
        csvFile.write(str(x_axis[i]) + ", " + str(y_axis[i]) + "\n")
        print(str(x_axis[i]) + ", " + str(y_axis[i]))
    csvFile.close()
    print("Done saving.")

def downloadData():
    selectedPort = variable.get()
    print(selectedPort)
    portCrop = str(selectedPort).find(" ")
    comPort = str(selectedPort)[0: portCrop]
    comPort = comPort.replace("('", '') #Windows
    comPort = comPort.replace("'", '') #Windows
    try:
        global ser
        ser = serial.Serial(comPort, 9600)
    except:
        ser = "null"
        print("Error opening selected COM port.")
        messagebox.showerror("Error", "Error opening selected COM port.")
    if (ser == "null" or ser == "Select COM Port"):
        print("Please select COM port first.")
        messagebox.showerror("Error", "Please select COM port first.")
        return
    print("Downloading data...")
    global x_axis
    global y_axis
    y_axis = [-2] #used later in the loop
    x_axis = [0]
    a.clear()
   # a.set_xticklabels([0, 1], rotation = 45)
    try:
        ser.write('d'.encode('utf-8'))
    except:
        print("Error writing to COM port")
        messagebox.showerror("Error", "Error writing to COM port")
    time.sleep(0.1)
    while serialAvailable():
        try:
            line = str(ser.readline())
        except:
            print("Error reading from COM port")
            messagebox.showerror("Error", "Error reading from COM port")
        print(line)
        line = line.replace("--", "")
        line = line.replace("b", "")
        line = line.replace("d", "")
        line = line.replace("'", "")
        line = line.replace(r"\n", "")
        if (line == ""):
            return
        #if ("\\" in line or line == ''):
        #    return
        if (not int(line)):
            return
        if (y_axis[0] == -2):
            y_axis[0] = int(line) - 1000
        else:
            y_axis.append(int(line) - 1000)
            x_axis.append(round(x_axis[-1] + 0.2, 1))
        time.sleep(0.005)
    a.set_xticklabels(x_axis, rotation = 90)
    a.plot(x_axis, y_axis, '#ff0000')
    a.set_title("Recorded Altitude")
    a.set_xlabel("Time (s)")
    a.set_ylabel("Altitude (m)")
    print(x_axis)
    canvas.draw()
    print("Done downloading.")
    updatePorts() #Windows bug can't download data twice without re-selecting

#Create Graph
LARGE_FONT= ("Verdana", 12)
root = Tk()
root.title("THUNKIT GAIT")
root.config(bg="#ffdddd")
mainframe = ttk.Frame(root, padding="1000 1000 1000 1000")
f = Figure(figsize=(5,5), dpi=100)
a = f.add_subplot(111)
a.set_title("Recorded Altitude")
a.set_xlabel("Time (s)")
a.set_ylabel("Altitude (m)")
a.figure.set_facecolor("#f9f9f9")
#a.set_facecolor("#ff8080")
#a.set_xticklabels([0, 1], rotation = 45)
#a.legend()
canvas = FigureCanvasTkAgg(f, root)
canvas.show()
canvas.get_tk_widget().pack(side=tk.BOTTOM, fill=tk.BOTH, expand=True)
canvas._tkcanvas.pack(side=tk.TOP, fill=tk.BOTH, expand=True)
y_axis = [-2] #used later in the loop
x_axis = [0]

#Download Data Button
b = Button(root, text="Download", command=downloadData)
b.config(bg="#ff8080")
b.pack(side = tk.LEFT, fill = tk.BOTH)

b3 = Button(root, text="Save", command=saveData)
b3.pack(side = tk.LEFT, fill = tk.BOTH)

def updatePorts():
    ports = list(serial.tools.list_ports.comports())
    if (not ports):
        variable.set("No COM ports found.")
    else:
        variable.set("Select COM port.")
    w['menu'].delete(0, 'end')
    for i in ports:
        w['menu'].add_command(label = i, command = tk._setit(variable, i))

b2 = Button(root, text="Refresh", command=updatePorts)
b2.pack(side = tk.LEFT, fill = tk.BOTH)


#COM Port Select Drop Down
variable = StringVar(root)
variable.set("No COM ports found.") # default value
w = OptionMenu(root, variable, *ports, "No COM ports found.")
w.pack(side = tk.LEFT, expand = True, fill = tk.BOTH)
updatePorts()

for child in mainframe.winfo_children():
    child.grid_configure(padx=20, pady=10)

while True:
    time.sleep(0.016)
    root.update()
