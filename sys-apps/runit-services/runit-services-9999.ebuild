EAPI=8
inherit git-r3
DESCRIPTION="runit service definitions (sv/run scripts) for common desktop daemons"
HOMEPAGE="https://github.com/gentoo-runit/runit-services"
EGIT_REPO_URI="https://github.com/gentoo-runit/runit-services.git"
LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="dbus dhcpcd elogind iwd networkmanager seatd sshd udisks"
REQUIRED_USE="?? ( elogind seatd )"
RDEPEND="
	dbus?           ( sys-apps/dbus )
	dhcpcd?         ( net-misc/dhcpcd )
	elogind?        ( sys-auth/elogind )
	iwd?            ( net-wireless/iwd )
	networkmanager? ( net-misc/networkmanager )
	seatd?          ( sys-auth/seatd )
	sshd?           ( net-misc/openssh )
	udisks?         ( sys-fs/udisks )
"
# turnstiled intentionally left out: it isn't in the Gentoo tree yet,
# add it back once it has an actual build ebuild to depend on.
src_install() {
	insinto /etc/sv
	use dbus            && doins -r sv/dbus
	use dhcpcd           && doins -r sv/dhcpcd
	use elogind          && doins -r sv/elogind
	use iwd              && doins -r sv/iwd
	use networkmanager   && doins -r sv/NetworkManager
	use seatd            && doins -r sv/seatd
	use sshd             && doins -r sv/sshd
	use udisks           && doins -r sv/udisks2

	# doins doesn't preserve the executable bit, set it explicitly
	# for every run script that actually got installed.
	local d
	for d in dbus dhcpcd elogind iwd NetworkManager seatd sshd udisks2; do
		[[ -f "${ED}/etc/sv/${d}/run" ]] && fperms 755 "/etc/sv/${d}/run"
		[[ -f "${ED}/etc/sv/${d}/log/run" ]] && fperms 755 "/etc/sv/${d}/log/run"
	done
}
pkg_postinst() {
	elog "Service directories were installed under /etc/sv/ but are not"
	elog "enabled. Symlink the ones you want into the scan directory:"
	elog "    ln -s /etc/sv/<name> /etc/service/"
	elog ""
}
