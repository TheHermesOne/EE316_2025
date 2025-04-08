import threading
import tkinter as tk
import random
import serial

# init serial communication
try:
    ser = serial.Serial('COM5', 9600, timeout=1)
    print(f"Connected to: {ser.name}")
except serial.SerialException as e:
    print(f"Error: Could not open serial port: {e}")
    ser = None



def send_word_to_serial(word):
    if ser:
        formatted_word = word.ljust(16)[:16]  # Pad with underscores or truncate
        word_hex = formatted_word.encode('utf-8').hex()
        print(f"Sending word to serial: {formatted_word}")
        threading.Thread(target=lambda: ser.write(bytes.fromhex(word_hex)), daemon=True).start()


def send_state_to_serial(state):
    if ser:
        formatted_state = state.ljust(16)[:16]  # Pad with underscores or truncate
        state_hex = formatted_state.encode('utf-8').hex()
        print(f"Sending state to serial: {formatted_state}")
        threading.Thread(target=lambda: ser.write(bytes.fromhex(state_hex)), daemon=True).start()
try:
    with open("words.txt", "r") as file:
        words = [word.strip().upper() for word in file.readlines()]
except FileNotFoundError:
    print("Error: words.txt not found!")

class HangmanGUI:
    def __init__(self, root):
        self.root = root
        self.root.title("Hangman Game")

        # puzzles solved logic
        self.games_played = 0
        self.puzzles_solved = 0
        self.total_puzzles = 3
        self.game_active = False

        # layout
        self.left_frame = tk.Frame(root)
        self.left_frame.pack(side=tk.LEFT, padx=20, pady=20)

        self.right_frame = tk.Frame(root)
        self.right_frame.pack(side=tk.RIGHT, padx=20, pady=20)

        # hangman image canvas
        self.canvas = tk.Canvas(self.left_frame, width=300, height=300, bg="aliceblue")
        self.canvas.pack()

        # word being guessed
        self.word_label = tk.Label(self.left_frame, text="Hangman", font=("fixedsys", 16), fg="midnightblue")
        self.word_label.pack()

        # guesses left
        self.attempts_label = tk.Label(self.left_frame, text="", font=("fixedsys", 14))
        self.attempts_label.pack()

        # messages display
        self.message_label = tk.Label(self.left_frame, text="Press 'Start Game' to Play Hangman", font=("fixedsys", 12), fg="brown")
        self.message_label.pack()

        # start button
        self.start_button = tk.Button(self.left_frame, text="Start Game", fg="white", font=("fixedsys", 12), bg="darkgreen", command=self.start_game)
        self.start_button.pack()

        # guessed letters
        self.guessed_letters_label = tk.Label(self.right_frame, text="Guessed Letters:", font=("fixedsys", 14), fg="midnightblue")
        self.guessed_letters_label.pack()

        self.guessed_letters_display = tk.Label(self.right_frame, text="", font=("fixedsys", 14), fg="brown")
        self.guessed_letters_display.pack()

        # puzzles solved
        self.puzzle_counter_label = tk.Label(self.right_frame, text="0 out of 3 puzzles solved", font=("fixedsys", 14), fg="midnightblue")
        self.puzzle_counter_label.pack()

        # restart button
        self.restart_button = tk.Button(self.right_frame, text="Restart Game", font=("fixedsys", 12), fg="white", bg="firebrick", command=self.full_reset)
        self.restart_button.pack()
        self.restart_button.pack_forget()

        # initializing variables
        self.word = ""
        self.guessed_word = []
        self.remaining_attempts = 6
        self.used_letters = set()

        self.serial_thread = threading.Thread(target=self.read_serial_input, daemon=True)
        self.serial_thread.start()

        # Bind to handle key press events if needed
        self.root.bind("<KeyPress>", self.process_key)

        send_state_to_serial("new game y/n?   ")

    def full_reset(self):
        """ Resets the entire game to its initial state. """
        self.games_played = 0
        self.puzzles_solved = 0
        self.game_active = False

        # Reset UI labels
        self.puzzle_counter_label.config(text="0 out of 3 puzzles solved")
        self.message_label.config(text="Press 'Start Game' to Play Hangman")
        self.word_label.config(text="Hangman")
        self.attempts_label.config(text="")
        self.guessed_letters_display.config(text="")

        # Hide restart button and reset start button
        self.restart_button.pack_forget()
        self.start_button.config(text="Start Game")

        # Clear guessed words and used letters
        self.guessed_word = []
        self.used_letters = set()

        # Reload word list from file
        global words
        try:
            with open("words.txt", "r") as file:
                words = [word.strip().upper() for word in file.readlines()]
        except FileNotFoundError:
            print("Error: words.txt not found!")

        # Reset hangman canvas
        self.canvas.delete("all")

        # Allow the user to start a new game
        self.start_game()

    def start_game(self):
        if not words or self.games_played == self.total_puzzles:
            self.message_label.config(text="Well Done! You've solved all puzzles! Click 'Restart Game' to play again.")
            self.restart_button.pack()
            return

        self.word = random.choice(words)
        self.guessed_word = ["_"] * len(self.word)
        self.remaining_attempts = 6
        self.used_letters = set()
        self.games_played += 1
        self.word_label.config(text="word: " + " ".join(self.guessed_word))
        self.attempts_label.config(text=f"Remaining Attempts: {self.remaining_attempts}")
        self.message_label.config(text="Guess a Letter")
        self.guessed_letters_display.config(text="")

        send_word_to_serial("".join(self.guessed_word))

        self.game_active = True
        self.start_button.config(text="New Word")
        self.update_puzzle_counter()
        self.update_hangman_image()

    def process_key(self, event):
        #if not self.game_active:
            #return
        letter = event.char.upper()
        #if letter.isalpha() and letter not in self.used_letters:
            #self.process_guess(letter)
#####################################################################
        if self.game_active:
                # allow 'y' and 'n' to be guessed during game
            if letter.isalpha() and letter not in self.used_letters:
                self.process_guess(letter)
        else:
            if letter == "Y":
                    self.root.after(0, self.handle_y_input)
            elif letter == "N":
                    self.root.after(0, self.handle_n_input)

    def process_guess(self, letter):
        if not self.game_active:
            return

        letter = letter.upper()

        if letter.isalpha() and letter not in self.used_letters:
            self.used_letters.add(letter)
            self.guessed_letters_display.config(text=", ".join(sorted(self.used_letters)))

            if letter in self.word:
                for i, char in enumerate(self.word):
                    if char == letter:
                        self.guessed_word[i] = letter
                self.word_label.config(text="word: " + " ".join(self.guessed_word))
                send_word_to_serial("".join(self.guessed_word))

            else:
                self.remaining_attempts -= 1
                self.attempts_label.config(text=f"Incorrect Guesses Left: {self.remaining_attempts}")

            self.update_hangman_image()

            if "_" not in self.guessed_word:
                self.message_label.config(text="Well done! You solved it!")
                self.puzzles_solved += 1
                words.remove(self.word)
                self.update_puzzle_counter()
                self.end_game()

            elif self.remaining_attempts == 0:
                self.message_label.config(text=f"Sorry! The correct word was {self.word}")
                send_state_to_serial("you lose :(     ")

                self.end_game()


    def end_game(self):
        self.game_active = False

        if self.games_played == self.total_puzzles:
            self.restart_button.pack()
            send_state_to_serial("game over       ")

    def update_puzzle_counter(self):
        self.puzzle_counter_label.config(text=f"{self.puzzles_solved} puzzles solved out of {self.total_puzzles} total")

    def update_hangman_image(self):
        self.canvas.delete("all")

        self.canvas.create_line(50, 280, 250, 280, width=5)  # bottom of post
        self.canvas.create_line(100, 280, 100, 50, width=5)  # vertical post
        self.canvas.create_line(100, 50, 180, 50, width=5)  # top part of post
        self.canvas.create_line(180, 50, 180, 80, width=2)  # rope above head

        # noose
        if self.remaining_attempts == 6:
            self.canvas.create_oval(155, 85, 205, 155, start=200, extent=140, outline="black", width=2)

        # frowny face
        if self.remaining_attempts > 0:
            self.canvas.create_oval(150, 80, 210, 140, width=3)  # Head
            self.canvas.create_oval(165, 95, 175, 105, fill="black")  # Left Eye
            self.canvas.create_oval(185, 95, 195, 105, fill="black")  # Right Eye
            self.canvas.create_arc(165, 110, 195, 130, start=0, extent=180, style=tk.ARC)  # Frown
            self.canvas.create_arc(155, 85, 205, 155, start=200, extent=140, outline="black", width=2, style=tk.ARC)

        # body line
        if self.remaining_attempts < 5:
            self.canvas.create_line(180, 140, 180, 220, width=3)

        # left arm
        if self.remaining_attempts < 4:
            self.canvas.create_line(180, 160, 150, 190, width=3)
        # right arm
        if self.remaining_attempts < 3:
            self.canvas.create_line(180, 160, 210, 190, width=3)

        # left leg
        if self.remaining_attempts < 2:
            self.canvas.create_line(180, 220, 150, 270, width=3)
        # right leg
        if self.remaining_attempts < 1:
            self.canvas.create_line(180, 220, 210, 270, width=3)
            #  head
            self.canvas.create_oval(150, 80, 210, 140, width=3)  # head
            self.canvas.create_arc(165, 110, 195, 130, start=0, extent=180, style=tk.ARC)  # frown
            #  eyes with x's
            self.canvas.create_line(165, 100, 175, 110, width=2, fill="red")
            self.canvas.create_line(175, 100, 165, 110, width=2, fill="red")
            self.canvas.create_line(185, 100, 195, 110, width=2, fill="red")
            self.canvas.create_line(195, 100, 185, 110, width=2, fill="red")

#############################################################################
    def read_serial_input(self):
        while True:
            if ser and ser.in_waiting > 0:
                data = ser.read(1)  # Read one byte
                ascii_char = data.decode('ascii', errors='replace').strip()

                if self.game_active:
                    if ascii_char.isalpha():
                        print(f"Serial Input (guess): {ascii_char}")
                        self.root.after(0, self.process_guess, ascii_char)
                    else:
                        if ascii_char == "Y":
                            self.root.after(0, self.handle_y_input)
                        elif ascii_char =="N":
                            self.root.after(0, self.handle_n_input)

    def handle_y_input(self): # serial
        if not self.game_active:
            self.start_game()


    def handle_n_input(self): # serial
        if not self.game_active:
            self.full_reset()

if __name__ == "__main__":
    root = tk.Tk()
    app = HangmanGUI(root)
    root.mainloop()

    if ser:
        ser.close()
        print("Serial port closed.")
