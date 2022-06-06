for i in QinInt_LIns1 QinInt_LIns2 QinInt_RIns QinExt_MPFC QinExt_PMC \
QinExt_TPJ QinMent_PACC QinMent_PCC
do
masks+=("$i")
done

for mask in "${masks[@]}"
do
3dmaskave -quiet -mask $mask.nii \
yourfmridata.nii>yourfmridata_$mask.txt
done

# After data extraction is done, interpolate censored time points. See the funciton in interpolate.m and an example in example_interpolation.m