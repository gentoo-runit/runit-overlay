EAPI=8

inherit git-r3

DESCRIPTION="Custom runit stage 1/3 rc scripts, plus reboot/poweroff/halt/shutdown wrappers"
HOMEPAGE="https://github.com/gentoo-runit/runit-scripts"
EGIT_REPO_URI="https://github.com/gentoo-runit/runit-scripts.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

RDEPEND="
	!!sys-apps/openrc
	!!sys-apps/sysvinit
	sys-apps/util-linux
	sys-fs/e2fsprogs
	sys-process/runit
"

src_install() {
	exeinto /etc/runit/rc
	doexe rc/1.*.sh rc/3.*.sh

	dosbin bin/reboot bin/poweroff bin/halt bin/shutdown
}

pkg_postinst() {
	elog "Installed rc scripts to /etc/runit/rc/."
	elog "These only take effect on the next boot/shutdown cycle;"
	elog "nothing here restarts a running system."
	elog ""
	elog "Installed reboot, poweroff, halt and shutdown wrappers around runit-init."
}
