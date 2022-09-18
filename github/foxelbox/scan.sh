#!/bin/sh
GITHUB_OWNER= GITHUB_ORGANIZATION=FoxelBox driftctl scan -f 'tfstate+s3://foxden-terraform/github-foxelbox.tfstate' -t 'github+tf'
