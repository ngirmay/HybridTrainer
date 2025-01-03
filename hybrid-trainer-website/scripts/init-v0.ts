import { execSync } from 'child_process';
import dotenv from 'dotenv';
import path from 'path';

dotenv.config();

async function initializeV0() {
  try {
    // Check if V0 CLI is installed
    try {
      execSync('v0 --version');
    } catch {
      console.log('Installing V0 CLI...');
      execSync('npm install -g @v0/cli');
    }

    // Login to V0
    console.log('Logging into V0...');
    execSync(`v0 login ${process.env.V0_ACCESS_TOKEN}`);

    // Initialize V0 in the project
    console.log('Initializing V0 project...');
    execSync('v0 init', { stdio: 'inherit' });

    // Link to existing V0 project
    console.log('Linking to V0 project...');
    execSync(`v0 link ${process.env.V0_PROJECT_ID}`, { stdio: 'inherit' });

    console.log('V0 initialization complete!');
  } catch (error) {
    console.error('Error initializing V0:', error);
    process.exit(1);
  }
}

initializeV0(); 