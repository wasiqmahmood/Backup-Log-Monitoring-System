const express = require("express");
const { alertError } = require("./alert.js");

const app = express();
app.use(express.json());

// demo route to trigger an error
app.get("/boom", (req, res, next) => {
  next(new Error("Boom! test error for Slack via Bash"));
});

// global error handler — fire-and-forget Slack (don’t block response)
app.use((err, req, res, next) => {
  alertError(err, req).catch(console.error);
  res.status(500).json({ error: "Internal Server Error" });
});

// also catch process-level crashes
process.on("unhandledRejection", (r) => alertError(r).catch(console.error));
process.on("uncaughtException", (e) => {
  alertError(e).catch(console.error);
  // optionally: process.exit(1);
});

app.listen(3000, () => console.log("http://localhost:3000"));
//

// backup code  and save in the /backups repo

// monitor
