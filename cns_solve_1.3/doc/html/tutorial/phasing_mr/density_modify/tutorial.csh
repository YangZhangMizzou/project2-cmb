#!/bin/csh -f
#
# tutorial script for CNSsolve
#
# written by: Paul Adams
# copyright Yale University
#
set tutdir='doc/html/tutorial'
set lnfiles=(data/mbp/rigid.pdb \
	     data/mbp/mbp_mr.hkl \
	     data/mbp/mbp_mr.cv \
	     phasing_mr/density_modify/omac \
             phasing_mr/density_modify/model_phase.inp \
	     phasing_mr/density_modify/density_modify.inp \
	     phasing_mr/density_modify/fourier_map.inp)
#
if ( ! $?CNS_SOLVE ) then
  echo "CNS_SOLVE not defined"
  echo "CNS must be correctly setup to running this tutorial script"
  exit 1
endif
#
if ( ! -d $CNS_SOLVE/$tutdir ) then
  echo "cannot find tutorial directory $CNS_SOLVE/$tutdir"
  echo "please check that you are using the correct version of CNS"
  exit 1
endif
#
foreach file ( $lnfiles )
  if ( ! -e {$file}:t ) then
    echo "linking $tutdir/$file to current directory"
    ln -s $CNS_SOLVE/$tutdir/$file .
  endif
end
#
echo "        "
echo "running:"
echo "         cns_solve < model_phase.inp > model_phase.out"
echo "        "
#
cns_solve < model_phase.inp > model_phase.out
#
echo "        "
echo "running:"
echo "         cns_solve < density_modify.inp > density_modify.out"
echo "        "
#
cns_solve < density_modify.inp > density_modify.out
#
echo "        "
echo "running:"
echo "         cns_solve < fourier_map.inp > fourier_map.out"
echo "        "
#
cns_solve < fourier_map.inp > fourier_map.out
#
echo "        "
#