#!/bin/bash
#SBATCH --partition=hpc          # partition (queue)
#SBATCH --nodes=1                # number of nodes
#SBATCH --ntasks-per-node=32     # number of cores per node
#SBATCH --mem=160G               # memory per node in MB (different units with suffix K|M|G|T)
#SBATCH --time=72:00:00          # total runtime of job allocation (format D-HH:MM:SS; first parts optional)
#SBATCH --output=slurm.%j.out    # filename for STDOUT (%N: nodename, %j: job-ID)
#SBATCH --error=slurm.%j.err     # filename for STDERR
#SBATCH --export=ALL
#SBATCH --exclusive

startFile="start.signal"
doneFile="done.signal"
stopFile="stop.signal"

while true
sleep 1s
do

if [ -f "$stopFile" ]
then
	echo "$stopFile found, ending caseRunner."
	break;
fi

if [ -f "$startFile" ]
	then
	echo "$startFile found: starting OpenFOAM case."
	rm $startFile
	./Allclean
	./Allrun
	touch $doneFile
	else
	echo -n "Waiting for $startFile..."
fi

done

