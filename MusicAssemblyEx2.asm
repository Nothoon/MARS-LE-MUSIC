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