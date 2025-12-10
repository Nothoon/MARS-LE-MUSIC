        .text
main:

head:
        # Tempo
        load $t1, $zero, 180
        setbpm $t1
        # 76, 75, 76  → 1,1,2 units
        load $a0, $zero, 76
        load $a1, $zero, 1
        playnote $a0, $a1
        playrest $a1

        load $a0, $zero, 75
        load $a1, $zero, 1
        playnote $a0, $a1
        playrest $a1

        load $a0, $zero, 76
        load $a1, $zero, 2
        playnote $a0, $a1
        playrest $a1

        # 76,74,72,69  (eighths = 2 units)
        load $a0, $zero, 76
        load $a1, $zero, 2
        playnote $a0, $a1
        playrest $a1

        load $a0, $zero, 74
        load $a1, $zero, 2
        playnote $a0, $a1
        playrest $a1

        load $a0, $zero, 72
        load $a1, $zero, 2
        playnote $a0, $a1
        playrest $a1

        load $a0, $zero, 69
        load $a1, $zero, 2
        playnote $a0, $a1
        playrest $a1

        # Arpeggio 57,60,64,69 (all 16ths)
        load $a0, $zero, 57
        load $a1, $zero, 1
        playnote $a0, $a1
        playrest $a1

        load $a0, $zero, 60
        load $a1, $zero, 1
        playnote $a0, $a1
        playrest $a1

        load $a0, $zero, 64
        load $a1, $zero, 1
        playnote $a0, $a1
        playrest $a1

        load $a0, $zero, 69
        load $a1, $zero, 1
        playnote $a0, $a1
        playrest $a1
        # 71,74,72,69  (all eighths)
        load $a0, $zero, 71
        load $a1, $zero, 2
        playnote $a0, $a1
        playrest $a1

        load $a0, $zero, 74
        load $a1, $zero, 2
        playnote $a0, $a1
        playrest $a1

        load $a0, $zero, 72
        load $a1, $zero, 2
        playnote $a0, $a1
        playrest $a1

        load $a0, $zero, 69
        load $a1, $zero, 2
        playnote $a0, $a1
        playrest $a1

        # Arpeggio 57,60,64,69 (16ths)
        load $a0, $zero, 57
        load $a1, $zero, 1
        playnote $a0, $a1
        playrest $a1

        load $a0, $zero, 60
        load $a1, $zero, 1
        playnote $a0, $a1
        playrest $a1

        load $a0, $zero, 64
        load $a1, $zero, 1
        playnote $a0, $a1
        playrest $a1

        load $a0, $zero, 69
        load $a1, $zero, 1
        playnote $a0, $a1
        playrest $a1
        # 64,68,71,72 (16ths), then 69 (8th)

        load $a0, $zero, 64
        load $a1, $zero, 1
        playnote $a0, $a1
        playrest $a1

        load $a0, $zero, 68
        load $a1, $zero, 1
        playnote $a0, $a1
        playrest $a1

        load $a0, $zero, 71
        load $a1, $zero, 1
        playnote $a0, $a1
        playrest $a1

        load $a0, $zero, 72
        load $a1, $zero, 1
        playnote $a0, $a1
        playrest $a1

        # Final A4 (eighth)
        load $a0, $zero, 69
        load $a1, $zero, 2
        playnote $a0, $a1
        playrest $a1
