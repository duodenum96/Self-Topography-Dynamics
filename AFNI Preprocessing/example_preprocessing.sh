## Example Preprocessing Script
# Initialize
btemplate=MNI152_2009_template_SSW.nii.gz
tpath=`@FindAfniDsetPath ${btemplate}`
subjpath=/example_subjpath
anatpath=$subjpath/*t1*
subj=sub_x
run=rest.nii # Can also be task etc.
fspath=$subjpath/fs # Path to output freesurfer

# Run Freesurfer

cd $anatpath

recon-all \
-all \
-3T \
-sd $fspath \
-subjid $subj \
-i *t1*.nii \
-parallel \
-openmp 16

# AFNI-ize

cd $fspath/$subj/surf
@SUMA_Make_Spec_FS -sid $subj -NIFTI
sumapath=$fspath/$subj/surf/SUMA

# Run @SSwarper for skullstripping + Nonlinear alignment
cd $anatpath

@SSwarper -input *t1*.nii \
-subid $subj \
-odir anat_warped \
-base MNI152_2009_template_SSW.nii.gz \
-giant_move


# Run afni_proc
afni_proc.py \
-subj_id $subj \
-blocks despike tshift align tlrc volreg mask blur scale regress \
-copy_anat $anatpath/anat_warped/anatSS.$subj.nii \
-anat_has_skull no \
-scr_overwrite \
-out_dir ${subj}_out \
-script proc_${subj} \
-anat_follower anat_w_skull anat $anatpath/anat_warped/anatU.$subj.nii \
-anat_follower_ROI aaseg anat $sumapath/aparc.a2009s+aseg.nii.gz \
-anat_follower_ROI aeseg epi $sumapath/aparc.a2009s+aseg.nii.gz \
-anat_follower_ROI fsvent epi $sumapath/fs_ap_latvent.nii.gz \
-anat_follower_ROI fswm epi $sumapath/fs_ap_wm.nii.gz \
-anat_follower_erode fsvent fswm \
-dsets $subjpath/$run \
-tcat_remove_first_trs 5 \
-align_opts_aea -cost lpc+ZZ \
-tlrc_base $tpath/$btemplate \
-tlrc_NL_warp \
-tlrc_NL_warped_dsets \
$anatpath/anat_warped/anatQQ.$subj.nii* \
$anatpath/anat_warped/anatQQ.$subj.aff12.1D \
$anatpath/anat_warped/anatQQ.${subj}_WARP.nii* \
-volreg_align_to MIN_OUTLIER \
-volreg_post_vr_allin yes \
-volreg_pvra_base_index MIN_OUTLIER \
-volreg_align_e2a \
-volreg_tlrc_warp \
-mask_epi_anat yes \
-mask_apply group \
-mask_segment_anat yes \
-regress_motion_per_run \
-regress_ROI_PC fsvent 3 \
-regress_ROI_PC fswm 3 \
-regress_ROI_PC_per_run fsvent fswm \
-regress_anaticor_fast \
-regress_anaticor_label fswm \
-regress_apply_mot_types demean deriv \
-regress_est_blur_epits \
-regress_est_blur_errts \
-regress_run_clustsim no \
-regress_bandpass 0.01 0.2 \
-volreg_warp_dxyz 3 \
-regress_censor_motion 0.2 \
-regress_censor_outliers 0.05

# After preprocessing is done, interpolate censored time points. See an example in interpolate.m and example_interpolation.m
