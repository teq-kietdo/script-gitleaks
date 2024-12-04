#! /usr/bin/env node

const { exec } = require("child_process");
const readline = require("readline");

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
});

rl.question(
  "Which command that you want to execute? (1: install gitleaks, 2: uninstall gitleaks): ",
  (answer) => {
    let script = "";
    if (answer === "1") {
      script = "script.sh";
    } else if (answer === "2") {
      script = "delete.sh";
    } else {
      console.log("Invalid choice. Exiting.");
      rl.close();
      return;
    }

    exec(`sh ${script}`, (error, stdout, stderr) => {
      if (error) {
        console.error(`Error executing script: ${error}`);
        return;
      }
      if (stderr) {
        console.error(`stderr: ${stderr}`);
        return;
      }
      console.log(`stdout: ${stdout}`);
    });

    rl.close();
  }
);
