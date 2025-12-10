        .text
main:

head:
        # Set tempo (adjust as you like)
        load $t1, $zero, 640
        setbpm $t1        # 160 BPM

        ############################################################
        # JINGLE BELLS - Chorus (Key C, melody only)
        # 1 unit = sixteenth note
        # Quarter = 4, Half = 8, Whole = 16
        ############################################################

        ############################################
        # Phrase 1: "Jingle bells, jingle bells,"
        # E  E  E   | E  E  E   | E  G  C  D   | E---
        ############################################

        # E4 (64), quarter
        load $a0, $zero, 64
        load $a1, $zero, 4
        playnote $a0, $a1
        playrest $a1

        # E4
        load $a0, $zero, 64
        load $a1, $zero, 4
        playnote $a0, $a1
        playrest $a1

        # E4, half (2 beats)
        load $a0, $zero, 64
        load $a1, $zero, 8
        playnote $a0, $a1
        playrest $a1

        # E4
        load $a0, $zero, 64
        load $a1, $zero, 4
        playnote $a0, $a1
        playrest $a1

        # E4
        load $a0, $zero, 64
        load $a1, $zero, 4
        playnote $a0, $a1
        playrest $a1

        # E4, half
        load $a0, $zero, 64
        load $a1, $zero, 8
        playnote $a0, $a1
        playrest $a1

        # E4, quarter
        load $a0, $zero, 64
        load $a1, $zero, 4
        playnote $a0, $a1
        playrest $a1

        # G4, quarter
        load $a0, $zero, 67
        load $a1, $zero, 4
        playnote $a0, $a1
        playrest $a1

        # C4, quarter
        load $a0, $zero, 60
        load $a1, $zero, 4
        playnote $a0, $a1
        playrest $a1

        # D4, quarter
        load $a0, $zero, 62
        load $a1, $zero, 4
        playnote $a0, $a1
        playrest $a1

        # E4, whole (4 beats)
        load $a0, $zero, 64
        load $a1, $zero, 16
        playnote $a0, $a1
        playrest $a1


        ############################################
        # Phrase 2: "Jingle bells, jingle bells,"
        # Same as Phrase 1
        ############################################

        # E4
        load $a0, $zero, 64
        load $a1, $zero, 4
        playnote $a0, $a1
        playrest $a1

        # E4
        load $a0, $zero, 64
        load $a1, $zero, 4
        playnote $a0, $a1
        playrest $a1

        # E4, half
        load $a0, $zero, 64
        load $a1, $zero, 8
        playnote $a0, $a1
        playrest $a1

        # E4
        load $a0, $zero, 64
        load $a1, $zero, 4
        playnote $a0, $a1
        playrest $a1

        # E4
        load $a0, $zero, 64
        load $a1, $zero, 4
        playnote $a0, $a1
        playrest $a1

        # E4, half
        load $a0, $zero, 64
        load $a1, $zero, 8
        playnote $a0, $a1
        playrest $a1

        # E4
        load $a0, $zero, 64
        load $a1, $zero, 4
        playnote $a0, $a1
        playrest $a1

        # G4
        load $a0, $zero, 67
        load $a1, $zero, 4
        playnote $a0, $a1
        playrest $a1

        # C4
        load $a0, $zero, 60
        load $a1, $zero, 4
        playnote $a0, $a1
        playrest $a1

        # D4
        load $a0, $zero, 62
        load $a1, $zero, 4
        playnote $a0, $a1
        playrest $a1

        # E4, whole
        load $a0, $zero, 64
        load $a1, $zero, 16
        playnote $a0, $a1
        playrest $a1


        ############################################
        # Phrase 3: "Oh what fun it is to ride..."
        # G  G  G  G  | G  F  F  | E  E  E  E  | E  D  D  E  | G---
        ############################################

        # G4
        load $a0, $zero, 67
        load $a1, $zero, 4
        playnote $a0, $a1
        playrest $a1

        # G4
        load $a0, $zero, 67
        load $a1, $zero, 4
        playnote $a0, $a1
        playrest $a1

        # G4
        load $a0, $zero, 67
        load $a1, $zero, 4
        playnote $a0, $a1
        playrest $a1

        # G4
        load $a0, $zero, 67
        load $a1, $zero, 4
        playnote $a0, $a1
        playrest $a1

        # G4
        load $a0, $zero, 67
        load $a1, $zero, 4
        playnote $a0, $a1
        playrest $a1

        # F4
        load $a0, $zero, 65
        load $a1, $zero, 4
        playnote $a0, $a1
        playrest $a1

        # F4
        load $a0, $zero, 65
        load $a1, $zero, 4
        playnote $a0, $a1
        playrest $a1

        # E4
        load $a0, $zero, 64
        load $a1, $zero, 4
        playnote $a0, $a1
        playrest $a1

        # E4
        load $a0, $zero, 64
        load $a1, $zero, 4
        playnote $a0, $a1
        playrest $a1

        # E4
        load $a0, $zero, 64
        load $a1, $zero, 4
        playnote $a0, $a1
        playrest $a1

        # E4
        load $a0, $zero, 64
        load $a1, $zero, 4
        playnote $a0, $a1
        playrest $a1

        # E4
        load $a0, $zero, 64
        load $a1, $zero, 4
        playnote $a0, $a1
        playrest $a1

        # D4
        load $a0, $zero, 62
        load $a1, $zero, 4
        playnote $a0, $a1
        playrest $a1

        # D4
        load $a0, $zero, 62
        load $a1, $zero, 4
        playnote $a0, $a1
        playrest $a1

        # E4
        load $a0, $zero, 64
        load $a1, $zero, 4
        playnote $a0, $a1
        playrest $a1

        # G4, half
        load $a0, $zero, 67
        load $a1, $zero, 8
        playnote $a0, $a1
        playrest $a1


        ############################################
        # Phrase 4: repeat of phrase 3 ("Oh what fun...")
        ############################################

        # G4
        load $a0, $zero, 67
        load $a1, $zero, 4
        playnote $a0, $a1
        playrest $a1

        # G4
        load $a0, $zero, 67
        load $a1, $zero, 4
        playnote $a0, $a1
        playrest $a1

        # G4
        load $a0, $zero, 67
        load $a1, $zero, 4
        playnote $a0, $a1
        playrest $a1

        # G4
        load $a0, $zero, 67
        load $a1, $zero, 4
        playnote $a0, $a1
        playrest $a1

        # G4
        load $a0, $zero, 67
        load $a1, $zero, 4
        playnote $a0, $a1
        playrest $a1

        # F4
        load $a0, $zero, 65
        load $a1, $zero, 4
        playnote $a0, $a1
        playrest $a1

        # F4
        load $a0, $zero, 65
        load $a1, $zero, 4
        playnote $a0, $a1
        playrest $a1

        # E4
        load $a0, $zero, 64
        load $a1, $zero, 4
        playnote $a0, $a1
        playrest $a1

        # E4
        load $a0, $zero, 64
        load $a1, $zero, 4
        playnote $a0, $a1
        playrest $a1

        # E4
        load $a0, $zero, 64
        load $a1, $zero, 4
        playnote $a0, $a1
        playrest $a1

        # E4
        load $a0, $zero, 64
        load $a1, $zero, 4
        playnote $a0, $a1
        playrest $a1

        # D4
        load $a0, $zero, 62
        load $a1, $zero, 4
        playnote $a0, $a1
        playrest $a1

        # D4
        load $a0, $zero, 62
        load $a1, $zero, 4
        playnote $a0, $a1
        playrest $a1

        # E4
        load $a0, $zero, 64
        load $a1, $zero, 4
        playnote $a0, $a1
        playrest $a1

        # G4, half
        load $a0, $zero, 67
        load $a1, $zero, 8
        playnote $a0, $a1
        playrest $a1


        ############################################
        # Ending / loop
        ############################################

        dalsegno head
