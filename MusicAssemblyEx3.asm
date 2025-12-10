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