# Lab1_Hossein_Khanzadeh

This project is a small SwiftUI game that helps practice recognizing prime numbers under time pressure. It was built as a lab assignment and is designed to be easy to understand, extend, and test.

## What the app does
- **Shows a random number** in the center of the screen.
- **Gives you 5 seconds** to decide if the number is prime or not.
- **Lets you answer** by tapping either the `Prime` or `Not Prime` button.
- **Treats unanswered rounds as wrong** if the 5-second timer runs out.
- **Tracks your performance** with running counts of correct and wrong answers.
- **Provides clear feedback** after each round using text and icons.
- **Shows a summary dialog every 10 attempts** so you can see how you are doing over time.

## How to use it
1. **Start the app** – a number and a countdown timer will appear automatically.
2. **Look at the number** and decide whether you believe it is prime.
3. **Tap `Prime` or `Not Prime`** before the timer reaches zero.
4. **Watch the feedback** just below the buttons:
   - A green checkmark and “Correct!” means your answer was right.
   - A red X and “Wrong!” or “Time’s up!” means the round counted as incorrect.
5. **Keep playing rounds** – a new number and a fresh 5-second timer are generated after each answer or timeout.
6. **Every 10 attempts**, read the summary alert to see your total correct and wrong answers so far, then tap `OK` to continue to the next set of rounds.
