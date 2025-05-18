# vortex-detection

A collection of vortex detection and visualization tools for 2D velocity fields of liquid crystals, implemented in MATLAB. This project focuses on identifying disclinations and analyzing flow structures using physical and mathematical criteria.

---

## 📌 Overview

Liquid crystals, particularly active nematics, often exhibit topological defects and complex vortex dynamics. This repository provides tools for:

- Computing the Q-field (from gradients of the velocity field)
- Detecting disclinations using angular winding methods
- Visualizing velocity streamlines and disclination positions
- Saving high-resolution plots for presentation or publication

---

## 📁 Directory Structure

```
vortex-detection/
├── active_nematic_velocity_*.dat   # Input data files (time-stamped)
├── plot_disclinations.m            # Main MATLAB script for vortex and defect visualization
├── figures/                        # Output directory for saved PNGs
└── README.md                       # Project documentation (this file)
```

---

## 📊 Data Format

Each `.dat` file should follow the structure:
```
i    j    density    ux    uy
```
Where:
- `i, j`: Spatial grid indices (0-based)
- `density`: Optional, not used in current visualizations
- `ux, uy`: Velocity components in the x and y directions

In MATLAB, we adjust for 1-based indexing by adding 1 to `i` and `j`.

---

## 🧠 Disclination Detection Algorithm

This project identifies disclinations based on **angular winding** of velocity vectors:

1. For each 2×2 cell:
   - Compute angle θ = `atan2(uy, ux)` at each corner
   - Measure net angular rotation around the cell
   - Threshold:
     - Winding > +π → +1/2 disclination
     - Winding < −π → −1/2 disclination

This method captures rotational defects characteristic of topological transitions in nematic or cholesteric materials.

---

## 🎨 Visualization

The output plots include:

- **Streamlines** of the velocity field (light gray)
- **Disclinations**:
  - 🔴 Red dots for +1/2
  - 🔵 Blue dots for −1/2
- Optional: Magnitude contours or quiver plots can be added

Example usage:
```matlab
plot_disclinations('active_nematic_velocity_700.dat');
```

Result: `disclinations_t700.png` saved in `figures/`.

---

## ⚙️ Features

- ✅ High-resolution export (`exportgraphics`)
- ✅ Supports multiple time steps
- 🔜 Planned: Q-tensor-based detection
- 🔜 Planned: GUI for parameter tweaking

---

## 🧰 Requirements

- MATLAB (R2018a or newer recommended)
- No additional toolboxes required

---

## 📬 Contact

If you have questions, suggestions, or want to contribute, feel free to reach out or open an issue.

---


### 📚 References

1. Giomi, L., Bowick, M. J., Ma, X., & Marchetti, M. C. (2013). *Defect annihilation and proliferation in active nematics*. Physical Review Letters, 110(22), 228101. https://doi.org/10.1103/PhysRevLett.110.228101

2. Thampi, S. P., Golestanian, R., & Yeomans, J. M. (2014). *Vorticity, defects and correlations in active turbulence*. Philosophical Transactions of the Royal Society A, 372(2029), 20130366. https://doi.org/10.1098/rsta.2013.0366


### 📖 Citation
If you use or adapt this code for a publication, please cite appropriately or credit this GitHub repository.
Morawo, I. (2025). vortex-detection: Tools for identifying and visualizing disclinations in 2D liquid crystal flows (Version 1.0) [Software]. https://github.com/DevCalculus/vortex-detection

---

© 2025 vortex-detection contributors. All rights reserved.
