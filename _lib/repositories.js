"use strict";

const fs = require("fs");
const path = require("path");
const { rootDir } = require("./paths");

const repoPattern = /^\s*\d+\.\s+([^=\s]+)\s+=>\s+(\S+)\s*$/;

function normalizeRepoName(repoUrl) {
  const parsedUrl = new URL(repoUrl);
  const rawName = path.posix.basename(parsedUrl.pathname.replace(/\/$/, ""));
  return rawName.endsWith(".git") ? rawName.slice(0, -4) : rawName;
}

function targetFor(owner, repoName) {
  if (owner === "Egormity") {
    return path.join(rootDir, "egormity", repoName);
  }

  if (owner.toLowerCase() === "havaslo") {
    return path.join(rootDir, "Havaslo", repoName);
  }

  return path.join(rootDir, "ruyou", owner, repoName);
}

function loadRepositories(agentsFile) {
  if (!fs.existsSync(agentsFile)) {
    throw new Error(`Repository list not found: ${agentsFile}`);
  }

  return fs
    .readFileSync(agentsFile, "utf8")
    .split(/\r?\n/)
    .map((line) => repoPattern.exec(line))
    .filter(Boolean)
    .map((match) => {
      const label = match[1];
      const repoUrl = match[2];
      const owner = label.split("/")[0];
      const name = normalizeRepoName(repoUrl);

      return {
        label,
        url: repoUrl,
        owner,
        name,
        target: targetFor(owner, name),
      };
    });
}

module.exports = {
  loadRepositories,
  normalizeRepoName,
  targetFor,
};
