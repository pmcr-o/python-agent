---
name: runtime-info
description: "Inspect the available Python runtime and report version, executable, platform, and pip availability without mutation."
---
# runtime-info
Route: `@python-agent /python:runtime-info`.

Default prints the exact inspection command. `-Execute` runs read-only runtime inspection. It never installs or upgrades Python/packages.
