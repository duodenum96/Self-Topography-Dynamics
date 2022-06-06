## Example Preprocessing Script
# Initialize
btemplate=MNI152_2009_template_SSW.nii.gz
tpath=`@FindAfniDsetPath ${btemplate}`
subjpath=/example_subjpath
anatpath=$subjpath/*t1*
subj=sub_x
run=rest.nii # Can also be task etc.


# Run @SSwarper for skullstripping + Nonlinear alignment
cd $anatpath

@SSwarper -input *t1*.nii \
-subid $subj \
-odir anat_warped \
-base MNI152_2009_template_SSW.nii.gz \
-giant_move


# Run afni_proc
afni_proc.py -subj_id $subj \
-script proc.$subj \
-scr_overwrite \
-out_dir $subj \
-blocks despike tshift align tlrc volreg mask blur scale regress \
-copy_anat $subjpath/anat_warped/anatSS.$subj.nii \
-anat_has_skull no \
-dsets \
$run \
-tcat_remove_first_trs 5 \
-align_opts_aea -cost lpc+ZZ \
-volreg_align_to MIN_OUTLIER \
-volreg_align_e2a \
-volreg_tlrc_warp -tlrc_base $tpath/$btemplate \
-tlrc_NL_warp \
-tlrc_NL_warped_dsets \
$subjpath/anat_warped/anatQQ.$subj.nii \
$subjpath/anat_warped/anatQQ.$subj.aff12.1D \
$subjpath/anat_warped/anatQQ.${subj}_WARP.nii \
-volreg_warp_dxyz 3 \
-mask_apply group \
-volreg_post_vr_allin yes \
-mask_segment_anat yes \
-volreg_pvra_base_index MIN_OUTLIER \
-mask_epi_anat yes \
-mask_apply group \
-mask_segment_erode yes \
-regress_motion_per_run \
-regress_anaticor_fast \
-regress_ROI WMe CSFe \
-regress_apply_mot_types demean deriv \
-regress_est_blur_epits \
-regress_est_blur_errts \
-regress_run_clustsim no \
-regress_bandpass 0.01 0.2 \
-volreg_warp_dxyz 3 \
-regress_censor_motion 0.2 \
-regress_censor_outliers 0.05 \
-html_review_style pythonic
done

# After preprocessing is done, interpolate censored time points. See an example in interpolate.m and example_interpolation.m