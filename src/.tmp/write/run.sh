for f in \
    mode_etheta.F90               \
    mode_gradient_u_phy.F90       \
    mode_gradient_v_phy.F90       \
    mode_gradient_w_phy.F90       \
    mode_gradient_m_phy.F90       \
    mode_ibm_mixinglength.F90     \
    mode_sbl_phy.F90              \
    mode_sources_neg_correct.F90  \
    mode_update_iiju_phy.F90      \
    mode_tridiag_tke.F90          \
    mode_mppdb.F90                \
    mode_tools.F90                \
    mode_prandtl.F90              \
    mode_tridiag_wind.F90         \
    mode_tridiag_thermo.F90       \
    mode_bl89.F90                 \
    mode_io_field_write_phy.F90   \
    mode_shuman_phy.F90           \
    mode_tke_eps_sources.F90      \
    mode_turb_ver_thermo_corr.F90 \
    mode_turb_ver_thermo_flux.F90 \
    mode_turb_ver_sv_corr.F90     \
    mode_turb_ver.F90             \
    mode_turb_ver_dyn_flux.F90    \
    mode_emoist.F90               
do

    echo "==> $f <=="
    python3 add_write.py $f

done
