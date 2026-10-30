# A Practical Guide to Control Theory

[中文 README](./README_zh.md)

---

## What Is This?

This repository is a practical control-theory note aimed at real robotics engineering work.
It is written around one core goal: helping you design, tune, and debug controllers on real hardware.

Rather than treating theory and application separately, the notes continuously answer:
**"What is this useful for when the robot is actually running?"**

## Who Is This For?

Undergraduate students (roughly year 1-3) with basic calculus and linear algebra.
If you can follow derivatives and matrix multiplication, you are ready.

## Table of Contents

### Part I: Foundations
| # | Chapter | Key Topics |
|---|---------|------------|
| - | **Two Numbers: $e$ and $\pi$** | Why $\pi$ governs periodicity and $e$ governs decay; Euler's formula |
| 1 | **Introduction** | Motivation, learning path, how to use this guide |

### Part II: Theory Pipeline
| # | Chapter | Key Topics |
|---|---------|------------|
| 2 | **Digital Signal Processing** | Laplace/Fourier/Z-transforms, poles & zeros, LPF/BPF/HPF/notch filters |
| 3 | **System Description** | Transfer functions, state-space, stability, 2nd-order systems, motor modeling |
| 4 | **Classical Control** | Bode plots, PID (single/cascade/parallel), positive-feedback diagnosis, tuning, feedforward, sysid |
| 5 | **Discretization & Implementation** | ZOH, Tustin, FIR/IIR filter design, fixed-point, embedded implementation |
| 6 | **Modern Control** | LQR (+ PID-as-state-space insight), MPC, NMPC, TinyMPC, Kalman/EKF, LQG, trajectory planning |
| 7 | **Nonlinear Control** | Feedback linearization, sliding mode, gain scheduling, Lyapunov design, NMPC comparison |

### Part III: Practice
| # | Chapter | Key Topics |
|---|---------|------------|
| 8 | **Multi-Loop Architecture** | Full control stack, cascade architecture, bandwidth separation, state machines, RTOS |
| 9 | **Debugging & Tuning Cookbook** | Diagnostic flowcharts, failure mode signatures, PID tuning on real hardware |

### Part IV: Frontiers & Reference
| # | Chapter | Key Topics |
|---|---------|------------|
| 10 | **Outlook** | Data-driven control, Koopman, adaptive control, RL, diffusion policies, VLAs, neural ODEs |
| A | **Appendix: C++ Modules** | Header-only, embedded-friendly algorithm modules |
| B | **Appendix: Attitude & Rotation** | Coordinate frames (NWU), rotation matrices, Euler angles, gimbal lock, quaternions |

## Structure

The notes follow an engineering workflow: theory first (uninterrupted from DSP through nonlinear control), then practical chapters on architecture and debugging, then frontier topics and reference appendices.

## Project Structure

```text
Control-Note/
├─ main.tex                  # English main document
├─ main_zh.tex               # Chinese main document
├─ sections_zh/              # Chinese chapter source files
├─ include/                  # Shared include resources
├─ figures/                  # English figures
├─ figures_zh/               # Chinese figures
├─ scripts/                  # Figure generation scripts
├─ build/                    # Built PDF outputs
├─ README.md                 # English README
└─ README_zh.md              # Chinese README
```

## How to Build

### Overleaf

Import this repository and compile with **XeLaTeX**.

### Local Build (Recommended)

A build script is provided for local compilation. Prerequisites:

1. **Install TeX Live** (user-space, no sudo required):
   ```bash
   # Download the installer
   cd /tmp && wget https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
   tar xzf install-tl-unx.tar.gz && cd install-tl-*/

   # Run the installer (choose "small" scheme to save space)
   perl install-tl

   # After installation, add TeX Live to your PATH (adjust the year as needed)
   echo 'export PATH="$HOME/texlive/2026/bin/x86_64-linux:$PATH"' >> ~/.bashrc
   source ~/.bashrc

   # Install required packages
   tlmgr install latexmk ctex mdframed zref needspace booktabs enumitem float caption
   ```

2. **Build PDFs** using the provided script:
   ```bash
   # Build both English and Chinese PDFs
   ./scripts/build.sh all

   # Build English only
   ./scripts/build.sh en

   # Build Chinese only
   ./scripts/build.sh zh

   # Clean auxiliary files
   ./scripts/build.sh clean
   ```

   Output files:
   - `build/Control_Theory_Note.pdf` (English)
   - `build/Control_Theory_Note_cn.pdf` (Chinese)

### Manual Build

If you prefer to compile manually:

```bash
# English (pdflatex)
latexmk -pdf -interaction=nonstopmode main.tex

# Chinese (xelatex)
latexmk -xelatex -interaction=nonstopmode main_zh.tex
```

## Regenerate Figures

```bash
pip install matplotlib numpy
python scripts/generate_figures_zh.py
python scripts/generate_advanced_figures_zh.py
```

See `scripts/` for the complete list of figure generation scripts.

## Contributing

Issues and pull requests are welcome for typo fixes, technical corrections, and structural improvements.
