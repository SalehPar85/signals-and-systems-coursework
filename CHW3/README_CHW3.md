# Signals and Systems – Computer Assignment 3

This folder contains a MATLAB coursework submission for Signals and Systems (Computer Assignment 3).  
The assignment focuses on DFT implementation, spectral analysis, convolution, DTMF synthesis, and 2D frequency-domain image processing.

## What this project demonstrates

- Custom DFT implementations from scratch
- Computational complexity comparison against MATLAB `fft`
- Frequency resolution, zero-padding, and spectral leakage
- Linear vs. circular convolution and aliasing
- DTMF signal synthesis and spectral inspection
- 2D DFT visualization
- Periodic noise removal using a 2D notch filter

## Files

- `403101542_CHW3.m` — MATLAB script with all experiments and helper functions
- `403101542_CHW3.pdf` — written report / submitted solution

## Main experiments in the script

### 1) Custom DFT implementation
- `myDFTLoop(x)` computes the DFT using nested loops
- `myDFTMatrix(x)` computes the DFT using matrix-vector multiplication
- Both implementations are compared against MATLAB `fft`
- Execution time is measured for multiple sequence lengths

### 2) Frequency resolution and spectral leakage
- Compares short and long observation windows
- Demonstrates the effect of zero-padding
- Compares rectangular, Hann, and Hamming windows
- Shows how leakage changes the spectrum of non-bin-centered tones

### 3) Linear and circular convolution
- Compares direct linear convolution with circular convolution
- Shows aliasing when the circular length is too short
- Verifies that a sufficiently large FFT length removes the overlap

### 4) DTMF synthesis
- Generates a DTMF tone for a keypad digit
- Inspects the frequency-domain peaks to verify the row/column frequencies

### 5) Two-dimensional DFT and image filtering
- Visualizes the spectrum of simple 2D binary patterns
- Corrupts an image with periodic sinusoidal noise
- Applies a centered 2D notch filter in the frequency domain
- Reconstructs the denoised image with inverse 2D FFT

## Requirements

- MATLAB
- Signal Processing Toolbox
- Image Processing Toolbox for `imread`, `rgb2gray`, `imshow`, and `imresize`
- The sample image `peppers.png` must be available in the MATLAB path

## How to run

1. Open `403101542_CHW3.m` in MATLAB.
2. Ensure `peppers.png` is accessible to MATLAB.
3. Run the file. The helper functions are defined at the end of the script.

## Notes

- This assignment is stronger than a typical plotting exercise because it includes custom DFT code and image-domain frequency filtering.
- It is a good portfolio item for showing numerical thinking, signal analysis, and MATLAB implementation quality.
- Keep the report PDF with the script so reviewers can connect the code to the written analysis.

## Resume value

Yes. This is one of the strongest items from the Signals and Systems set because it combines theory, implementation, performance comparison, and 2D image processing.
