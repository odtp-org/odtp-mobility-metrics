#!/bin/bash

############################################################################################
# START OF MANUAL CONFIGURATION. 
# ADAPT THE TEMPLATE HERE.
############################################################################################

#########################################################
# 1. GITHUB CLONING OF REPO
# Clone the repository of your tool and checkout to one specific commit. 
#########################################################

git clone https://github.com/irmlma/mobility-metrics.git /odtp/odtp-workdir/mobility-metrics
cd /odtp/odtp-workdir/mobility-metrics
git checkout aebeb821f685eea3d49e3ce2c800627f73488c43

pip install .

#########################################################
# 2. CONFIG FILE CONFIGURATION
# Read placeholders and create config file from Environment  
#########################################################

# python3 /odtp/odtp-component-client/parameters.py /odtp/odtp-app/config_templates/template.yml /odtp/odtp-workdir/config.yml

#########################################################
# 3. INPUT FOLDER MANAGEMENT
#########################################################
mkdir /odtp/odtp-workdir/mobility-metrics/data
mkdir /odtp/odtp-workdir/mobility-metrics/data/output

ln -s /odtp/odtp-input/ /odtp/odtp-workdir/mobility-metrics/data/input

#########################################################
# 4. TOOL EXECUTION
# While the output is managed by ODTP and placed in /odtp/odtp-output/
#########################################################

if [ "$METRICS_TYPE" == "BASIC" ]; then
    # Code for BASIC metrics
    echo "Running BASIC metrics"
    python3 /odtp/odtp-workdir/mobility-metrics/mobmetric/scripts/run_metrics.py $BASIC_METRIC $BASIC_RADIUS_OF_GYRATION_METHOD $DATASET

elif [ "$METRICS_TYPE" == "ENTROPY" ]; then
    # Code for ENTROPY metrics
    echo "Running ENTROPY metrics"
    python3 /odtp/odtp-workdir/mobility-metrics/mobmetric/scripts/run_entropy.py

elif [ "$METRICS_TYPE" == "MOBILITY_METRICS" ]; then
    # Code for other metrics
    echo "Running other metrics"
    python3 /odtp/odtp-workdir/mobility-metrics/mobmetric/scripts/run_motifs.py

fi


if [ "$ALL_BASIC_METRICS" == "TRUE" ]; then
    # Code for BASIC metrics
    echo "Running ALL BASIC metrics"

    for BASIC_METRIC in duration count; do
        for BASIC_RADIUS_OF_GYRATION_METHOD in  rg locf jump wait; do
        echo "Running $BASIC_METRIC metric & $BASIC_RADIUS_OF_GYRATION_METHOD method"
        python3 /odtp/odtp-workdir/mobility-metrics/mobmetric/scripts/run_metrics.py $BASIC_METRIC $BASIC_RADIUS_OF_GYRATION_METHOD $DATASET

        mv /odtp/odtp-workdir/mobility-metrics/data/output/${BASIC_RADIUS_OF_GYRATION_METHOD}.png /odtp/odtp-workdir/mobility-metrics/data/output/basic_${BASIC_METRIC}_${BASIC_RADIUS_OF_GYRATION_METHOD}.png
        done
    done
fi



#########################################################
# 5. OUTPUT FOLDER MANAGEMENT
# The selected output files generated should be placed in the output folder
#########################################################

cp -r /odtp/odtp-workdir/mobility-metrics/data/output/* /odtp/odtp-output

############################################################################################
# END OF MANUAL USER APP
############################################################################################
