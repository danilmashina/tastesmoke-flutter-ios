#!/usr/bin/env node

// Script to fix xcconfig issues using xcconfig-patcher

const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

console.log('Starting xcconfig patching process...');

try {
  // Check if xcconfig-patcher is installed
  console.log('Checking if xcconfig-patcher is installed...');
  execSync('npx xcconfig-patcher --help', { stdio: 'ignore' });
  console.log('xcconfig-patcher is available');
} catch (error) {
  console.log('Installing xcconfig-patcher...');
  try {
    execSync('npm install xcconfig-patcher', { stdio: 'inherit' });
    console.log('xcconfig-patcher installed successfully');
  } catch (installError) {
    console.error('Failed to install xcconfig-patcher:', installError.message);
    process.exit(1);
  }
}

// Run the patcher command
try {
  console.log('Running xcconfig-patcher...');
  const command = 'npx xcconfig-patcher --set-base-config ios/Runner.xcodeproj "Pods/Target Support Files/Pods-Runner/Pods-Runner.profile.xcconfig"';
  console.log('Executing command:', command);
  
  execSync(command, { stdio: 'inherit' });
  console.log('xcconfig-patcher completed successfully');
} catch (error) {
  console.error('xcconfig-patcher failed:', error.message);
  process.exit(1);
}

console.log('xcconfig patching process completed');