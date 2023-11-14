# Changelog

## [1.0.2](https://github.com/zelikos/davincibox/compare/v1.0.1...v1.0.2) (2023-11-14)


### Bug Fixes

* updated gdk_pixbuf to prevent g_task_set_static_name error ([e15effd](https://github.com/zelikos/davincibox/commit/e15effd732cf567bf510c7bc81d7340746168426))

## [1.0.1](https://github.com/zelikos/davincibox/compare/v1.0.0...v1.0.1) (2023-10-16)


### Bug Fixes

* Add pipewire-alsa to fix no audio on some systems ([f6461bf](https://github.com/zelikos/davincibox/commit/f6461bfc1f3f415cde7d71124aafcb40134c6959))

## 1.0.0 (2023-09-29)


### Features

* Add "remove" option in setup.sh ([#15](https://github.com/zelikos/davincibox/issues/15)) ([27f371e](https://github.com/zelikos/davincibox/commit/27f371ee734add0cf9a94a386e05573c97489e1a))
* Add cosign key ([37ed4b5](https://github.com/zelikos/davincibox/commit/37ed4b5d8da372b512bc03274a296335287895c7))
* Add extra-packages ([8f71f86](https://github.com/zelikos/davincibox/commit/8f71f863cec54f83406ea230c20590ec37e3e2f4))
* Add initial Containerfile ([9527124](https://github.com/zelikos/davincibox/commit/95271248ba4afc44d97b7a897384bc7aee08da0f))
* Add nvidia packages ([7d6e691](https://github.com/zelikos/davincibox/commit/7d6e6918171a40c562cdf497a9345e11552752c7))
* Add setup script ([#1](https://github.com/zelikos/davincibox/issues/1)) ([02379cb](https://github.com/zelikos/davincibox/commit/02379cbe74dda07f05ee235a2ec14b08b72083d7))
* Add Toolbox support ([#6](https://github.com/zelikos/davincibox/issues/6)) ([aec3afc](https://github.com/zelikos/davincibox/commit/aec3afc70d72014d4bd2d96d758515e2bfc6a7aa))
* **ci:** Add build-davincibox.yml ([3dfe5aa](https://github.com/zelikos/davincibox/commit/3dfe5aab1db2e0e568c691180e8187b10b03ee3c))
* Implement launcher setup ([#9](https://github.com/zelikos/davincibox/issues/9)) ([4fdaade](https://github.com/zelikos/davincibox/commit/4fdaadeba50f296d514026c56768a0f7e67f4b34))


### Bug Fixes

* Add && after dnf update ([46fa049](https://github.com/zelikos/davincibox/commit/46fa04964b367ce1b134d596852b93b7721e7cff))
* Add missing packages ([e5cd1e3](https://github.com/zelikos/davincibox/commit/e5cd1e3fffd92eb40f342e242a0536d155197cc0))
* Assume yes for dnf commands ([4fdfb56](https://github.com/zelikos/davincibox/commit/4fdfb56fb1fd731ca5ae70c1847bfc98ede9b1cd))
* Assume yes for DNF. again ([7bb62e5](https://github.com/zelikos/davincibox/commit/7bb62e5d1d8130aafb23a76154bc800218dd784f))
* Check for installer file in setup.sh again ([#17](https://github.com/zelikos/davincibox/issues/17)) ([799ca64](https://github.com/zelikos/davincibox/commit/799ca640f6d2d410ea47d3db9a6c5ba3459e6b0f))
* Missing end-quote in setup.sh ([42ad989](https://github.com/zelikos/davincibox/commit/42ad989e3c68b6bb80095d5f48f7e8d137be30cd))
* Set use_distrobox=true if distrobox is installed ([517a23a](https://github.com/zelikos/davincibox/commit/517a23a20643aa71868ebec2a28247c9bc4fb5a1))
