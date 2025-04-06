# Last Edited: 4/6/2025
# commands added

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


def send_state_to_serial(input_data):
    if ser:
        if isinstance(input_data, tk.Event):
            return
        else:
            state_hex = input_data.encode('utf-8').hex()
            print(f"sending: {state_hex} -> UART")
        threading.Thread(target=lambda: ser.write(bytes.fromhex(state_hex)), daemon=True).start()


class CanvasTest:
    def __init__(self, root):
        self.root = root
        self.window = root

        self.left_frame = tk.Frame()
        self.left_frame.pack(side=tk.LEFT, padx=20, pady=20)

        self.right_frame = tk.Frame()
        self.right_frame.pack(side=tk.RIGHT, padx=80, pady=80)

        self.save_button = tk.Button(self.right_frame, text="Save Canvas as PNG", command=self.save_canvas)
        self.save_button.pack(pady=10)

        self.w = 512
        self.h = 512
        self.x = self.w / 2
        self.y = self.h / 2

        self.canvas = tk.Canvas(self.left_frame, width=self.w, height=self.h, bg="white")
        self.canvas.pack()

        self.canvasz_label = tk.Label(self.right_frame, text=f"sketching area: {self.w}x{self.h}", font=("fixedsys", 14), fg="black")
        self.canvasz_label.pack()

        self.pencolor = "black"
        self.pencolor_label = tk.Label(self.right_frame, text=f"pen color: {self.pencolor}", font=("fixedsys", 14), fg="black")
        self.pencolor_label.pack()

        self.penwidth = 1
        self.penwidth_label = tk.Label(self.right_frame, text=f"pen width: {self.penwidth}", font=("fixedsys", 14), fg="black")
        self.penwidth_label.pack()

        self.xpos_label = tk.Label(self.right_frame, text="x: ", font=("fixedsys", 14), fg="black")
        self.xpos_label.pack()

        self.ypos_label = tk.Label(self.right_frame, text="y: ", font=("fixedsys", 14), fg="black")
        self.ypos_label.pack()

        # Entry for user commands
        self.command_entry = tk.Entry(self.right_frame, font=("fixedsys", 14), width=30)
        self.command_entry.pack(pady=10)
        self.command_entry.bind("<Return>", self.handle_command)
        self.command_entry.focus_set()
        # Bind real-time movement keys
        self.root.bind("<KeyPress-w>", lambda e: self.draw('w'))
        self.root.bind("<KeyPress-a>", lambda e: self.draw('a'))
        self.root.bind("<KeyPress-s>", lambda e: self.draw('s'))
        self.root.bind("<KeyPress-d>", lambda e: self.draw('d'))

        self.prev_x = self.x
        self.prev_y = self.y

        self.game_active = True
        self.serial_thread = threading.Thread(target=self.read_serial_input, daemon=True)
        self.serial_thread.start()

    def handle_command(self, event):
        command = self.command_entry.get().strip()
        self.command_entry.delete(0, tk.END)
        self.command_entry.focus_set()
        if not command:
            return  # Ignore empty input
        # Send to serial (optional)
        send_state_to_serial(command)

        if command in ['w', 'a', 's', 'd']:
            self.draw(command)
        if command.startswith("c") and len(command) == 7:
            try:
                red = command[1:3]
                green = command[3:5]
                blue = command[5:7]
                hex_color = f"#{red}{green}{blue}"

                self.pencolor = hex_color
                self.pencolor_label.config(text=f"pen color: {self.pencolor}")
                print(f"color {hex_color}")
                return
            except Exception as e:
                print(f"Invalid custom color: {e}")
                return
        # pwidth
        if command.startswith("l") and len(command) == 2:
            level = command[1]
            if level in ['1', '2', '3', '4', '5', '6', '7']:
                self.pwidth(level)
            else:
                return
        # Canvas size
        if command in ['z1', 'z2']:
            self.cwidth(command)
            return

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
            send_state_to_serial(keysym)
        else:
            # serial kb
            keysym = input_data

        if keysym in ("z1", "z2"):
            bbox = self.canvas.bbox("all")  # (x1, y1, x2, y2)
            if bbox:
                drawing_center_x = (bbox[0] + bbox[2]) / 2
                drawing_center_y = (bbox[1] + bbox[3]) / 2
            else:
                drawing_center_x = self.x
                drawing_center_y = self.y

            # setting the size of the canvas
            if keysym == "z1":
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

    def draw(self, input_data):
        keysym = input_data

        self.prev_x = self.x
        self.prev_y = self.y

        if keysym == "w":
            if self.y > 0:
                self.y -= 1
        elif keysym == "s":
            if self.y < self.h:
                self.y += 1
        elif keysym == "a":
            if self.x > 0:
                self.x -= 1
        elif keysym == "d":
            if self.x < self.w:
                self.x += 1

        self.canvas.create_line(self.prev_x, self.prev_y, self.x, self.y, width=self.penwidth, fill=self.pencolor)
        self.xpos_label.config(text=f"x: {self.x}")
        self.ypos_label.config(text=f"y: {self.y}")

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

        x = self.canvas.winfo_rootx()
        y = self.canvas.winfo_rooty()
        x1 = x + self.canvas.winfo_width()
        y1 = y + self.canvas.winfo_height()

        img = ImageGrab.grab(bbox=(x, y, x1, y1))
        img.save(filename)
        print(f"saved as {filename}.png")

    def read_serial_input(self):
        buffer = ""
        while True:
            if ser and ser.in_waiting > 0:
                try:
                    data = ser.read(1)
                    ascii_char = data.decode('ascii', errors='replace')

                    if ascii_char in ['\r', '\n']:  # enter key
                        command = buffer.strip()
                        buffer = ""

                        if command:
                            print(f"ps2 kb: {command}")
                            self.root.after(0, self.handle_command_serial, command)
                        else:
                            buffer += ascii_char
                except Exception as e:
                    print(f"error: {e}")


if __name__ == "__main__":
    root = tk.Tk()
    app = CanvasTest(root)
    root.mainloop()

    if ser:
        ser.close()
        print("Serial port closed.")
