# Maze war for the NES 
<p text-align="center">This is a program that begin in 2023 but I have update it to feature the entire maze from the original Maze war game from 1974.</p>
<p text-align="center">The program has a bitmap of the maze 0 for empty square and 1 for wall square, I then check for the distance between the first front wall </p>
<p text-align="center">and it's path branching. I then send to ram location $0400 to $07FF the corect way the BG should be, and finally send all those byte to $2000 on the PPU</p>
<p text-align="center">so you can now go inside the maze and have fun going every where. </p>

# TO RUN - you must have a emulator that can open .nes file
# the executable is inside the out folder