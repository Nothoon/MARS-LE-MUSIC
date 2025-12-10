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