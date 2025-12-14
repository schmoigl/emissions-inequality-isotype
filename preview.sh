#!/bin/bash

# Clean cache and preview script
echo "Cleaning cache directories..."
rm -rf .quarto
rm -rf website

echo "Starting Quarto preview..."
quarto preview
