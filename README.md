# MARS
MARS (official) MIPS Assembler and Runtime Simulator

 MARS is a lightweight interactive development environment (IDE) for programming in MIPS assembly language, intended for educational-level use with Patterson and Hennessy's Computer Organization and Design.
 MARS was developed by Pete Sanderson and Ken Vollmar and can be found at https://dpetersanderson.github.io/.

 This fork of MARS is a under a research project undertaken by John Edelman, Jun Law, and Dominic Dabish in summer 2025, aiming to modernize MARS and specifically to enable students to specify their own custom assembly languages for use with the MARS simulator. 

 The implemented custom assembly language is Music Assembly.

 # Music Assembly Documentation

## Overview
Music Assembly is a music-making language at its core. Brief knowledge of music theory is required to understand some of the functions; however, it is easy to learn on the go. It is a modified version of MIPS that is able to manipulate notes, chords, rhythm, tempo, and drum patterns. With the use of registers, you store pitches, durations, and patterns.

## Core Concepts

### ● Notes and Durations
- Notes are represented by numeric pitch values (See MIDI table below for pitches).
- Durations are expressed in beats implemented with milliseconds.
- Choose what type of beat with 0-3
  - 0 = quarter note
  - 1 = eighth
  - 2 = sixteenth
- `playnote` and `playrest` allow for audio output.

### ● Harmonies and Chords
There are special instructions that compute musical intervals:
- `addmajor3rd`
- `addperf5th`
- `addmajor7th`

Chords are stored in registers `$s0–$s7` and sounded with `playchord`.

### ● Tempo and Timing
Two explicit commands handle timing:
- `setbpm` changes the tempo
- `settsig` sets the time signature (implementation has no use currently but for future visual purposes it is needed)

These govern the base length of notes, rests, and chords.

### ● Drum Patterns
Drum patterns use binary with 8 bitfields:
- Example: `11001100` (1 = hit, 0 = non-hit)
- (See MIDI table below for drum sounds)

`playdrumpat` plays a drum pattern using:
- `$t1` pattern bits  
- `$t2` drum sound  
- `$t3` number of repeats  

Additional drum commands:
- `playsnare`
- `playkick`
- `playchihat`


### ● Control Flow
- `dalsegno` jumps back to a target label (repeat marker)

---

## Using Music Assembly
- Run `Mars.jar`
- Open the `Tools` dropdown menu at the top
- Select `Language Switcher`
- Select `Music Assembly`

## Basic Instructions

| Name | Syntax | Binary Representation | Functionality |
|------|--------|------------------------|---------------|
| Load | `load $t1, $t2, imm` | `101010 sssss fffff tttttttttttttttt` | Loads immediate values such as pitch, duration, bpm, time signature into `$t1`. |
| Add tone | `addtone $t1, $t2` | `000000 00000 sssss fffff 00000 010101` | Adds 2 semitones. |
| Add semitone | `addsemitone $t1, $t2` | `000000 00000 sssss fffff 00000 101010` | Adds 1 semitone. |
| Add major 3rd | `addmajor3rd $t1, $t2` | `000000 00000 sssss fffff 00000 111000` | Adds 4 semitones. |
| Add minor 3rd | `addminor3rd $t1, $t2` | `000000 00000 sssss fffff 00000 111001` | Adds 3 semitones. |
| Add perf 5th | `addperf5th $t1, $t2` | `000000 00000 sssss fffff 00000 111010` | Adds 7 semitones. |
| Add major 7th | `addmajor7th $t1, $t2` | `000000 00000 sssss fffff 00000 111011` | Adds 11 semitones. |
| Add minor 7th | `addminor7th $t1, $t2` | `000000 00000 sssss fffff 00000 111100` | Adds 10 semitones. |
| Dal segno | `dalsegno target` | `000010 ffffffffffffffffffffffff` | Jumps to target label. |
| Set bpm | `setbpm $t1` | `000000 fffff 00000 00000 00000 111111` | Sets overall song bpm. |
| Set time signature (not useful without visual music notation GUI) | `settsig $t1, $t2` | `000000 00000 sssss fffff 00000 101111` | Sets numerator + denominator. |

---

## Unique Instructions

| Name | Syntax | Binary Representation | Functionality |
|------|--------|------------------------|---------------|
| Play closed hi-hat | `playchihat` | `000000 00000 00000 00000 00000 001010` | Plays a closed hi-hat sound |
| Play open hi-hat | `playohihat` | `000000 00000 00000 00000 00000 001011` | Plays an open hi-hat |
| Play kick | `playkick` | `000000 00000 00000 00000 00000 001100` | Plays a kick sound |
| Play snare | `playsnare` | `000000 00000 00000 00000 00000 001110` | Plays a snare sound |
| Play crash | `playcrash` | `000000 00000 00000 00000 00000 001111` | Plays a crash sound |
| Play note | `playnote $t1, $t2, $t3` | `000000 fffff sssss ttttt 00000 111001` | Plays MIDI note `$t1` `$t2` times if note is `$t3` |
| Play chord | `playchord $t1, $t2` | `000000 fffff sssss 00000 00000 111010` | Plays chord stored in `$s0–$s7` `$t1` times if note is `$t2`|
| Play rest | `playrest $t1, $t2` | `000000 fffff sssss 00000 00000 111010` | Plays a rest `$t1` times if note is `$t2`|
| Play drum pattern | `playdrumpat $t1, $t2, $t3` | `000000 sssss ttttt fffff 00000 101100` | Plays binary pattern `$t1` using drum sound `$t2`, `$t3` times |
| Play arpeggio (not implemented) | `playarpeg $t1` | `000000 fffff 00000 00000 00000 011111` | Plays arpeggio for `$t1` times using `$s0–$s7` |

---

## Reserved Registers

| Register(s) | Function |
|-------------|----------|
| `$s0–$s7` | Used to store notes for `playarpeg` and `playchord` |

All other registers are free to use.

---

## Sample Code

### Program 1: Single Note, Then Rest
```
```# Program 1: Single note, then rest

        .text
main:
        # 1. Set tempo (BPM)
        # Set BPM to 100
        load    $t1, $zero, 100      # $t1 = 100
        setbpm  $t1

        # 2. Play one long note
        # Middle C = MIDI 60
        load    $t1, $zero, 60       # $t1 = pitch (60)
        load    $t2, $zero, 4        # $t2 = duration in beats (4 beats)
        load    $t3, $zero, 0        # $t3 = note index (0 = quarter note)
        playnote $t1, $t2, $t3       # play C4 for 4 quarter-note beats

        # 3. Rest (silence)
        load    $t1, $zero, 2        # $t1 = duration in beats (2 beats)
        load    $t2, $zero, 0        # $t2 = note index (0 = quarter note)
        playrest $t1, $t2            # 2 beats of silence
```

### Program 2: Build a C major chord with interval instructions
```
        .text
main:
        # 1. Set tempo
        load    $t1, $zero, 90       # 90 BPM
        setbpm  $t1

        # 2. Build a C major chord in $s0–$s2
        # Root: C4 = MIDI 60
        load    $t0, $zero, 60       # $t0 = 60

        # E = C + major 3rd
        addmajor3rd $t1, $t0         # $t1 = 60 + 4 = 64 (E4)

        # G = C + perfect 5th
        addperf5th  $t2, $t0         # $t2 = 60 + 7 = 67 (G4)

        # Store chord tones into $s0–$s7
        # (only first three used here)
        load    $s0, $zero, 60       # C4
        load    $s1, $zero, 64       # E4
        load    $s2, $zero, 67       # G4

        # 3. Play the chord
        load    $t1, $zero, 4        # duration in beats (4)
        load    $t2, $zero, 0        # note index (0 = quarter note)
        playchord $t1, $t2           # play C major chord for 4 beats

        # Then a rest so it doesn't cut off too fast
        load    $t1, $zero, 2
        load    $t2, $zero, 0
        playrest $t1, $t2
```

### Program 3: Drum groove + G major chord
```
        .text
main:
        # 1. Tempo
        load    $t0, $zero, 80       # 80 BPM
        setbpm  $t0


        # 2. Start drum patterns (1 bar each)
        # HI-HAT: all eighth notes (11111111)
        load    $t1, $zero, 255      # pattern
        load    $t2, $zero, 42       # closed hi-hat MIDI note
        load    $t3, $zero, 1        # repeat 1 bar
        playdrumpat $t1, $t2, $t3

        # KICK: beats 1 and 3 (10001000)
        load    $t1, $zero, 136
        load    $t2, $zero, 36       # kick MIDI note
        load    $t3, $zero, 1
        playdrumpat $t1, $t2, $t3

        # SNARE: beats 2 and 4 (00100010)
        load    $t1, $zero, 34
        load    $t2, $zero, 38       # snare MIDI note
        load    $t3, $zero, 1
        playdrumpat $t1, $t2, $t3

        # Optional: crash at the start of the loop
        playcrash                    # one-shot crash cymbal

        # 3. G major chord over the groove
        # G major: G–B–D
        load    $s0, $zero, 55       # G3
        load    $s1, $zero, 59       # B3
        load    $s2, $zero, 62       # D4

        load    $t1, $zero, 4        # duration = 4 beats
        load    $t2, $zero, 0        # quarter-note index
        playchord $t1, $t2
```
### Running Example Programs
---
The example programs are stored in `MusicAssemblyEx1.asm`, `MusicAssemblyEx2.asm`, and `MusicAssembly3.asm` respectively.

To run them open the file in `Mars.jar` choose `Music Assembly` for you language and assemble and run

### Pitch Midi Table
---
| MIDI | Note |
|------|-------|
| 0 | C-1 |
| 1 | C#-1 / Db-1 |
| 2 | D-1 |
| 3 | D#-1 / Eb-1 |
| 4 | E-1 |
| 5 | F-1 |
| 6 | F#-1 / Gb-1 |
| 7 | G-1 |
| 8 | G#-1 / Ab-1 |
| 9 | A-1 |
| 10 | A#-1 / Bb-1 |
| 11 | B-1 |
| 12 | C0 |
| 13 | C#0 / Db0 |
| 14 | D0 |
| 15 | D#0 / Eb0 |
| 16 | E0 |
| 17 | F0 |
| 18 | F#0 / Gb0 |
| 19 | G0 |
| 20 | G#0 / Ab0 |
| 21 | A0 |
| 22 | A#0 / Bb0 |
| 23 | B0 |
| 24 | C1 |
| 25 | C#1 / Db1 |
| 26 | D1 |
| 27 | D#1 / Eb1 |
| 28 | E1 |
| 29 | F1 |
| 30 | F#1 / Gb1 |
| 31 | G1 |
| 32 | G#1 / Ab1 |
| 33 | A1 |
| 34 | A#1 / Bb1 |
| 35 | B1 |
| 36 | C2 |
| 37 | C#2 / Db2 |
| 38 | D2 |
| 39 | D#2 / Eb2 |
| 40 | E2 |
| 41 | F2 |
| 42 | F#2 / Gb2 |
| 43 | G2 |
| 44 | G#2 / Ab2 |
| 45 | A2 |
| 46 | A#2 / Bb2 |
| 47 | B2 |
| 48 | C3 |
| 49 | C#3 / Db3 |
| 50 | D3 |
| 51 | D#3 / Eb3 |
| 52 | E3 |
| 53 | F3 |
| 54 | F#3 / Gb3 |
| 55 | G3 |
| 56 | G#3 / Ab3 |
| 57 | A3 |
| 58 | A#3 / Bb3 |
| 59 | B3 |
| 60 | C4 (Middle C) |
| 61 | C#4 / Db4 |
| 62 | D4 |
| 63 | D#4 / Eb4 |
| 64 | E4 |
| 65 | F4 |
| 66 | F#4 / Gb4 |
| 67 | G4 |
| 68 | G#4 / Ab4 |
| 69 | A4 (440 Hz) |
| 70 | A#4 / Bb4 |
| 71 | B4 |
| 72 | C5 |
| 73 | C#5 / Db5 |
| 74 | D5 |
| 75 | D#5 / Eb5 |
| 76 | E5 |
| 77 | F5 |
| 78 | F#5 / Gb5 |
| 79 | G5 |
| 80 | G#5 / Ab5 |
| 81 | A5 |
| 82 | A#5 / Bb5 |
| 83 | B5 |
| 84 | C6 |
| 85 | C#6 / Db6 |
| 86 | D6 |
| 87 | D#6 / Eb6 |
| 88 | E6 |
| 89 | F6 |
| 90 | F#6 / Gb6 |
| 91 | G6 |
| 92 | G#6 / Ab6 |
| 93 | A6 |
| 94 | A#6 / Bb6 |
| 95 | B6 |
| 96 | C7 |
| 97 | C#7 / Db7 |
| 98 | D7 |
| 99 | D#7 / Eb7 |
| 100 | E7 |
| 101 | F7 |
| 102 | F#7 / Gb7 |
| 103 | G7 |
| 104 | G#7 / Ab7 |
| 105 | A7 |
| 106 | A#7 / Bb7 |
| 107 | B7 |
| 108 | C8 |
| 109 | C#8 / Db8 |
| 110 | D8 |
| 111 | D#8 / Eb8 |
| 112 | E8 |
| 113 | F8 |
| 114 | F#8 / Gb8 |
| 115 | G8 |
| 116 | G#8 / Ab8 |
| 117 | A8 |
| 118 | A#8 / Bb8 |
| 119 | B8 |
| 120 | C9 |
| 121 | C#9 / Db9 |
| 122 | D9 |
| 123 | D#9 / Eb9 |
| 124 | E9 |
| 125 | F9 |
| 126 | F#9 / Gb9 |
| 127 | G9 |

### Drum Midi Table
---
| MIDI | Drum Sound |
|------|-------------|
| 35 | Acoustic Bass Drum |
| 36 | Bass Drum 1 |
| 37 | Side Stick / Rimshot |
| 38 | Acoustic Snare |
| 39 | Hand Clap |
| 40 | Electric Snare |
| 41 | Low Floor Tom |
| 42 | Closed Hi-Hat |
| 43 | High Floor Tom |
| 44 | Pedal Hi-Hat |
| 45 | Low Tom |
| 46 | Open Hi-Hat |
| 47 | Low-Mid Tom |
| 48 | Hi-Mid Tom |
| 49 | Crash Cymbal 1 |
| 50 | High Tom |
| 51 | Ride Cymbal 1 |
| 52 | Chinese Cymbal |
| 53 | Ride Bell |
| 54 | Tambourine |
| 55 | Splash Cymbal |
| 56 | Cowbell |
| 57 | Crash Cymbal 2 |
| 58 | Vibraslap |
| 59 | Ride Cymbal 2 |
| 60 | Hi Bongo |
| 61 | Low Bongo |
| 62 | Mute Hi Conga |
| 63 | Open Hi Conga |
| 64 | Low Conga |
| 65 | High Timbale |
| 66 | Low Timbale |
| 67 | High Agogo |
| 68 | Low Agogo |
| 69 | Cabasa |
| 70 | Maracas |
| 71 | Short Whistle |
| 72 | Long Whistle |
| 73 | Short Guiro |
| 74 | Long Guiro |
| 75 | Claves |
| 76 | Hi Wood Block |
| 77 | Low Wood Block |
| 78 | Mute Cuica |
| 79 | Open Cuica |
| 80 | Mute Triangle |
| 81 | Open Triangle |


