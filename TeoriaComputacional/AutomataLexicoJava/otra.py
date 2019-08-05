from tkinter import *
import time

class diagrama(object):
     def __init__(self):
        self.root = Tk()
        self.root.title("Automata Lexico")
        self.canvas = Canvas(self.root, width=800, height = 600)
        self.canvas.pack()
        #Ver que onda coordenadas
        self.q0 = self.canvas.create_oval(60, 100, 100, 200, outline='black', fill='white')
        self.text=self.canvas.create_text(20,20,text="q0")
        self.alien1 = self.canvas.create_oval(60, 10, 100, 40, outline='black',fill='blue')
        self.canvas.pack()
        #self.root.after(0, self.animation)
        self.root.mainloop()

     def animation(self):
        track = 0
        while True:
            x = 5
            y = 0
            if track == 0:
               for i in range(0,51):
                    time.sleep(0.025)
                    self.canvas.move(self.alien1, x, y)
                    self.canvas.move(self.alien2, x, y)
                    self.canvas.update()
               track = 1
               print ("check")

            else:
               for i in range(0,51):
                    time.sleep(0.025)
                    self.canvas.move(self.alien1, -x, y)
                    self.canvas.move(self.alien2, -x, y)
                    self.canvas.update()
               track = 0
            print (track)

diagrama()