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
git checkout 7c1e475940ebf941b788c800685d501d18379c67

pip install .

#########################################################
# 2. CONFIG FILE CONFIGURATION
# Read placeholders and create config file from Environment  
#########################################################

# python3 /odtp/odtp-component-client/parameters.py /odtp/odtp-app/config_templates/template.yml /odtp/odtp-workdir/config.yml

#########################################################
# 3. INPUT FOLDER MANAGEMENT
#########################################################
mkdir data
mkdir data/output

ln -s /odtp/odtp-input/ /odtp/odtp-workdir/mobility-metrics/data/input

#########################################################
# 4. TOOL EXECUTION
# While the output is managed by ODTP and placed in /odtp/odtp-output/
#########################################################

if [ "$METRICS_TYPE" == "BASIC" ]; then
    # Code for BASIC metrics
    echo "Running BASIC metrics"
    python3 /odtp/odtp-workdir/mobility-metrics/mobmetric/scripts/run_metrics.py --metric $BASIC_METRIC_TYPE --method $RADIUS_OF_GYRATION_METHOD

elif [ "$METRICS_TYPE" == "ENTROPY" ]; then
    # Code for ENTROPY metrics
    echo "Running ENTROPY metrics"
    python3 /odtp/odtp-workdir/mobility-metrics/mobmetric/scripts/run_entropy.py

else [ "$METRICS_TYPE" == "MOBILITY_METRICS" ]; then
    # Code for other metrics
    echo "Running other metrics"
    python3 /odtp/odtp-workdir/mobility-metrics/mobmetric/scripts/run_motifs.py

fi

cd /odtp/odtp-workdir/mobility-metrics

#########################################################
# 5. OUTPUT FOLDER MANAGEMENT
# The selected output files generated should be placed in the output folder
#########################################################

cp -r /odtp/odtp-workdir/mobility-metrics/data/output* /odtp/odtp-output

############################################################################################
# END OF MANUAL USER APP
############################################################################################
