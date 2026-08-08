# runit-overlay
Gentoo Portage overlay with ebuilds for using Runit as PID 1.

[![Gentoo](https://img.shields.io/badge/Gentoo-54487A?style=flat&logo=gentoo&logoColor=white)](https://www.gentoo.org/)
[![runit](https://img.shields.io/badge/init-runit-blue)](http://smarden.org/runit/)

---

## Contents

- [Installation](#installation)
- [USE flags](#use-flags)
- [Enabling a service](#enabling-a-service)

---

## Installation

Add a new file at `/etc/portage/repos.conf.d/runit-overlay` with the following contents:

```ini
[runit-overlay]
location = /var/db/repos/runit-overlay
sync-type = git
sync-uri = https://github.com/gentoo-runit/runit-overlay.git
priority = 50
auto-sync = Yes
```

Then sync the repo and emerge the package:

```bash
emerge --sync runit-overlay
emerge sys-apps/runit-scripts sys-apps/runit-services
```

---

## USE flags for the services

Each flag installs the corresponding service directory under `/etc/sv/`. Nothing is enabled automatically, see [Enabling a service](#enabling-a-service).

| Flag | Installs service |
| ---- | ----------------- |
| `dbus` | dbus |
| `dhcpcd` | dhcpcd |
| `elogind` | elogind |
| `iwd` | iwd |
| `networkmanager` | NetworkManager |
| `seatd` | seatd |
| `sshd` | sshd |
| `turnstiled` | turnstiled |
| `udisks2` | udisks2 |

Set flags in `/etc/portage/package.use/runit-services`, e.g.:

```
sys-apps/runit-services dbus iwd seatd
```

---

## Enabling a service

Installing a service directory does not activate it. Symlink it into the scan directory once you're ready:

```bash
ln -s /etc/sv/dbus /etc/service/
```

Removing the symlink stops and disables it; runit notices the directory disappearing and tears the supervised process down.
