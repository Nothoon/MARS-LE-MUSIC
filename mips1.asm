    # Hi-hat: pattern 11111111 (255), MIDI 42, repeat 1 bar
    load $t1, $zero, 255    # pattern
    load $t2, $zero, 42     # hi-hat note
    load $t3, $zero, 4      # repetitions
    playdrumpat $t1, $t2, $t3
    # Snare: pattern 00100010 (34), MIDI 38
    load $t1, $zero, 34     # pattern
    load $t2, $zero, 38     # snare note
    load $t3, $zero, 4
    playdrumpat $t1, $t2, $t3
    # Kick: pattern 10000001
    load $t1, $zero, 129    # pattern
    load $t2, $zero, 36     # kick note
    load $t3, $zero, 1
    playdrumpat $t1, $t2, $t3
    load $t0, $zero, 4      # duration in beats
    load $t1, $zero, 0      # notes[0] = quarter note
    playrest $t0, $t1
    # Kick: pattern 10000001
    load $t1, $zero, 160    # pattern
    load $t2, $zero, 36     # kick note
    load $t3, $zero, 1
    load $t0, $zero, 4      # duration in beats
    load $t1, $zero, 0      # notes[0] = quarter note
    playrest $t0, $t1
    # Kick: pattern 10000001
    load $t1, $zero, 129    # pattern
    load $t2, $zero, 36     # kick note
    load $t3, $zero, 1
    playdrumpat $t1, $t2, $t3
    load $t0, $zero, 4      # duration in beats
    load $t1, $zero, 0      # notes[0] = quarter note
    playrest $t0, $t1
    # Kick: pattern 10000001
    load $t1, $zero, 160    # pattern
    load $t2, $zero, 36     # kick note
    load $t3, $zero, 1