"use strict";

const path = require("path");

const rootDir = path.resolve(__dirname, "..");
const defaultAgentsFile = path.join(rootDir, "AGENTS.md");

module.exports = {
  defaultAgentsFile,
  rootDir,
};
