#!/bin/bash
set -e
cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"/../

echo "=== test-wheel.sh ==="

# Check if the build directory has the wheel
if [ ! -d ./dist ] || [ -z "$(ls -A ./dist/)" ]; then
  echo "The build directory does not exist or is empty." \
  "Make sure to build the wheel before running this script."
  exit 1
fi
# Test
echo "Twine wheel check: start"
python -m twine check --strict ./dist/*
echo "Twine wheel check: done"

echo "Pyroma wheel check: start"
if [ -z "$(python -m pyroma ./ | grep 'Final rating: 10/10')" ]; then
  exit 1
fi
echo "Pyroma wheel check: done"

echo "- All wheel checks passed"
