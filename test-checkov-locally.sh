#!/bin/bash
# Run this on your VM to test Checkov locally before pushing
# This shows you EXACTLY what will fail before you waste a pipeline run
#
# Usage: bash test-checkov-locally.sh

echo "=========================================="
echo "  CloudShield - Local Checkov Test"
echo "=========================================="
echo ""

cd ~/CloudShield

echo "Running Checkov on Terraform files..."
checkov -d . --quiet 2>&1 | grep -E "(PASSED|FAILED|Check:|File:)" | head -60

echo ""
echo "=========================================="
echo "To see ONLY failures:"
echo "  checkov -d . --quiet 2>&1 | grep -A2 'FAILED'"
echo ""
echo "To generate the JSON report exactly as the pipeline does:"
echo "  checkov -d . -o json > checkov-report.json 2>&1"
echo "  cat checkov-report.json | python3 -m json.tool | grep 'check_id' | head -30"
echo "=========================================="
