package mars.mips.instructions.customlangs;

import mars.simulator.*;
import mars.mips.hardware.*;
import mars.mips.instructions.*;
import mars.util.*;
import mars.*;

import javax.sound.midi.*;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class MusicAssembly extends CustomAssembly {

    private static Synthesizer synth = null;
    private static MidiChannel[] midiChannels = null;

    private static int bpm = 110;
    private static int numeratortsig = 4;
    private static int denominatortsig = 4;
    private static int beat = 60000 / bpm;
    private static int eighth = beat / 2;
    private static int sixteenth = beat / 4;
    private static int[] notes = { beat, eighth, sixteenth };

    private static class MusicManager {
        private final ExecutorService drumsExecutor;
        private final ExecutorService melodyExecutor;
        private final ExecutorService chordsExecutor;

        private MusicManager() {
            drumsExecutor = Executors.newCachedThreadPool();
            melodyExecutor = Executors.newSingleThreadExecutor();
            chordsExecutor = Executors.newSingleThreadExecutor();
        }

        public void queueDrum(Runnable task) {
            drumsExecutor.submit(task);
        }

        public void queueMelody(Runnable task) {
            melodyExecutor.submit(task);
        }

        public void queueChord(Runnable task) {
            chordsExecutor.submit(task);
        }
    }

    private static final MusicManager musicManager = new MusicManager();

    static {
        try {
            synth = MidiSystem.getSynthesizer();
            synth.open();
            midiChannels = synth.getChannels();
            SystemIO.printString("MusicLanguage: MIDI synthesizer initialized.\n");
        } catch (MidiUnavailableException e) {
            SystemIO.printString("MusicLanguage: MIDI synthesizer unavailable: "
                                 + e.getMessage() + "\n");
        }
    }

    private static void playMidiNote(int pitch, int repetitions, int note) {
        if (synth == null || midiChannels == null) {
            SystemIO.printString("MusicLanguage: synth not initialized.\n");
            return;
        }

        final int channel = 0;
        final MidiChannel ch = midiChannels[channel];
        final int p = pitch;
        final int dur = repetitions * note;
        final int velocity = 90;

        musicManager.queueMelody(() -> {
            try {
                ch.noteOn(p, velocity);
                Thread.sleep(dur);
                ch.noteOff(p);
            } catch (InterruptedException ex) {
                Thread.currentThread().interrupt();
            }
        });
    }

    private static void playDrumNote(int pitch, int repetitions, int note) {
        if (synth == null || midiChannels == null) {
            SystemIO.printString("MusicLanguage: synth not initialized.\n");
            return;
        }

        final int channel = 9;
        final MidiChannel ch = midiChannels[channel];
        final int p = pitch;
        final int dur = repetitions * note;
        final int velocity = 90;

        musicManager.queueDrum(() -> {
            try {
                if (p >= 0) {
                    ch.noteOn(p, velocity);
                    Thread.sleep(dur);
                    ch.noteOff(p);
                } else {
                    // rest: just wait
                    Thread.sleep(dur);
                }
            } catch (InterruptedException ex) {
                Thread.currentThread().interrupt();
            }
        });
    }

    private static void playChordSimultaneous(int[] pitches, int repetitions, int note) {
        if (synth == null || midiChannels == null) {
            SystemIO.printString("MusicLanguage: synth not initialized.\n");
            return;
        }

        final int channel = 0;
        final MidiChannel ch = midiChannels[channel];
        final int dur = repetitions * note;
        final int velocity = 90;

        musicManager.queueChord(() -> {
            try {
                for (int p : pitches) {
                    if (p > 0) {
                        ch.noteOn(p, velocity);
                    }
                }
                Thread.sleep(dur);
            } catch (InterruptedException ex) {
                Thread.currentThread().interrupt();
            } finally {
                for (int p : pitches) {
                    if (p > 0) {
                        ch.noteOff(p);
                    }
                }
            }
        });
    }

    private static void playDrumPattern(int pattern, int drumSound, int repetitions) {
        if (synth == null || midiChannels == null) {
            SystemIO.printString("MusicLanguage: synth not initialized.\n");
            return;
        }

        final int channel = 9;
        final MidiChannel ch = midiChannels[channel];
        final int p = drumSound;
        final int velocity = 90;

        final int steps = 8;
        final String binary = String.format("%" + steps + "s",
                Integer.toBinaryString(pattern)).replace(' ', '0');

        musicManager.queueDrum(() -> {
            try {
                for (int j = 0; j < repetitions; j++) {
                    for (int i = 0; i < binary.length(); i++) {
                        if (binary.charAt(i) == '1') {
                            ch.noteOn(p, velocity);
                            Thread.sleep(eighth);
                            ch.noteOff(p);
                        } else {
                            Thread.sleep(eighth);
                        }
                    }
                }
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
            }
        });
    }

    @Override
    public String getName() {
        return "Music Assembly";
    }

    @Override
    public String getDescription() {
        return "Make music";
    }


    @Override
    protected void populate() {
        instructionList.add(
            new BasicInstruction("load $t1,$t2,-100",
                "Loads an immediate value + $t2 to corresponding to MIDI pitch or millisecond duration in $t1",
                BasicInstructionFormat.I_FORMAT,
                "101010 sssss fffff tttttttttttttttt",
                new SimulationCode() {
                    public void simulate(ProgramStatement statement) throws ProcessingException {
                        int[] operands = statement.getOperands();
                        int imm = operands[2] << 16 >> 16;
                        RegisterFile.updateRegister(operands[0], imm);
                    }
                }));

        instructionList.add(
            new BasicInstruction("addsemitone $t1,$t2",
                "adds a semitone to $t2 and stores in $t1",
                BasicInstructionFormat.R_FORMAT,
                "000000 00000 sssss fffff 00000 101010",
                new SimulationCode() {
                    public void simulate(ProgramStatement statement) throws ProcessingException {
                        int[] operands = statement.getOperands();
                        int sreg = operands[1];
                        int value = RegisterFile.getValue(sreg);
                        value += 1;
                        RegisterFile.updateRegister(operands[0], value);
                    }
                }));

        instructionList.add(
            new BasicInstruction("addtone $t1,$t2",
                "adds a tone to $t2 and stores in $t1",
                BasicInstructionFormat.R_FORMAT,
                "000000 00000 sssss fffff 00000 010101",
                new SimulationCode() {
                    public void simulate(ProgramStatement statement) throws ProcessingException {
                        int[] operands = statement.getOperands();
                        int sreg = operands[1];
                        int value = RegisterFile.getValue(sreg);
                        value += 2;
                        RegisterFile.updateRegister(operands[0], value);
                    }
                }));

        instructionList.add(
            new BasicInstruction("addminor3rd $t1,$t2",
                "adds 3 semitones to $t2 and stores in $t1",
                BasicInstructionFormat.R_FORMAT,
                "000000 00000 sssss fffff 00000 010101",
                new SimulationCode() {
                    public void simulate(ProgramStatement statement) throws ProcessingException {
                        int[] operands = statement.getOperands();
                        int sreg = operands[1];
                        int value = RegisterFile.getValue(sreg);
                        value += 3;
                        RegisterFile.updateRegister(operands[0], value);
                    }
                }));

        instructionList.add(
            new BasicInstruction("addmajor3rd $t1,$t2",
                "adds 4 semitones to $t2 and stores in $t1",
                BasicInstructionFormat.R_FORMAT,
                "000000 00000 sssss fffff 00000 010101",
                new SimulationCode() {
                    public void simulate(ProgramStatement statement) throws ProcessingException {
                        int[] operands = statement.getOperands();
                        int sreg = operands[1];
                        int value = RegisterFile.getValue(sreg);
                        value += 4;
                        RegisterFile.updateRegister(operands[0], value);
                    }
                }));

        instructionList.add(
            new BasicInstruction("addperf5th $t1,$t2",
                "adds 7 semitones to $t2 and stores in $t1",
                BasicInstructionFormat.R_FORMAT,
                "000000 00000 sssss fffff 00000 010101",
                new SimulationCode() {
                    public void simulate(ProgramStatement statement) throws ProcessingException {
                        int[] operands = statement.getOperands();
                        int sreg = operands[1];
                        int value = RegisterFile.getValue(sreg);
                        value += 7;
                        RegisterFile.updateRegister(operands[0], value);
                    }
                }));

        instructionList.add(
            new BasicInstruction("addminor7th $t1,$t2",
                "adds 10 semitones to $t2 and stores in $t1",
                BasicInstructionFormat.R_FORMAT,
                "000000 00000 sssss fffff 00000 010101",
                new SimulationCode() {
                    public void simulate(ProgramStatement statement) throws ProcessingException {
                        int[] operands = statement.getOperands();
                        int sreg = operands[1];
                        int value = RegisterFile.getValue(sreg);
                        value += 10;
                        RegisterFile.updateRegister(operands[0], value);
                    }
                }));

        instructionList.add(
            new BasicInstruction("addmajor7th $t1,$t2",
                "adds 11 semitones to $t2 and stores in $t1",
                BasicInstructionFormat.R_FORMAT,
                "000000 00000 sssss fffff 00000 010101",
                new SimulationCode() {
                    public void simulate(ProgramStatement statement) throws ProcessingException {
                        int[] operands = statement.getOperands();
                        int sreg = operands[1];
                        int value = RegisterFile.getValue(sreg);
                        value += 11;
                        RegisterFile.updateRegister(operands[0], value);
                    }
                }));

        instructionList.add(
            new BasicInstruction(
                "playnote $t1,$t2,$t3",
                "Plays MIDI note $t1 $t2 times if note is $t3",
                BasicInstructionFormat.R_FORMAT,
                "000000 fffff sssss ttttt 00000 111001",
                new SimulationCode() {
                    public void simulate(ProgramStatement statement) throws ProcessingException {
                        int[] ops = statement.getOperands();
                        int pitch = RegisterFile.getValue(ops[0]);
                        int dur = RegisterFile.getValue(ops[1]);
                        int note = notes[RegisterFile.getValue(ops[2])];

                        if (dur > 0) {
                            playMidiNote(pitch, dur, note);
                        }
                    }
                }));

        instructionList.add(
            new BasicInstruction(
                "playsnare",
                "Plays a snare sound",
                BasicInstructionFormat.R_FORMAT,
                "000000 00000 00000 00000 00000 111001",
                new SimulationCode() {
                    public void simulate(ProgramStatement statement) throws ProcessingException {
                        SystemIO.printString("Playing Snare\n");
                        playDrumNote(38, 1, beat);
                    }
                }));

        instructionList.add(
            new BasicInstruction(
                "playkick",
                "Plays a kick sound",
                BasicInstructionFormat.R_FORMAT,
                "000000 00000 00000 00000 00000 111001",
                new SimulationCode() {
                    public void simulate(ProgramStatement statement) throws ProcessingException {
                        SystemIO.printString("Playing Kick\n");
                        playDrumNote(36, 1, beat);
                    }
                }));

        instructionList.add(
            new BasicInstruction(
                "playchihat",
                "Plays a closed high-hat sound",
                BasicInstructionFormat.R_FORMAT,
                "000000 00000 00000 00000 00000 111001",
                new SimulationCode() {
                    public void simulate(ProgramStatement statement) throws ProcessingException {
                        SystemIO.printString("Playing Closed Hi-hat\n");
                        playDrumNote(42, 1, beat);
                    }
                }));
        
        instructionList.add(
            new BasicInstruction(
                "playohihat",
                "Plays a open high-hat sound",
                BasicInstructionFormat.R_FORMAT,
                "000000 00000 00000 00000 00000 111110",
                new SimulationCode() {
                    public void simulate(ProgramStatement statement) throws ProcessingException {
                        SystemIO.printString("Playing Open Hi-hat\n");
                        playDrumNote(46, 1, beat);
                    }
                }));
            
        
        instructionList.add(
            new BasicInstruction(
                "playcrash",
                "Plays a crash sound",
                BasicInstructionFormat.R_FORMAT,
                "000000 00000 00000 00000 00000 110110",
                new SimulationCode() {
                    public void simulate(ProgramStatement statement) throws ProcessingException {
                        SystemIO.printString("Playing Crash\n");
                        playDrumNote(49, 1, beat);
                    }
                }));

        instructionList.add(
            new BasicInstruction(
                "playrest $t1,$t2",
                "Plays a rest $t1 times if note is $t2",
                BasicInstructionFormat.R_FORMAT,
                "000000 fffff sssss 00000 00000 111010",
                new SimulationCode() {
                    public void simulate(ProgramStatement statement) throws ProcessingException {
                        int[] ops = statement.getOperands();
                        int dur = RegisterFile.getValue(ops[0]);
                        int note = notes[RegisterFile.getValue(ops[1])];
                        try {
                            Thread.sleep(dur * note);
                        } catch (InterruptedException e) {
                            Thread.currentThread().interrupt();
                            SystemIO.printString("Thread.sleep() interrupted\n");
                        } catch (Exception e) {
                            SystemIO.printString("Thread.sleep() error\n");
                        }
                    }
                }));

        instructionList.add(
            new BasicInstruction(
                "playchord $t1,$t2",
                "Plays chord stored in $s0–$s7 $t1 times if note is $t2",
                BasicInstructionFormat.R_FORMAT,
                "000000 fffff sssss 00000 00000 111010",
                new SimulationCode() {
                    public void simulate(ProgramStatement statement) throws ProcessingException {
                        int[] ops = statement.getOperands();
                        int dur = RegisterFile.getValue(ops[0]);
                        int noteIndex = RegisterFile.getValue(ops[1]);

                        if (dur > 0) {
                            int note = notes[noteIndex];
                            int[] pitches = new int[8]; // $s0-$s7 are 16–23
                            for (int i = 0; i < 8; i++) {
                                pitches[i] = RegisterFile.getValue(16 + i);
                            }
                            playChordSimultaneous(pitches, dur, note);
                        }
                    }
                }));

        instructionList.add(
            new BasicInstruction("dalsegno target",
                "Jump to target",
                BasicInstructionFormat.J_FORMAT,
                "000010 ffffffffffffffffffffffffff",
                new SimulationCode() {
                    public void simulate(ProgramStatement statement) throws ProcessingException {
                        int[] operands = statement.getOperands();
                        Globals.instructionSet.processJump(
                            ((RegisterFile.getProgramCounter() & 0xF0000000)
                             | (operands[0] << 2)));
                    }
                }));

        instructionList.add(
            new BasicInstruction(
                "setbpm $t1",
                "Sets song bpm to $t1",
                BasicInstructionFormat.R_FORMAT,
                "000000 fffff 00000 00000 00000 111010",
                new SimulationCode() {
                    public void simulate(ProgramStatement statement) throws ProcessingException {
                        int[] ops = statement.getOperands();
                        int beatspermin = RegisterFile.getValue(ops[0]);
                        bpm = beatspermin;
                        beat = 60000 / bpm;
                        eighth = beat / 2;
                        sixteenth = beat / 4;
                        notes[0] = beat;
                        notes[1] = eighth;
                        notes[2] = sixteenth;
                    }
                }));

        instructionList.add(
            new BasicInstruction(
                "settsig $t1,$t2",
                "Sets song time signature to $t1/$t2",
                BasicInstructionFormat.R_FORMAT,
                "000000 00000 sssss fffff 00000 101111",
                new SimulationCode() {
                    public void simulate(ProgramStatement statement) throws ProcessingException {
                        int[] ops = statement.getOperands();
                        numeratortsig = RegisterFile.getValue(ops[0]);
                        denominatortsig = RegisterFile.getValue(ops[1]);
                    }
                }));

        instructionList.add(
            new BasicInstruction(
                "playdrumpat $t1,$t2,$t3",
                "Plays binary pattern $t1 using drum sound $t2, $t3 times",
                BasicInstructionFormat.R_FORMAT,
                "000000 sssss ttttt fffff 00000 101100",
                new SimulationCode() {
                    public void simulate(ProgramStatement statement) throws ProcessingException {
                        int[] ops = statement.getOperands();
                        int pattern = RegisterFile.getValue(ops[0]);
                        int drumsound = RegisterFile.getValue(ops[1]);
                        int repetitions = RegisterFile.getValue(ops[2]);

                        SystemIO.printString("Pattern = " + pattern + "\n");
                        SystemIO.printString("Drum sound = " + drumsound + "\n");
                        SystemIO.printString("Repetitions = " + repetitions + "\n");

                        playDrumPattern(pattern, drumsound, repetitions);
                    }
                }));
    }
}
