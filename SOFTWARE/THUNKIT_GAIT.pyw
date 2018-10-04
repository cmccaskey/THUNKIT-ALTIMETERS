#pyinstaller --onefile --icon=lightning.png THUNKIT_GAIT.pyw
#serial group issues on linux

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

icon = """ 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"""


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
    global ser
    selectedPort = dropVariable.get()
    print(selectedPort)
    portCrop = str(selectedPort).find(" ")
    comPort = str(selectedPort)[0: portCrop]
    comPort = comPort.replace("('", '') #Windows
    comPort = comPort.replace("'", '') #Windows
    print(comPort)
    try:
        ser = serial.Serial(comPort, 9600)
    except:
        ser = "null"
        print("Error opening selected COM port.")
        messagebox.showerror("Error", "Error opening selected COM port.")
        return
    if (ser == "null" or ser == "Select COM Port"):
        print("Please select COM port first.")
        messagebox.showerror("Error", "Please select COM port first.")
        return
    print("Downloading data...")
    global x_axis
    global y_axis
    y_axis = [-2] #used later in the loop
    x_axis = [0]
    altitudeGraph.clear()
   # a.set_xticklabels([0, 1], rotation = 45)
    try:
        ser.write('d'.encode('utf-8'))
    except:
        print("Error writing to COM port")
        messagebox.showerror("Error", "Error writing to COM port")
    ser.flushInput()
    time.sleep(0.5);
    altitudeOffset = 0;
    while serialAvailable():
        try:
            line = str(ser.readline())
        except:
            print("Error reading from COM port")
            messagebox.showerror("Error", "Error reading from COM port")
        ##print(line)
        line = re.sub("\D", "", line)
        ##if (line == ""):
            ##break
        ##line = int(line)
        ##print(line)
        #if ("\\" in line or line == ''):
            #return
        #if (not int(line)):
           # return
        if (y_axis[0] == -2):
            y_axis[0] = 0
            altitudeOffset = int(line);
        else:
            y_axis.append(int(line) - altitudeOffset)
            x_axis.append(round(x_axis[-1] + 0.2, 1))
        time.sleep(0.010)
    #a.set_xticklabels(x_axis, rotation = 90)
    altitudeGraph.plot(x_axis, y_axis, '#ff0000')
    #a.plot([0, x_axis[-1]], [max(y_axis), max(y_axis)], '#0000ff')
    #get_xticklabels()[-1].set_color('#0000ff')
    altitudeGraph.set_title("Recorded Altitude")
    altitudeGraph.set_xlabel("Time (s)")
    altitudeGraph.set_ylabel("Altitude (m)")
    tempTicks = list(altitudeGraph.get_yticks())
    tempTicks[-1] = max(y_axis)
    tempTicks[0] = min(y_axis)
    scaleVar = (tempTicks[-1] - tempTicks[0]) / 20 # this prevents overlap adjust as needed
    print(scaleVar)
    if abs(tempTicks[-1] - tempTicks[-2]) < scaleVar:
        tempTicks.pop(-2) #pop if values are too close and overlap
    if abs(tempTicks[0] - tempTicks[1]) < scaleVar:
        tempTicks.pop(1)
    altitudeGraph.set_yticks(tempTicks) #add apogee and min tick
    altitudeGraph.set_yticklabels(tempTicks) #add apogee and min label
    #print(x_axis)
    #print(y_axis)
    canvas.draw()
    print("Done downloading.")
    updatePorts() #Windows bug can't download data twice without re-selecting

def updatePorts():
    ports = list(serial.tools.list_ports.comports())
    if (not ports):
        dropVariable.set("No COM ports found.")
    else:
        dropVariable.set("Select COM port.")
    dropdownPort['menu'].delete(0, 'end')
    for i in ports:
        dropdownPort['menu'].add_command(label = i, command = tk._setit(dropVariable, i))

#Create Graph
#LARGE_FONT= ("Verdana", 12)
root = Tk()
root.title("THUNKIT GAIT")
root.config(bg="#f2f2f2")

img = tk.PhotoImage(data=icon)
root.tk.call('wm', 'iconphoto', root._w, img)
root.resizable(0, 0)

topframe = Frame(bg = "#f2f2f2")
bottomframe = Frame(bg = "#f2f2f2", borderwidth = 2, relief = GROOVE)

f = Figure(figsize=(5,5), dpi=100)
altitudeGraph = f.add_subplot(111)
altitudeGraph.set_title("Recorded Altitude")
altitudeGraph.set_xlabel("Time (s)")
altitudeGraph.set_ylabel("Altitude (m)")
altitudeGraph.figure.set_facecolor("#ffffff")
canvas = FigureCanvasTkAgg(f, bottomframe)
canvas.show()
y_axis = [-2] #used later in the loop
x_axis = [0]

#Download Data Button
buttonDownload = Button(topframe, text="Download", command=downloadData, borderwidth = 2, relief = GROOVE)
buttonDownload.config(bg="#ff8080")
buttonRefresh = Button(topframe, text="Refresh", command=updatePorts, borderwidth = 2, relief = GROOVE)
buttonRefresh.config(bg = "#e6e6e6")
buttonSave = Button(topframe, text="Save", command=saveData, borderwidth = 2, relief = GROOVE)
buttonSave.config(bg = "#e6e6e6")





#COM Port Select Drop Down
dropVariable = StringVar(root)
dropVariable.set("No COM ports found.") # default value
dropdownPort = OptionMenu(topframe, dropVariable, *ports, "No COM ports found.")
dropdownPort.config(width = 30, borderwidth = 2, relief = GROOVE, bg = "#e6e6e6")


#pack it up
topframe.pack(expand = True, fill = tk.BOTH)
bottomframe.pack(padx = 10, pady = (5,10))

buttonDownload.pack(side = tk.LEFT, fill = tk.BOTH, padx = (10,0), pady = (5,0))
buttonSave.pack(side = tk.LEFT, fill = tk.BOTH, padx = (5,0), pady = (5,0))
buttonRefresh.pack(side = tk.RIGHT, fill = tk.BOTH, padx = (0,10), pady = (5,0))
dropdownPort.pack(side = tk.RIGHT, fill = tk.BOTH, padx = (0,5), pady = (5,0))

canvas.get_tk_widget().pack(side=tk.BOTTOM, expand=False)
canvas._tkcanvas.pack(side=tk.BOTTOM, expand=False, ipadx = 100, ipady = 30)




#or child in mainframe.winfo_children():
    #child.grid_configure(padx=20, pady=10)

while True:
    time.sleep(0.050)#pst 60fps... NOT!
    #if ser == "null": #maybe :>
        #updatePorts()#need to prevent if already selected...
    root.update()
