# Signals and Systems – Computer Assignment 2

This folder contains a MATLAB-based coursework submission for Signals and Systems (Computer Assignment 2).  
The assignment focuses on continuous-time Fourier transform properties, audio-domain experiments, and amplitude modulation / demodulation examples.

## What this project demonstrates

- Time-reversal properties of the CTFT using audio playback
- Magnitude-only vs. phase-only reconstruction
- Time-scaling effects on spectrum and perceived audio
- Amplitude modulation and synchronous demodulation
- Morse-code decoding experiments built from modulated signals

## Files

- `403101542_CHW2.m` — MATLAB script that generates the figures and audio experiments
- `403101542_CHW2.pdf` — written report / submitted solution

## Main experiments in the script

### 1) Continuous-Time Fourier Transform properties
- Computes and plots the magnitude spectrum of an audio signal
- Demonstrates that conjugating the spectrum produces the time-reversed audio
- Reconstructs signals from magnitude-only and phase-only spectra
- Demonstrates time compression and time expansion effects

### 2) Amplitude modulation and demodulation
- Loads the course-provided signal data
- Builds Morse-code waveforms
- Applies low-pass filtering and frequency-domain reasoning
- Demonstrates synchronous demodulation of composite modulated signals

## Requirements

- MATLAB
- Audio playback support (`sound`, `pause`)
- Signal-processing functionality used by the script

## How to run

1. Open `403101542_CHW2.m` in MATLAB.
2. Make sure the course-provided input data is available in the MATLAB path.
   - The script uses `load splat`
   - The script also uses `load ctftmod.mat`
3. Run the file section by section or run it as a whole.

## Notes

- This is a course assignment, not a standalone product.
- The value of this folder is in showing CTFT intuition through both plots and audio playback.
- If you publish this in GitHub, keep the report PDF and the MATLAB script together so the experiment is reproducible.

## Resume value

This is useful as a supporting Signals and Systems coursework example, but it is the weakest of the four assignments as a standalone portfolio item.  
It is still worth keeping if you want a complete, organized academic record.
