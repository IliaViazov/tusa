# OSCILLATORS

Oscillators are continuously varying patterns. Unless otherwise stated, oscillators give minimum values of 0 and maximum values of 1, and repeat once per cycle.

|**Oscillator** | **Description** | **Code** |
|--------|-------------|------|
| sine   | Sinusoidal wave | `d1 $ sound "bd*8" # pan sine"` |
|	 | | |
| cosine | Cosinusoidal wave | `d1 $ sound "bd*8" # pan cosine` |
|	 | | |
| square | Square wave | `d1 $ sound "bd*8" # pan (cat [square, sine])` |
| 	 | | |
| tri      | Triangular wave | `d1 $ sound "bd*16" # speed (slow 2 $ range 0.5 2 tri)` |
| 	 | | |
| saw      | Sawtooth wave | `d1 $ sound "bd*8" # pan (slow 2 saw)` |
| 	 | | |
| isaw      | Inverted sawtooth wave | `d1 $ sound "bd*8" # pan (slow 2 isaw)` |
| 	 | | |
| smooth     | Linear interpolation | `d1 $ sound "bd*4" # pan (slow 4 $ smooth "0 1 0.5 1")` |
|	 | | |
| rand   | Random generator | `d1 $ sound "bd*8" # pan rand` |
|	 | | |
| irand      | Integer random generator (arg max) | `d1 $ sound "drum*8" # n (irand 8)` |

#### Scaling the oscillator
By default, the oscillators will output values scaled between 0 and 1. You might want to use bigger or smaller values. You might want, for instance, to modulate the frequency of a filter or select a random midi note between 0 and 127. To do so, you can use the range function:

`d1 $ s "bass:5*8" # lpf (range 200 5000 $ sine)`

#### Speeding up/down oscillators
Oscillators are patterns! It means that you can speed them up or down using the same function as usual (`fast`, `slow`, etc..):

`d1 $ s "bass:5*8" # lpf (slow 4 $ range 200 5000 $ sine)`
