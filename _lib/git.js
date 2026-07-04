"use strict";

const fs = require("fs");
const os = require("os");
const path = require("path");
const { spawn, spawnSync } = require("child_process");
const { rootDir } = require("./paths");

function findCommand(command) {
  const lookupCommand = os.platform() === "win32" ? "where" : "command";
  const lookupArgs = os.platform() === "win32" ? [command] : ["-v", command];
  const result = spawnSync(lookupCommand, lookupArgs, {
    shell: os.platform() !== "win32",
    encoding: "utf8",
    stdio: ["ignore", "pipe", "ignore"],
  });

  if (result.status === 0) {
    return result.stdout.split(/\r?\n/).find(Boolean) || command;
  }

  return null;
}

function findGit() {
  const gitFromPath = findCommand("git");

  if (gitFromPath) {
    return gitFromPath;
  }

  if (os.platform() !== "win32") {
    return null;
  }

  const candidates = [
    "C:\\Program Files\\Git\\cmd\\git.exe",
    "C:\\Program Files\\Git\\bin\\git.exe",
    "C:\\Program Files (x86)\\Git\\cmd\\git.exe",
    "C:\\Program Files (x86)\\Git\\bin\\git.exe",
  ];

  return candidates.find((candidate) => fs.existsSync(candidate)) || null;
}

function cloneRepository(repository, gitCommand) {
  return new Promise((resolve) => {
    if (fs.existsSync(repository.target)) {
      resolve({ repository, status: "skipped", output: "target already exists" });
      return;
    }

    fs.mkdirSync(path.dirname(repository.target), { recursive: true });

    const process = spawn(gitCommand, ["clone", repository.url, repository.target], {
      cwd: rootDir,
      shell: false,
      stdio: ["ignore", "pipe", "pipe"],
    });

    let output = "";
    process.stdout.on("data", (chunk) => {
      output += chunk.toString();
    });
    process.stderr.on("data", (chunk) => {
      output += chunk.toString();
    });
    process.on("close", (code) => {
      resolve({
        repository,
        status: code === 0 ? "cloned" : "failed",
        output: output.trim(),
      });
    });
  });
}

module.exports = {
  cloneRepository,
  findGit,
};
