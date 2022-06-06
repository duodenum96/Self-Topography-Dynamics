# Hierarchy-of-Self
Functions and example scripts for the paper The intrinsic Hierarchy of Self – Converging Topography and Dynamics

# Step by step
1 - AFNI Preprocessing\
  example_preprocessing.sh: For @SSWarper and afni_proc.py\
  qinROIs.sh: Create ROI masks. Uses the Glasser atlas which is also in this folder\
  extract_data.sh: Extract time series from those masks.\
  example_interpolation.m: Linearly interpolate censored time points\
  \
2 - Dynamic Measures\
  Then calculate various measures from extracted data. See examples on examples.m
  
I didn't cover the network analysis here. That can easily be done using the bootnet package: https://cran.r-project.org/web/packages/bootnet/index.html
