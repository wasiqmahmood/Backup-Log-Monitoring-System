const { spawn } = require("child_process");

// Send a multi-line message to the bash script via stdin
function sendSlackViaBash(multilineMessage) {
  return new Promise((resolve) => {
    const child = spawn("./notifier/slack_notify.sh", [], {
      stdio: ["pipe", "ignore", "inherit"], // stdin->script, ignore stdout, show stderr
    });
    child.stdin.write(multilineMessage);
    child.stdin.end();
    child.on("close", () => resolve());
  });
}

async function alertError(err, req) {
  const when = new Date().toISOString();
  const lines = [
    `🛑 MERN ERROR @ ${when}`,
    req ? `${req.method} ${req.originalUrl}` : "(no request context)",
    `Message: ${err?.message || String(err)}`,
    `Stack:\n${err?.stack || "(no stack)"}`,
  ];
  await sendSlackViaBash(lines.join("\n"));
}

module.exports = { alertError };
