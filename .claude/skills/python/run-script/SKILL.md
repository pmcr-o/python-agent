---
name: run-script
description: "Run a workspace-confined Python script with literal arguments. Dry-run by default; Apply executes the exact script and arguments. Does not install packages."
---
# run-script
Route: `@python-agent /python:run-script`.

Script must be an existing workspace-relative `.py` file. Arguments are passed literally, not through a shell. Default is dry-run; `-Apply` executes. The script itself remains subject to the caller's grant and CHECK evidence.
