# gosu-typespeed
## Project for the speed sprint workshop [first presented at Toronto Ruby Hack Night, January 28, 2016]

This project, based on the gosu-examples project, has been selected to be a part of the speed-sprint workshop.
The speed-sprint project can be found here: https://github.com/k00ka/speed-sprint.

# User Stories
1. text flies left to right + changes colour

	The play should see the words fly left to right across the screen. The speed of the flight should easily changed and the colour should change as it moves across.
2. end of game conditions + overall stats

	The game should end when a number of words reach the right side of the screen before being typed. Fix the game over screen to display the overall stats (wpm, total words).
3. show the word as it is being typed + scoring (word length + speed)

	Display what the player types on the screen. Create a scoring system where players get scores for correct submissions where the score is higher for longer words and for speedier words.
4. words are longer and faster the longer you play (3-5, 3-6, 4-7, 4-8, 5-9, 5-10)

	The words displayed seem pretty random. Create a feeling of 'levels' where longer words appear more frequently and move more quickly as you progress.

[First Team]
## Summary

### Speed control

* We initialized `@speed` to 3 seconds (3000 ms) by default
* The user can control the speed by pressing up and down arrow buttons

### Flying words

* We added logic to change colour and position (Point.x)
* The draw method is not yet working

[Team 5]
Work Done:
-fixed the game from crashing
-words move across the screen
-words change color depending on X coordinate
-added total words completed

Remaining bugs:
- pressing enter without pressing any words counts as complete (easy debugging for other features!)
- WPM is still broken (shows at 0)