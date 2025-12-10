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
- Notes are represented by numeric pitch values (MIDI).
- Durations are expressed in beats implemented with milliseconds.
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
- 

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
| Play chord | `playchord $t1, $t2` | `000000 fffff 00000 00000 00000 011010` | Plays chord stored in `$s0–$s7` `$t1` times if note is `$t2`|
| Play rest | `playrest $t1, $t2` | `000000 fffff 00000 00000 00000 011011` | Plays a rest `$t1` times if note is `$t2`|
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




