mkdir ESpresso

for logfile in $(find ESpresso/ | grep "log_")
do
    rm $logfile
done

bsub -R "rusage[mem=5000]" -n 1 -e "ESpresso/log_real.err" -o "ESpresso/log_real.out" R CMD BATCH --no-save analyze_real.R
bsub -R "rusage[mem=5000]" -n 1 -e "ESpresso/log_scramble.err" -o "ESpresso/log_scramble.out" R CMD BATCH --no-save scramble_real.R
bsub -R "rusage[mem=5000]" -n 1 -e "ESpresso/log_bulk.err" -o "ESpresso/log_bulk.out" R CMD BATCH --no-save bulk_ESpresso.R

# Results aren't under version control, so they need to be pulled down manually:
# rsync -azv cruk:lustre/PlateEffects/realdata/ESpresso/ ESpresso/

