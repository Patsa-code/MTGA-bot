# A Simple MTGA Farming Bot
### *!Warning!* 
*Using this bot is a clear violation of MTGA TOS. Use at your own risk and be smart about it*
#
#

### Installation

No installation needed. Simply download the files and extract them anywhere, but keep them together.
To run, just double click the “Sparkless.exe” file. This and “Turner.exe” are the two scripts that run when the bot is working.
There is a good chance your antivirus will flag any of the two as malicious. If this happens just create an exception and run them again.

### Why Autohotkey?

Mainly because i had absolutely 0 experience with code before starting (technically i still do) and AHK had the easiest image search function i could find. Maybe if i learn python in the future i’ll make it again but better.

### How Does it Work

After you run Sparkless.exe you’see the UI. Take a minute to read the instructions and test out the image search for your pc, in the ‘image troubleshoot’ section (it also includes instructions inside)
Once you’re familiar with how it works and you’ve run a few image tests to make sure it recognizes some basic scenes, you can press the ‘Run’ button either on the home screen where the play button is visible, or at any point between there and inside a game. 
Make sure to select a Bo1 unranked constructed format, otherwise the bot will not work properly, if not at all.

The bot looks for certain images to figure out what to do next. The usual flowchart of actions is as follows:

1) Press claim, play or keep if you see it.
2) If it’s not your turn, press space every interval. If it is your turn, scan your hand for basic lands and play one, then scan again for castable spell (up to three casts per turn if available), then press space until it’s not your turn.
3) If you see an end match screen, click away.

As such, it’s useful to keep in mind that the bot will always attack with all creatures and never block with any.

It’s also easy to realize that there are many actions that you can make, or your opponents force you to make, that would cause the bot to stall until the roping timer runs out. In the spirit of not wanting to rope my opponents, i have incorporated as many concede conditions as i could. There are game states that the bot recognizes as ones that it can’t deal with, so it just concedes. If something happens that i have not forseen and the timer starts, this is a concede condition as well, and the bot will again, concede at once.

### Bugs

There is a bug that happens some times and it might skip your 1st main phase without playing land/casting spells

### F.A.Q.

None so far

#
#

I hope you enjoy!
If you find this useful, please consider supporting it bellow
[![support](https://raw.githubusercontent.com/Patsa-code/MTGA-bot/main/.github/Support.png)](https://www.buymeacoffee.com/PatsaD)
