# ODTP Mobility Metrics

>Evaluate mobility behavior using mobility metrics

| Tool Info | Links |
| --- | --- |
| Original Tool | [https://github.com/irmlma/mobility-metrics](https://github.com/irmlma/mobility-metrics) |
| Current Tool Version  | [7c1e475940ebf941b788c800685d501d18379c67](https://github.com/irmlma/mobility-metrics/commit/7c1e475940ebf941b788c800685d501d18379c67) |


## ODTP command 

```
odtp new component \
--name odtp-mobility-metrics \
--component-version v0.0.3 \
--repository https://github.com/irmlma/mobility-metrics
``` 

## Data sheet

### Parameters

### Parameters

| Parameter                 | Description                                                                                                       | Default Value | Options                                |
|---------------------------|-------------------------------------------------------------------------------------------------------------------|---------------|----------------------------------------|
| DATASET                   | CSV input filename without format (`.csv`) | dtepr            | Any string                 |
| ALL_BASIC_METRICS              | Set to TRUE in order to run all combinations of basic metrics available                                                                                  | FALSE         | TRUE, FALSE       |
| METRICS_TYPE              | Type of metrics to be calculated                                                                                  | BASIC         | BASIC, ENTROPY, MOBILITY_METRICS       |
| BASIC_METRIC_TYPE         | Type of basic metrics to be calculated: Location visitation frequency, Radius of gyration, Jump length, Wait time | rg            | rg, locf, jump, wait                   |
| RADIUS_OF_GYRATION_METHOD | Radius of gyration method: 'count' calculates with visitation frequency, 'duration' calculates with activity duration | duration            | duration, count                        |

### Data Inputs

| File/Folder | Type | Path       | Description                         | Parameter |
|-------------|------|------------|-------------------------------------|-----------|
| dtepr.csv   | csv  | dtepr.csv  | Output from odtp-mobility-simulation. The filename can be modified in DATASET parameter | null      |

### Data Output

Disclaimer: To complete.

| File/Folder | Type | Path   | Description                       | Parameter |
|-------------|------|--------|-----------------------------------|-----------|
| rg.png      | png  | rg.png | Output from basic metrics > rg    | null      |
| ...      | ...  | ... | ...    | ...      |


## Tutorial

### How to run this component as docker

1. Create an input folder containing: `dtepr.csv`

2. Create an empty output folder called `odtp-output`.

3. Build the dockerfile 

```
docker build -t odtp-mobility-metrics .
```

4. Run the following command. Mount the correct volumes for input/output folders. 

```
docker run -it --rm \
-v {PATH_TO_YOUR_INPUT_VOLUME}:/odtp/odtp-input \
-v {PATH_TO_YOUR_OUTPUT_VOLUME}:/odtp/odtp-output \
--env-file .env odtp-mobility-metrics
```

docker run -it --rm -v ${pwd}/odtp-input:/odtp/odtp-input -v ${pwd}/odtp-output:/odtp/odtp-output --env-file .env odtp-mobility-metrics

## Changelog

- v0.0.3
    - Updated component client to v0.1.2
    - Github actions for docker building
    - Fix on windows build

- v0.0.2
    - Update to mobility-metrics `0.0.1`
    - Bugs corrected on `app.sh`
    - Added option to run all metrics

- v0.0.1
    - Initial release

## Developed by

SDSC & CSFM