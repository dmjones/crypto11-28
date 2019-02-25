#!/usr/bin/env bash

# Create token (will fail on second run, but that's ok)
softhsm2-util --init-token --slot 0 --label test --so-pin 1234 --pin 1234

go run main.go "$@"