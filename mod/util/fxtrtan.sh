fxtran_prefix=/home/gmap/mrpm/cossevine/fxtran-acdc/bin
export PATH=/home/gmap/mrpm/marguina/bin:/home/gmap/mrpm/marguina/bin/vimpack.d:$fxtran_prefix:$PATH
$fxtran_prefix/fxtran-f90 --dryrun --method methods --methods save,load,copy,wipe -- f90 --dir tmp -c /home/gmap/mrpm/cossevine/tmp/mod/modd/modd_dimphyexn.F90
$fxtran_prefix/fxtran-f90 --dryrun --method methods --methods save,load,copy,wipe -- f90 --dir tmp -c /home/gmap/mrpm/cossevine/tmp/mod/modd/modd_cst.F90
$fxtran_prefix/fxtran-f90 --dryrun --method methods --methods save,load,copy,wipe -- f90 --dir tmp -c /home/gmap/mrpm/cossevine/tmp/mod/modd/modd_les.F90
$fxtran_prefix/fxtran-f90 --dryrun --method methods --methods save,load,copy,wipe -- f90 --dir tmp -c /home/gmap/mrpm/cossevine/tmp/mod/modd/modd_cturb.F90
$fxtran_prefix/fxtran-f90 --dryrun --method methods --methods save,load,copy,wipe -- f90 --dir tmp -c /home/gmap/mrpm/cossevine/tmp/mod/modd/modd_budget.F90
$fxtran_prefix/fxtran-f90 --dryrun --method methods --methods save,load,copy,wipe -- f90 --dir tmp -c /home/gmap/mrpm/cossevine/tmp/mod/modd/modd_nebn.F90
$fxtran_prefix/fxtran-f90 --dryrun --method methods --methods save,load,copy,wipe -- f90 --dir tmp -c /home/gmap/mrpm/cossevine/tmp/mod/modd/util
$fxtran_prefix/fxtran-f90 --dryrun --method methods --methods save,load,copy,wipe -- f90 --dir tmp -c /home/gmap/mrpm/cossevine/tmp/mod/modd/modd_turbn.F90
$fxtran_prefix/fxtran-f90 --dryrun --method methods --methods save,load,copy,wipe -- f90 --dir tmp -c /home/gmap/mrpm/cossevine/tmp/mod/modd/modd_io.F90
