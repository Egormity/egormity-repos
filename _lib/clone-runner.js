"use strict";

async function runPool(repositories, jobs, cloneClient) {
  const queue = [...repositories];
  const results = [];

  async function worker() {
    while (queue.length > 0) {
      const repository = queue.shift();
      const result = await cloneClient.clone(repository);
      results.push(result);
      console.log(`[${result.status}] ${repository.label} -> ${repository.target}`);
    }
  }

  await Promise.all(
    Array.from({ length: Math.min(jobs, repositories.length) }, () => worker())
  );

  return results;
}

module.exports = {
  runPool,
};
