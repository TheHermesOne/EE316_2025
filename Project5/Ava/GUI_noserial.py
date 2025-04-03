#GUI with no serial connections - draft for reference
    # w,a,s,d keys for movement
    # colors: red (r), blue (b), green (g), black (k), yellow (y)
    # size of canvas: m = 256x256, n = 512x512
    # includes the ability to save the image
    # pen width is changed by pressing keys 1-7
    # no bugs. 

import tkinter as tk
from tkinter import filedialog
from PIL import ImageGrab


class CanvasTest:
    def __init__(self, root):
        self.root = root
        self.window = root
        self.left_frame = tk.Frame()
        self.left_frame.pack(side=tk.LEFT, padx=20, pady=20)

        self.w = 512
        self.h = 512
        self.pencolor = "black"
        self.penwidth = 1

        self.game_active = True

        self.canvas = tk.Canvas(self.left_frame, width=self.w, height=self.h, bg="white")
        self.canvas.pack()
        self.x = self.w / 2
        self.y = self.h / 2


        self.right_frame = tk.Frame()
        self.right_frame.pack(side=tk.RIGHT, padx=80, pady=80)

        self.canvasz_label = tk.Label(self.right_frame, text=f"sketching area: {self.w}x{self.h}",
                                      font=("fixedsys", 14), fg="black")
        self.canvasz_label.pack()
        # pen color being displayed
        self.pencolor_label = tk.Label(self.right_frame, text=f"pen color: {self.pencolor}", font=("fixedsys", 14),
                                       fg="black")
        self.pencolor_label.pack()
        # pen width
        self.penwidth_label = tk.Label(self.right_frame, text=f"pen width: {self.penwidth}", font=("fixedsys", 14),
                                       fg="black")
        self.penwidth_label.pack()
        # x position
        self.xpos_label = tk.Label(self.right_frame, text="x: ", font=("fixedsys", 14), fg="black")
        self.xpos_label.pack()
        # y position
        self.ypos_label = tk.Label(self.right_frame, text="y: ", font=("fixedsys", 14), fg="black")
        self.ypos_label.pack()
        # save button
        self.save_button = tk.Button(self.right_frame, text="Save Canvas as PNG", command=self.save_canvas)
        self.save_button.pack(pady=10)

        self.prev_x = self.x
        self.prev_y = self.y

        self.canvas.bind("<KeyPress>", self.draw)
        self.canvas.bind("<KeyRelease>", self.handle_keyrel)
        self.canvas.focus_set()

    def handle_keyrel(self, event):
        self.colors(event)
        self.pwidth(event)
        self.cwidth(event)

    def cwidth(self, event):
        if event.keysym in ("m", "n"):
            # get the drawing from canvas
            bbox = self.canvas.bbox("all")  # returns (x1, y1, x2, y2)
            if bbox:
                drawing_center_x = (bbox[0] + bbox[2]) / 2
                drawing_center_y = (bbox[1] + bbox[3]) / 2
            else:
                drawing_center_x = self.x
                drawing_center_y = self.y

            # changing the size of the canvas
            if event.keysym == "m":
                self.w = 256
                self.h = 256
            else:
                self.w = 512
                self.h = 512

            self.canvas.config(width=self.w, height=self.h)
            self.canvasz_label.config(text=f"sketching area: {self.w}x{self.h}")

            # find the center
            canvas_center_x = self.w / 2
            canvas_center_y = self.h / 2

            # shifting the canvas once resized
            dx = canvas_center_x - drawing_center_x
            dy = canvas_center_y - drawing_center_y

            self.canvas.move("all", dx, dy)

            self.x = canvas_center_x
            self.y = canvas_center_y
            self.xpos_label.config(text=f"x: {self.x}")
            self.ypos_label.config(text=f"y: {self.y}")
            self.canvas.create_line(self.x, self.y, self.x, self.y + 1, width=self.penwidth, fill=self.pencolor)

    ########### changing the color of the pen ############################################
    def colors(self, event):

        key_to_color = {"r": "red", "g": "green", "b": "blue", "k": "black", "y": "yellow"
                        }
        color = key_to_color.get(event.keysym)

        if color:
            self.pencolor = color
            self.pencolor_label.config(text=f"pen color: {self.pencolor}")

    ########## changing the width of the pen ##############################################
    def pwidth(self, event):
        key_to_pwidth = {"1": 1, "2": 2, "3": 3, "4": 4,
                         "5": 5, "6": 6, "7": 7
                         }
        penwidth = key_to_pwidth.get(event.keysym)
        if penwidth:
            self.penwidth = penwidth
            self.penwidth_label.config(text=f"pen width: {self.penwidth}")

    ########## testing user changing position of the pen to draw ##########################
    def draw(self, event):
        self.prev_x = self.x
        self.prev_y = self.y

        if event.keysym == "w":
            if self.y > 0:
                self.y -= 1
        elif event.keysym == "s":
            if self.y < self.h:
                self.y += 1
        elif event.keysym == "a":
            if self.x > 0:
                self.x -= 1
        elif event.keysym == "d":
            if self.x < self.w:
                self.x += 1

        # draw line
        self.canvas.create_line(self.prev_x, self.prev_y, self.x, self.y, width=self.penwidth, fill=self.pencolor)

        self.xpos_label.config(text=f"x: {self.x}")
        self.ypos_label.config(text=f"y: {self.y}")

    ########## saving the drawing as a png ##################################################
    def save_canvas(self):
        filename = filedialog.asksaveasfilename(
            defaultextension=".png",
            filetypes=[("PNG files", "*.png")],
            title="Save your drawing"
        )
        if not filename:
            return

        self.canvas.update_idletasks()
        self.root.lift()
        self.root.attributes("-topmost", True)
        self.root.after_idle(lambda: self.root.attributes("-topmost", True))

        # get the size of the canvas
        x = self.canvas.winfo_rootx()
        y = self.canvas.winfo_rooty()
        x1 = x + self.canvas.winfo_width()
        y1 = y + self.canvas.winfo_height()

        # save the drawing on canvas
        img = ImageGrab.grab(bbox=(x, y, x1, y1))

        img.save(filename)
        print(f"saved as {filename}.png")

############ calling the function ######################################################
if __name__ == "__main__":
    root = tk.Tk()
    app = CanvasTest(root)
    root.mainloop()

