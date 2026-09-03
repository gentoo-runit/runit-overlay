# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 readme.gentoo-r1

DESCRIPTION="Manage zram swap space"
HOMEPAGE="https://github.com/atweiden/zramen"
EGIT_REPO_URI="https://github.com/atweiden/${PN}.git"

LICENSE="Unlicense"
SLOT="0"
KEYWORDS=""
RESTRICT="test"

RDEPEND="
	app-alternatives/awk
	app-shells/bash
	sys-apps/kmod
	sys-apps/util-linux
	sys-process/runit
"

PATCHES_SED_TARGET="sv/${PN}/run"

src_prepare() {
	default

	# see note above PATCHES_SED_TARGET
	sed -i -e 's/exec pause/exec sleep infinity/' "${PATCHES_SED_TARGET}" \
		|| die "failed to patch ${PATCHES_SED_TARGET}"
}

src_install() {
	dobin "${PN}"

	insinto /etc/sv/${PN}
	doins sv/${PN}/conf

	exeinto /etc/sv/${PN}
	doexe sv/${PN}/run sv/${PN}/finish
}
