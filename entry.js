#!/usr/bin/env node
"use strict";

const os = require("os");
const path = require("path");
const { runPool } = require("./_lib/clone-runner");
const { cloneRepository, findGit } = require("./_lib/git");
const { defaultAgentsFile } = require("./_lib/paths");
const { loadRepositories } = require("./_lib/repositories");

function parseArgs(argv) {
  const args = {
    agentsFile: defaultAgentsFile,
    dryRun: false,
    jobs: 4,
  };

  for (let index = 0; index < argv.length; index += 1) {
    const arg = argv[index];

    if (arg === "--dry-run") {
      args.dryRun = true;
      continue;
    }

    if (arg === "--agents-file") {
      args.agentsFile = path.resolve(argv[index + 1] || "");
      index += 1;
      continue;
    }

    if (arg === "--jobs") {
      args.jobs = Number.parseInt(argv[index + 1] || "", 10);
      index += 1;
      continue;
    }

    if (arg === "-h" || arg === "--help") {
      printHelp();
      process.exit(0);
    }

    throw new Error(`Unknown argument: ${arg}`);
  }

  if (!Number.isFinite(args.jobs) || args.jobs < 1) {
    args.jobs = 1;
  }

  return args;
}

function printHelp() {
  console.log(`Clone every repository listed in AGENTS.md.

Usage:
  node entry.js [--dry-run] [--jobs 4] [--agents-file AGENTS.md]

Options:
  --dry-run             Print planned clone targets without running git clone.
  --jobs <number>       Number of repositories to clone in parallel.
  --agents-file <path>  Path to the AGENTS.md file with repository entries.
`);
}

async function main() {
  const args = parseArgs(process.argv.slice(2));
  const repositories = loadRepositories(args.agentsFile);

  if (repositories.length === 0) {
    throw new Error(`No repositories found in ${args.agentsFile}`);
  }

  console.log(`Found ${repositories.length} repositories.`);

  if (args.dryRun) {
    repositories.forEach((repository) => {
      console.log(`${repository.url} -> ${repository.target}`);
    });
    return 0;
  }

  const gitCommand = findGit();

  if (!gitCommand) {
    console.error("git was not found in PATH. Install Git and run this script again.");
    return 127;
  }

  console.log(`Using git: ${gitCommand}`);
  console.log(`Cloning with ${args.jobs} parallel job(s).`);
  const results = await runPool(repositories, args.jobs, {
    clone: (repository) => cloneRepository(repository, gitCommand),
  });
  const counts = { cloned: 0, skipped: 0, failed: 0 };

  for (const result of results) {
    counts[result.status] += 1;
  }

  console.log(
    `${os.EOL}Done. Cloned: ${counts.cloned}. Skipped: ${counts.skipped}. Failed: ${counts.failed}.`
  );

  const failures = results.filter((result) => result.status === "failed");

  if (failures.length > 0) {
    console.error(`${os.EOL}Failures:`);
    failures.forEach((failure) => {
      console.error(`- ${failure.repository.label}: ${failure.output}`);
    });
    return 1;
  }

  return 0;
}

main()
  .then((code) => {
    process.exitCode = code;
  })
  .catch((error) => {
    console.error(error.message);
    process.exitCode = 1;
  });
