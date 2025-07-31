# track_and_field
remake of Track and Field / Hyper Olympic for amiga AGA & ECS

credits:
- jotd: transcode and amiga port, graphics & sound conversion
- no9: music
- PascalDe73: amiga icon
- Konami: original game

features:

- runs in PAL or NTSC, NTSC being possibly more reactive to button readings
(no effect when playing from keyboard)
- fixed record times at zero on dash/hurdles in the original. On the original game
  you have to use DSW to reset records and get valid times (but they're super hard
  to beat... At least with this version you get your own times, even if they suck).
- AGA and ECS versions available

controls (joypad 1P/2P):

run: left/right or blue/green
jump/throw: red/fire

2P joypad controls only enabled if real joypad is connected in port 0

There's a fire1/fire2/up option too, which works well on joypads too, and also
allows to build your own custom controllers that don't use CD32 circuitry.
If this option (whdload only) is set:

- fire 1/fire 2: run
- up: jump
- up: insert coin
- left/right: start game 1P/2P

controls (keyboard):

1P run: left/right keys
1P jump/throw: ctrl
2P run: 4/6 num keys
2P jump/throw: 0 num key

5/6: insert coins
1-4: start 1-4 player game

cheat keys:

- F1: clear fouls/faults
- F2: set best super-speed for current event


I'm certainly no expert but here are simple tactics:

- 100 Meter Dash: just press run buttons as fast as possible.
- Long Jump: press run buttons as fast as possible, and when reaching
  the jump line, press until the angle is at least 40 degrees. Not sure if
  45 degrees is the best angle.
- Javelin: same as long jump. Optimal angle may be different
- 110 Meter Hurdles: for me the hardest event. Press run buttons and jump when
  a hurdle is arriving, while still pressing run buttons.
- Hammer throw: choose the moment when the hammer is changing color to "red" to push
  "action" button & maintain it. 45 degrees is a good angle.
- Long jump: near the poles, press jump briefly, then press run buttons to gain height
  and after a while press (and maintain) jump again to adjust player position.
  
Secret point bonuses:
Every event (besides the fifth) has a secret way of earning an extra 1000 points:
1st Event - 100 Meter Dash: Finish at the same time (tie) as the CPU or other player and you will be given 1000 points by a leprechaun
2nd Event - Long Jump: Finish three completely identical jumps. The leprechaun will again give you 1000 points.
3rd Event - Javelin Throw: Speed up and right before you reach the foul line, hold the throw button but do not release it. The javelin miraculously goes incredibly high, leaving the screen. It eventually hits an alien who gives you 1000 points.
4th Event - 110 Meter Hurdles: Finish at the same time (tie) as the CPU or other player and you will be given 1000 points by the leprechaun again.
6th Event - High Jump: On your first two attempts hit the bar which results in a foul. On the next attempt the bar properly until you qualify. A mole will reward you with 1000 points.
