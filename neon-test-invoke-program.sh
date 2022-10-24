#!/bin/bash

if [ -z "$SOLANA_URL" ]; then
  echo "SOLANA_URL is not set"
  exit 1
fi

SOLANA_BIN=/opt/solana/bin

${SOLANA_BIN}/solana config set -u "$SOLANA_URL"

${SOLANA_BIN}/solana airdrop 1

export TEST_PROGRAM=$(${SOLANA_BIN}/solana address -k proxy_program-keypair.json)

echo "Deploying proxy_program at address $TEST_PROGRAM..."
if ! ${SOLANA_BIN}/solana program deploy --upgrade-authority neon-test-invoke-program-keypair.json neon_test_invoke_program.so ; then
  echo "Failed to deploy proxy_program"
  exit 1
fi
