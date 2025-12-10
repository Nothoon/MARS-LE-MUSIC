    .text
main:

############################################
# Common chord duration: 4 beats, quarter notes
############################################
    load $t0, $zero, 4      # duration in beats
    load $t1, $zero, 0      # notes[0] = quarter note

############################################
# MEASURE 1 — G major (G B D)
############################################

    # Chord: G major
    load $s0, $zero, 55     # G3
    load $s1, $zero, 59     # B3
    load $s2, $zero, 62     # D4
    playchord $t0, $t1      # 4 beats

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
    load $t3, $zero, 4
    playdrumpat $t1, $t2, $t3

############################################
# MEASURE 2 — B major (B D# F#)
############################################

    load $t0, $zero, 4      # duration in beats
    load $t1, $zero, 0      # notes[0] = quarter note

    load $s0, $zero, 59     # B3
    load $s1, $zero, 63     # D#4
    load $s2, $zero, 66     # F#4
    playchord $t0, $t1

############################################
# MEASURE 3 — C major (C E G)
############################################

    load $t0, $zero, 4      # duration in beats
    load $t1, $zero, 0      # notes[0] = quarter note

    load $s0, $zero, 60     # C4
    load $s1, $zero, 64     # E4
    load $s2, $zero, 67     # G4
    playchord $t0, $t1

############################################
# MEASURE 4 — C minor (C Eb G)
############################################

    load $t0, $zero, 4      # duration in beats
    load $t1, $zero, 0      # notes[0] = quarter note

    load $s0, $zero, 60     # C4
    load $s1, $zero, 63     # Eb4
    load $s2, $zero, 67     # G4
    playchord $t0, $t1
