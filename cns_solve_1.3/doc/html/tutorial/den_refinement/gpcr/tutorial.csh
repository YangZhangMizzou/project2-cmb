#!/bin/csh -f
#
# tutorial script for CNSsolve
#
# written by: Paul Adams
# copyright Yale University
#
set tutdir='doc/html/tutorial'
set lnfiles=(data/gpcr/final-refine-cns.hkl \
             data/gpcr/gpcr-den_phaser.1.pdb \
             den_refinement/gpcr/refine_den.inp)
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
echo "         cns_solve < refine_den.inp > refine_den.out"
echo "        "
#
cns_solve < refine_den.inp > refine_den.out
#
echo "        "
#
