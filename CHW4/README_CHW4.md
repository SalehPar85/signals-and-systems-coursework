# Signals and Systems – Computer Assignment 4

This folder contains a MATLAB coursework submission for Signals and Systems (Computer Assignment 4).  
The assignment covers Laplace transforms, closed-loop stability, Z-transforms, inverse Z-transform derivations, and ECG denoising with a notch filter.

## What this project demonstrates

- Laplace-domain modeling of an RLC circuit
- Bode-plot interpretation and resonance behavior
- Closed-loop control-system stability analysis
- Moving-average FIR filter analysis
- Inverse Z-transform using partial fractions
- Time-domain and frequency-domain ECG denoising
- Notch filter design for power-line interference suppression

## Files

- `403101542_CHW4.m` — MATLAB script with all experiments
- `403101542_CHW4.pdf` — written report / submitted solution

## Main experiments in the script

### 1) Laplace transform: RLC circuit and Bode plot
- Models a series RLC circuit
- Computes the transfer function
- Compares Bode responses for different resistance values
- Interprets how damping changes the resonance peak and phase

### 2) Closed-loop control stability
- Analyzes a unity-feedback system
- Uses root-locus and step response analysis
- Compares system behavior for multiple gain values

### 3) Z-transform: moving-average filter
- Derives the transfer function of an N-point moving-average FIR filter
- Plots pole-zero maps
- Compares frequency responses for different filter lengths
- Demonstrates practical noise smoothing

### 4) Inverse Z-transform via partial fractions
- Works with a rational transfer function
- Uses residue-based reasoning and symbolic inverse Z-transform
- Validates the impulse response numerically

### 5) ECG denoising with a notch filter
- Synthesizes a noisy ECG-like signal
- Detects the 50 Hz interference peak in the spectrum
- Designs a digital notch filter using `iirnotch`
- Compares the signal before and after filtering
- Studies the effect of different Q factors on the notch bandwidth

## Requirements

- MATLAB
- Control System Toolbox
- Signal Processing Toolbox
- Symbolic Math Toolbox

## How to run

1. Open `403101542_CHW4.m` in MATLAB.
2. Run the file section by section or all at once.
3. Make sure the required toolboxes are installed.

## Notes

- This is a strong academic assignment because it connects signals, control, and filtering in one workflow.
- The ECG section is especially portfolio-friendly because it shows an applied denoising pipeline.
- Keep the PDF next to the code if you want reviewers to see the derivation and the numerical results together.

## Resume value

Yes. This is one of the best items in the set. It shows both theory and a practical biomedical filtering application.
