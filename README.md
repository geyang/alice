<img src="figures/mad-hatter.png" align="right" width="200px"/>

# Alice, real-time piping console outputs to the web

## Examples

```bash
python train_lstm.py | alice --path $USER/$JOB_ID
```

now on [https://alice.io/username/job_id](), you will be able to see the console at real time.

## Installation

I am currently waiting for the `pypi` package name `alice`. 

```bash
pip install alice
```

before then, you can install directly from this git repo

```bash
pip install git+https://github.com/geyang/alice.git
```



## Configurations

There are a few ways to configure `alice`. Through command line:

```bash
usage: alice [-h] [--path PATH] [-q] [-i IP] [--port PORT] [-d DELAY]
             [-u USERNAME] [--token TOKEN]

optional arguments:
  -h, --help            show this help message and exit
  --path                specify the path to log to on the server
  -q, --quiet           disable stdin pass-through
  -i, --ip              host
  --port                server port
  -d, --delay           delay before starting to send data
  -u, --username        username for the server
  --token               access_token
```

Through environment variables, you can add the following to your [~/.profile](~/.profile).

```
export ALICE_USERNAME=""
export ALICE_TOKEN=""
export ALICE_HOST=localhost
export ALICE_PORT=l337
```

