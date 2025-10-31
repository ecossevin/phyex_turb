for f in \
    main_turb.F90                   \
    mode_bl89.F90                   \
    mode_emoist.F90                 \
    mode_etheta.F90                 \
    mode_prandtl.F90                \
    mode_shuman_phy.F90             \
    mode_tke_eps_sources.F90        \
    mode_tridiag_thermo.F90         \
    mode_tridiag_tke.F90            \
    mode_tridiag_wind.F90           \
    mode_turb_ver.F90               \
    mode_turb_ver_dyn_flux.F90      \
    mode_turb_ver_thermo_corr.F90   \
    mode_turb_ver_thermo_flux.F90   
do
    echo "==> $f <=="
    python3 add_acdc.py $f
done
