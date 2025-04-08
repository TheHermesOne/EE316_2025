# Last Edited: 4/6/2025

# what was/ has been done:
    # serial input was received successfully
    #     pc and serial kb's can now send commands
    #        example : cFF00FF w4 s2  (enter)  -- color: magenta, pen width 3, canvas size 512x512
    # the commands are shown on the GUI: string updating when the user changes 
    #                                    either the entire command or just a partition
    # other keys for functionality:
    #     direction is now changed by t,f,g,h
    #     you can save the canvas image by pressing 'o' or clicking button on gui
    #     you can reset the canvas image by pressing 'k' or the button on the gui
    # minor appearance changes to try to resemble an etch a sketch :)

# next: find a way to integrate rotary encoders!

#################################################################################################################

import threading
import tkinter as tk
from tkinter import filedialog
import serial
from PIL import ImageGrab

try:
    ser = serial.Serial('COM8', 9600, timeout=1)
    print(f"Hardware Ready - Connected to:  {ser.name}")
except serial.SerialException as e:
    print(f"Error: Could not open serial port: {e}")
    ser = None


class CanvasTest:
    def __init__(self, root):
        self.root = root
        self.window = root

        # formatting for elements
        self.left_frame = tk.Frame(self.window, bg="#b53337")
        self.left_frame.pack(side=tk.LEFT, padx=60, pady=60)

        self.right_frame = tk.Frame()
        self.right_frame.pack(side=tk.RIGHT, padx=80, pady=80)

        self.w = 256
        self.h = 256
        self.x = self.w / 2
        self.y = self.h / 2

        self.canvasz_label = tk.Label(self.left_frame, text=f"Etch a Sketch",font=("Brush Script MT", 25), fg = "#d4ba7b", bg="#b53337")
        self.canvasz_label.pack()

        self.sketch_area_label = tk.Label(self.left_frame, text=f"sketching area: {self.w}x{self.h}", font=("fixedsys", 14), fg = "white", bg="#b53337")
        self.sketch_area_label.pack()

        self.canvas = tk.Canvas(self.left_frame, width=self.w, height=self.h, bg="white")
        self.canvas.pack()

        self.coord_frame = tk.Frame(self.left_frame)
        self.coord_frame.pack()

        # X and Y coords
        self.xpos_label = tk.Label(self.coord_frame, text=f"x: {self.x}", font=("fixedsys", 14),  fg = "white", bg="#b53337")
        self.xpos_label.pack(side=tk.LEFT)

        self.ypos_label = tk.Label(self.coord_frame, text=f"y: {self.y}", font=("fixedsys", 14),  fg = "white", bg="#b53337")
        self.ypos_label.pack(side=tk.LEFT)

        # hardware ready is displayed for 5 seconds if the com port connects successfully
        if ser:
            self.hw_ready_label = tk.Label(self.right_frame, text="hardware ready", font=("fixedsys", 20),
                                                  fg="green")
            self.hw_ready_label.pack()
            self.root.after(5000, self.hw_ready_label.destroy)

        self.pencolor = "black"
        self.pencolor_label = tk.Label(self.right_frame, text=f"pen color: {self.pencolor}", font=("fixedsys", 14),
                                       fg="black")
        self.pencolor_label.pack()

        self.penwidth = 1
        self.penwidth_label = tk.Label(self.right_frame, text=f"pen width: {self.penwidth}", font=("fixedsys", 14),
                                       fg="black")
        self.penwidth_label.pack()

        # commands
        self.command_entry = tk.Entry(self.right_frame, font=("fixedsys", 14), width=30)
        self.command_entry.pack(pady=10)
        self.command_entry.bind("<Return>", self.handle_command)
        self.command_entry.bind("<KeyRelease>", self.send_char_to_serial)
        self.command_entry.focus_set()

        self.command_display = tk.Label(self.right_frame, text="Commands:  ", font=("fixedsys", 14), fg="black")
        self.command_display.pack(pady=10)

        # buttons for save and erase
        self.save_button = tk.Button(self.right_frame, text="click me or press 'o' to save canvas", command=self.save_canvas, font=("fixedsys", 12),fg="white", bg="#1977bf")
        self.save_button.pack(pady=10)

        self.reset_button = tk.Button(self.right_frame, text="click me or press 'k' to reset canvas", command=self.reset_canvas, font=("fixedsys", 12),
                                       fg="white", bg="#a12024")
        self.save_button.pack(pady=10)
        self.reset_button.pack(pady=10)

        # movement keys in addition to the rotary encoders
        self.root.bind("<KeyPress-y>", lambda e: self.draw('y') or "break")
        self.root.bind("<KeyPress-h>", lambda e: self.draw('h') or "break")
        self.root.bind("<KeyPress-g>", lambda e: self.draw('g') or "break")
        self.root.bind("<KeyPress-j>", lambda e: self.draw('j') or "break")
        # save image key
        self.root.bind("<KeyPress-o>", lambda e: self.save_canvas('o') or "break")
        # erase canvas
        self.root.bind("<KeyPress-k>", self.reset_canvas)


        self.prev_x = self.x
        self.prev_y = self.y

        self.game_active = True
        self.serial_thread = threading.Thread(target=self.read_serial_input, daemon=True)
        self.serial_thread.start()

        # dict. to store recent commands
        self.recent_commands = {"c": None, "w": None, "s": None}
    def send_char_to_serial(self, event):
            if ser:
                typed_char = event.char

                if typed_char.isascii() and typed_char != '':
                    print(f"char to uart: {typed_char} ")
                    threading.Thread(target=lambda: ser.write(typed_char.encode('ascii')), daemon=True).start()

    def handle_command(self, command_entry, command_ser=None):
        if command_entry is not None:  # from  ps2_kb
            command = self.command_entry.get().strip()
        elif command_ser is not None:  # from serial
            command = command_ser.strip()
        else:
            return

        self.command_entry.delete(0, tk.END)  # clear
        self.command_entry.focus_set()

        if not command:
            return

        commands = command.split()

        for cmd in commands:
            # pen color commands
            if cmd.startswith("c") and len(cmd) == 7:
                try:
                    red = cmd[1:3]
                    green = cmd[3:5]
                    blue = cmd[5:7]
                    hex_color = f"#{red}{green}{blue}"
                    self.pencolor = hex_color
                    self.pencolor_label.config(text=f"pen color: {self.pencolor}")
                    self.recent_commands["c"] = cmd
                except Exception as e:
                    print(f"Invalid color input: {e}")
                    continue

            # pen width commands
            elif cmd.startswith("w") and len(cmd) == 2:
                level = cmd[1]
                if level in ['1', '2', '3', '4', '5', '6', '7']:
                    self.pwidth(level)
                    self.recent_commands["w"] = cmd
                else:
                    print("Invalid pen width level.")
                    continue

            # canvas size commands
            elif cmd.startswith("s") and len(cmd) == 2:
                if cmd == "s1":
                    self.cwidth("s1")  # 256x256
                    self.recent_commands["s"] = cmd
                elif cmd == "s2":
                    self.cwidth("s2")  # 512x512
                    self.recent_commands["s"] = cmd
                else:
                    print("Invalid canvas size command.")
                    continue

            else:
                print(f"No associated command: {cmd}")
                continue

        self.update_command_display()
        #self.send_state_to_serial(command)

    def update_command_display(self):
        command_text = f"Command: {self.recent_commands['c']} {self.recent_commands['w']} {self.recent_commands['s']}"
        self.command_display.config(text=command_text)

    def colors(self, input_data):
        keysym = input_data
        key_to_color = {"r": "red", "g": "green", "b": "blue", "k": "black", "y": "yellow"}
        color = key_to_color.get(keysym)

        if color:
            self.pencolor = color
            self.pencolor_label.config(text=f"pen color: {self.pencolor}")

    def pwidth(self, input_data):
        keysym = input_data
        key_to_penwidth = {"1": 1, "2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7}
        width = key_to_penwidth.get(keysym)
        if width:
            self.penwidth = width
            self.penwidth_label.config(text=f"pen width: {self.penwidth}")

    def cwidth(self, input_data):
        if isinstance(input_data, tk.Event):
            # reg kb
            keysym = input_data.keysym
            #send_state_to_serial(keysym)
        else:
            # serial kb
            keysym = input_data

        if keysym in ("s1", "s2"):
            bbox = self.canvas.bbox("all")
            if bbox:
                drawing_center_x = (bbox[0] + bbox[2]) / 2
                drawing_center_y = (bbox[1] + bbox[3]) / 2
            else:
                drawing_center_x = self.x
                drawing_center_y = self.y

            # setting the size of the canvas
            if keysym == "s2":
                self.w = 512
                self.h = 512
            else:
                self.w = 256
                self.h = 256

            self.canvas.config(width=self.w, height=self.h)
            self.sketch_area_label.config(text=f"sketching area: {self.w}x{self.h}")

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

    def draw(self, input_data):
        keysym = input_data

        self.prev_x = self.x
        self.prev_y = self.y

        if keysym == "y":
            if self.y > 0:
                self.y -= 1
        elif keysym == "h":
            if self.y < self.h:
                self.y += 1
        elif keysym == "g":
            if self.x > 0:
                self.x -= 1
        elif keysym == "j":
            if self.x < self.w:
                self.x += 1

        self.canvas.create_line(self.prev_x, self.prev_y, self.x, self.y, width=self.penwidth, fill=self.pencolor)
        self.xpos_label.config(text=f"x: {self.x}")
        self.ypos_label.config(text=f"y: {self.y}")

    def save_canvas(self, event = None):

        filename = filedialog.asksaveasfilename(
            defaultextension=".png",
            filetypes=[("PNG files", "*.png")],
            title="Save your drawing"
        )

        # set default name if nothing is typed
        if not filename:
            filename = "drawing.png"

        self.canvas.update_idletasks()
        self.root.lift()
        self.root.attributes("-topmost", True)
        self.root.after_idle(lambda: self.root.attributes("-topmost", True))

        # canvas coords
        x = self.canvas.winfo_rootx()
        y = self.canvas.winfo_rooty()
        x1 = x + self.canvas.winfo_width()
        y1 = y + self.canvas.winfo_height()

        img = ImageGrab.grab(bbox=(x, y, x1, y1))

        img.save(filename)
        print(f"Saved as {filename}")

    def reset_canvas(self, event = None):
        # reset
        self.canvas.delete("all")
        self.x = self.w / 2
        self.y = self.h / 2
        self.xpos_label.config(text=f"x: {self.x}")
        self.ypos_label.config(text=f"y: {self.y}")
        self.canvas.create_line(self.x, self.y, self.x, self.y + 1, width=self.penwidth, fill=self.pencolor)

    def read_serial_input(self):
        buffer = ""  # buffer for command string

        while True:
            if ser :
                try:
                    data = ser.read(1)  # Read one byte
                    ascii_char = data.decode('ascii', errors='replace')

                    if ascii_char in ['y', 'h', 'g', 'j']:
                        self.root.after(0, self.draw, ascii_char)
                    if ascii_char in ['o']:
                        self.root.after(0, self.save_canvas, ascii_char)
                    if ascii_char in ['k']:
                        self.root.after(0, self.reset_canvas, ascii_char)
                    elif ascii_char == '\r' or ascii_char == '\n':
                        command_ser = buffer.strip()
                        buffer = ""

                        if command_ser:  # if not empty
                            print(f"Command from serial: {command_ser}")
                            self.root.after(0, self.handle_command, None, command_ser)

                    else:
                        buffer += ascii_char  # add  to buffer before entering
                        print(f"ps2 kb typing...: {ascii_char}")

                except Exception as e:
                    print(f"Error while reading serial input: {e}")


if __name__ == "__main__":
    root = tk.Tk()
    app = CanvasTest(root)
    root.mainloop()

    if ser:
        ser.close()
        print("Serial port closed.")
