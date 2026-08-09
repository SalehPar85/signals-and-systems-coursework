# Signals and Systems – Computer Assignment 5

This folder contains a MATLAB coursework submission for Signals and Systems (Computer Assignment 5).  
The assignment focuses on sampling theory, aliasing, reconstruction, zero-order hold behavior, and anti-aliasing filtering.

## What this project demonstrates

- Ideal sampling and sinc reconstruction
- Nyquist-rate reasoning and reconstruction error comparison
- Aliasing in the frequency domain
- Practical reconstruction with zero-order hold
- Digital filtering after sampling
- Anti-aliasing filtering before sampling

## Files

- `403101542_CHW5.m` — MATLAB script with all experiments
- `403101542_CHW5.pdf` — written report / submitted solution

## Main experiments in the script

### 1) Ideal sampling and sinc reconstruction
- Samples a continuous-time signal at multiple sampling rates
- Reconstructs the signal with ideal sinc interpolation
- Compares the results using mean-squared error

### 2) Aliasing in the frequency domain
- Shows how the spectrum changes when sampling below the Nyquist rate
- Compares correct sampling with aliasing-free sampling
- Demonstrates how higher-frequency components fold into lower frequencies

### 3) Practical sampling with zero-order hold
- Compares the original signal, sampled points, ZOH reconstruction, and ideal sinc reconstruction
- Quantifies reconstruction quality with error metrics
- Highlights the practical difference between ideal and hardware-friendly reconstruction

### 4) Sampling, digital processing, and reconstruction
- Adds noise to a continuous-time signal
- Samples the noisy signal
- Applies moving-average digital filters of different lengths
- Reconstructs the filtered sequence back to continuous time

### 5) Anti-aliasing before sampling
- Demonstrates how a high-frequency component aliases when sampled directly
- Applies a pre-sampling low-pass filter
- Compares the spectrum before and after anti-aliasing

## Requirements

- MATLAB
- Signal Processing Toolbox for filtering and spectral analysis

## How to run

1. Open `403101542_CHW5.m` in MATLAB.
2. Run the file section by section or all at once.
3. Review the figures and printed error values.

## Notes

- This assignment is conceptually important because it covers the full sampling chain from analog signal to digital processing and back.
- It is slightly more presentation-friendly than a plain worksheet because it includes reconstruction plots and anti-aliasing comparison figures.
- Keep the PDF with the code so the derivations and the visual results remain together.

## Resume value

Yes. This is a good academic artifact, especially when grouped with the other Signals and Systems assignments. It is stronger than a simple exercise sheet because it shows sampling, aliasing, and reconstruction end-to-end.
