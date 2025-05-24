# Changelog

## [2.0.4](https://github.com/zelikos/davincibox/compare/v2.0.3...v2.0.4) (2025-05-23)


### Bug Fixes

* **opencl:** Explicitly install `ocl-icd` ([06d658d](https://github.com/zelikos/davincibox/commit/06d658d2f1d1114d0d1c7defaed03710399045b2))

## [2.0.3](https://github.com/zelikos/davincibox/compare/v2.0.2...v2.0.3) (2025-04-25)


### Bug Fixes

* Re-add mesa-libOpenCL in davincibox-opencl ([9bc2886](https://github.com/zelikos/davincibox/commit/9bc288635b4e416013a78d8104dee34956c22570))
* Support fractional scaling settings ([39348eb](https://github.com/zelikos/davincibox/commit/39348eb5e5774922023fdcb630203a1628153bdc))

## [2.0.2](https://github.com/zelikos/davincibox/compare/v2.0.1...v2.0.2) (2025-04-25)


### Bug Fixes

* **nvidia:** Rename libDecoderOpenCL.so for companion programs ([d815701](https://github.com/zelikos/davincibox/commit/d8157013fd58ed01121d947d76effe196f297337))
* **opencl:** Remove OpenCL-ICD-Loader before installing OpenCL packages ([dd87812](https://github.com/zelikos/davincibox/commit/dd87812e5568924baf075c07002a2218073f33a8))

## [2.0.1](https://github.com/zelikos/davincibox/compare/v2.0.0...v2.0.1) (2025-01-02)


### Bug Fixes

* **setup.sh:** Use absolute paths for internal scripts ([a8cd464](https://github.com/zelikos/davincibox/commit/a8cd4646219ff425ba43874347fc7d9d5306fe26))
* **setup.sh:** Use absolute paths for internal scripts ([#141](https://github.com/zelikos/davincibox/issues/141)) ([3bf8a08](https://github.com/zelikos/davincibox/commit/3bf8a081f046626961ff1f708c0ec97c0f86d26f))

## [2.0.0](https://github.com/zelikos/davincibox/compare/v1.4.1...v2.0.0) (2024-09-16)


### ⚠ BREAKING CHANGES

* Split into `davincibox` and `davincibox-opencl` ([#121](https://github.com/zelikos/davincibox/issues/121))

### Bug Fixes

* Add xcb-util-cursor ([#123](https://github.com/zelikos/davincibox/issues/123)) ([d19681d](https://github.com/zelikos/davincibox/commit/d19681da4ace14e504e05aa4fea3990e048cd6e0))


### Code Refactoring

* Split into `davincibox` and `davincibox-opencl` ([#121](https://github.com/zelikos/davincibox/issues/121)) ([8bd8117](https://github.com/zelikos/davincibox/commit/8bd8117a2baa720fc8d0586b4e1cae956cb7357a))

## [1.4.1](https://github.com/zelikos/davincibox/compare/v1.4.0...v1.4.1) (2024-09-02)


### Bug Fixes

* Check for GPU driver name, not just vendor ([#115](https://github.com/zelikos/davincibox/issues/115)) ([3e51fa3](https://github.com/zelikos/davincibox/commit/3e51fa38ac7512a26d644d0f48d8cf99921d80de)), closes [#113](https://github.com/zelikos/davincibox/issues/113)

## [1.4.0](https://github.com/zelikos/davincibox/compare/v1.3.0...v1.4.0) (2024-07-29)


### Features

* Apply workarounds for other programs included with Resolve ([#104](https://github.com/zelikos/davincibox/issues/104)) ([945ffe8](https://github.com/zelikos/davincibox/commit/945ffe8f1500237598db4f8e2ddcc52e17d2e191)), closes [#100](https://github.com/zelikos/davincibox/issues/100)


### Bug Fixes

* **adl:** Manually source davinci.sh for distrobox ([#107](https://github.com/zelikos/davincibox/issues/107)) ([cd0f7f7](https://github.com/zelikos/davincibox/commit/cd0f7f7781375bf90cfa903594e8bbcaf002c0fb)), closes [#106](https://github.com/zelikos/davincibox/issues/106)
* **run-davinci:** Check for Nvidia GPU first ([#101](https://github.com/zelikos/davincibox/issues/101)) ([921b578](https://github.com/zelikos/davincibox/commit/921b578b407629e7e78ba088f184e723c43c3fe1))
* **setup.sh:** More reliable nvidia detection ([c39a68d](https://github.com/zelikos/davincibox/commit/c39a68d645883ff4cbb500f2ec81a302b367d68f))

## [1.3.0](https://github.com/zelikos/davincibox/compare/v1.2.0...v1.3.0) (2024-06-20)


### Features

* **run-davinci:** Default to rusticl for AMD GPUs ([#89](https://github.com/zelikos/davincibox/issues/89)) ([8ab74bc](https://github.com/zelikos/davincibox/commit/8ab74bcfcf348a8e891e795b20c154da07dd4afa))


### Bug Fixes

* **setup.sh:** Fix Nvidia GPU check for container creation ([#92](https://github.com/zelikos/davincibox/issues/92)) ([9f5bdaa](https://github.com/zelikos/davincibox/commit/9f5bdaa9424747441c29eb1c44bf0fc1aaafd64b))
* Use full installer path for installer extraction ([#93](https://github.com/zelikos/davincibox/issues/93)) ([d089ea1](https://github.com/zelikos/davincibox/commit/d089ea16fd674018ec48f06cb9f563ec1e6a1514))

## [1.2.0](https://github.com/zelikos/davincibox/compare/v1.1.0...v1.2.0) (2024-06-18)


### Features

* Add intel-compute-runtime for Intel GPUs ([#73](https://github.com/zelikos/davincibox/issues/73)) ([1a65844](https://github.com/zelikos/davincibox/commit/1a65844031e91d13e974b6691c44d4ca54c2cf90))
* Add rusticl as opt-in option ([#67](https://github.com/zelikos/davincibox/issues/67)) ([fcc7a76](https://github.com/zelikos/davincibox/commit/fcc7a767362441f9a2c20baf88b5b7377cd19282))
* **setup.sh:** Improve Nvidia GPU integration, add GPU detection ([8d7d92b](https://github.com/zelikos/davincibox/commit/8d7d92b15a768fe4b7006102c45cd96dea325ed6))


### Bug Fixes

* **adl:** Remove `/usr/bin/` prefix from distrobox shortcut ([#81](https://github.com/zelikos/davincibox/issues/81)) ([d7a2367](https://github.com/zelikos/davincibox/commit/d7a236795bc2bff192fa19b92ee54e6bab561a91)), closes [#80](https://github.com/zelikos/davincibox/issues/80)
* Ensure Fedora packages are updated during setup ([#86](https://github.com/zelikos/davincibox/issues/86)) ([82e47aa](https://github.com/zelikos/davincibox/commit/82e47aaa3b3308b603d711daba0a9fc488359a59)), closes [#85](https://github.com/zelikos/davincibox/issues/85)
* gdk pixbuf symbol lookup error ([#79](https://github.com/zelikos/davincibox/issues/79)) ([a925dda](https://github.com/zelikos/davincibox/commit/a925ddaeb141f9e54a6824753e062e45e63aa87c)), closes [#78](https://github.com/zelikos/davincibox/issues/78)

## [1.1.0](https://github.com/zelikos/davincibox/compare/v1.0.3...v1.1.0) (2024-03-09)


### Features

* Simplify and document upgrade process ([#44](https://github.com/zelikos/davincibox/issues/44)) ([420cc5b](https://github.com/zelikos/davincibox/commit/420cc5b049298a8076d368c425b5a07d07da79db))


### Bug Fixes

* Set "env QT_QPA_PLATFORM=xcb" in launcher ([#61](https://github.com/zelikos/davincibox/issues/61)) ([a93fb05](https://github.com/zelikos/davincibox/commit/a93fb05e23bb755ec6e0a8a3a915181a87c641ba)), closes [#59](https://github.com/zelikos/davincibox/issues/59)

## [1.0.3](https://github.com/zelikos/davincibox/compare/v1.0.2...v1.0.3) (2023-11-21)


### Bug Fixes

* Overwrite upstream-added desktop shortcut with corrected version ([#39](https://github.com/zelikos/davincibox/issues/39)) ([8cd66da](https://github.com/zelikos/davincibox/commit/8cd66da618697e4ddc8a94b607b90386fe109c00)), closes [#36](https://github.com/zelikos/davincibox/issues/36)
* Use QT_QPA_PLATFORM=minimal on AppRun ([#37](https://github.com/zelikos/davincibox/issues/37)) ([e416b06](https://github.com/zelikos/davincibox/commit/e416b06c9f974b510435a77216f9b91822980be5)), closes [#35](https://github.com/zelikos/davincibox/issues/35)

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
