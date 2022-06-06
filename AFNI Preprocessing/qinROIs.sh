## Qin ROIs

3dresample -master yourfmridata.nii \
-prefix MNI_Glasser_HCP_v1.0_LPI_2009c_resampled.nii.gz -input MNI_Glasser_HCP_v1.0_LPI_2009c.nii.gz 

### Qin-Northoff (2020): Interoceptive

a=34; b=14; c=12
3dcalc \
-a MNI_Glasser_HCP_v1.0_LPI_2009c_resampled.nii.gz \
-expr "step(64-(x+$a)*(x+$a)-(y+$b)*(y+$b)-(z-$c)*(z-$c))" \
-prefix QinInt_RIns.nii

a=-40; b=-2; c=2
3dcalc \
-a MNI_Glasser_HCP_v1.0_LPI_2009c_resampled.nii.gz \
-expr "step(64-(x+$a)*(x+$a)-(y+$b)*(y+$b)-(z-$c)*(z-$c))" \
-prefix QinInt_LIns1.nii

a=-36; b=24; c=4
3dcalc \
-a MNI_Glasser_HCP_v1.0_LPI_2009c_resampled.nii.gz \
-expr "step(64-(x+$a)*(x+$a)-(y+$b)*(y+$b)-(z-$c)*(z-$c))" \
-prefix QinInt_LIns2.nii

### Qin-Northoff (2020): Exteroceptive

a=50; b=8; c=26
3dcalc \
-a MNI_Glasser_HCP_v1.0_LPI_2009c_resampled.nii.gz \
-expr "step(64-(x+$a)*(x+$a)-(y+$b)*(y+$b)-(z-$c)*(z-$c))" \
-prefix QinExt_PMC.nii

a=-6; b=60; c=22
3dcalc \
-a MNI_Glasser_HCP_v1.0_LPI_2009c_resampled.nii.gz \
-expr "step(64-(x+$a)*(x+$a)-(y+$b)*(y+$b)-(z-$c)*(z-$c))" \
-prefix QinExt_MPFC.nii

a=-48; b=-38; c=36
3dcalc \
-a MNI_Glasser_HCP_v1.0_LPI_2009c_resampled.nii.gz \
-expr "step(64-(x+$a)*(x+$a)-(y+$b)*(y+$b)-(z-$c)*(z-$c))" \
-prefix QinExt_TPJ.nii

### Qin-Northoff (2020): Mental

a=-6; b=48; c=0
3dcalc \
-a MNI_Glasser_HCP_v1.0_LPI_2009c_resampled.nii.gz \
-expr "step(64-(x+$a)*(x+$a)-(y+$b)*(y+$b)-(z-$c)*(z-$c))" \
-prefix QinMent_PACC.nii

a=-4; b=-54; c=28
3dcalc \
-a MNI_Glasser_HCP_v1.0_LPI_2009c_resampled.nii.gz \
-expr "step(64-(x+$a)*(x+$a)-(y+$b)*(y+$b)-(z-$c)*(z-$c))" \
-prefix QinMent_PCC.nii