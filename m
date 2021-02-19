Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE7931F3BD
	for <lists+linux-nvdimm@lfdr.de>; Fri, 19 Feb 2021 03:03:55 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3ACC9100EB344;
	Thu, 18 Feb 2021 18:03:53 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.120; helo=mga04.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B9943100EBBD7
	for <linux-nvdimm@lists.01.org>; Thu, 18 Feb 2021 18:03:49 -0800 (PST)
IronPort-SDR: lWKQ7YNoUlo/8KtOZbUn9aMPWyIbS+1bafsKFmb+mTCAG+Pn19Atwt6Y5Pgt5pPA3I/FxO9uD5
 IgV+PHLyv8tw==
X-IronPort-AV: E=McAfee;i="6000,8403,9899"; a="181151476"
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400";
   d="scan'208";a="181151476"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 18:03:49 -0800
IronPort-SDR: icwyjkcBes/KDSQFVVPO65Z8ivBtF6STSuT3ljN7urYHfddxUrwgNiYLKfqgk3pVeAlMrYMbmu
 a78cPll0CPgw==
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400";
   d="scan'208";a="513509615"
Received: from jnavar1-mobl4.amr.corp.intel.com (HELO omniknight.intel.com) ([10.213.167.18])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 18:03:48 -0800
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-cxl@vger.kernel.org>
Subject: [ndctl PATCH v2 00/13] Initial CXL support
Date: Thu, 18 Feb 2021 19:03:18 -0700
Message-Id: <20210219020331.725687-1-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Message-ID-Hash: JEULJP7PUYZ3M62MFK25UXIQMFAQZAF2
X-Message-ID-Hash: JEULJP7PUYZ3M62MFK25UXIQMFAQZAF2
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, Ben Widawsky <ben.widawsky@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JEULJP7PUYZ3M62MFK25UXIQMFAQZAF2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Changes since v1[1]:

- Add 'firmware_version' retrieval for memdevs via sysfs attribute
- Add private data storage and accessors for libcxl
- Add a local copy of the UAPI header (cxl_mem.h)
- Refactor 'Identify' command support into a single patch
- Add libcxl APIs for get_lsa
- Add libcxl APIs for get_health_info
- Add libcxl APIs for firmware_status and out.size from cmd response
- Refactor common test helpers to make them more generic
- Add a hexdump helper in util/
- Add a new unit test, test/libcxl which tests:
  - Basic sanity tests
  - Module unload/load
  - identify device command
  - set_lsa (via RAW mode) command
  - get_lsa command
  - fuzzes command input/output payload sizes
- Fix install location of cxl headers
- Add section 3 man pages for libcxl API documentation (only two pages
  added so far).

[1]: https://lore.kernel.org/linux-cxl/20210112003403.2944568-1-vishal.l.verma@intel.com/

---

Add a new utility and library to support CXL devices. This comprehends
the kernel's sysfs layout for CXL devices, and implements a command
submission harness for CXL mailbox commands via ioctl()s defined by the
cxl_mem driver.

A 'cxl-list' command is added which uses some of the libcxl APIs to
display a listing of CXL devices that includes attributes obtained via
sysfs.

Additionally, a new unit test is added to test the library and kernel
(ioctl) interfaces. This includes basic functionality tests for a subset
of the mailbox commands, as well as some negative tests to validate
graceful handling of malformed commands with unexpected buffer sizing
for payloads.

The unit tests are tied to the QEMU implementation[2] of CXL devices.

The latest kernel patches can be found at [3].
An ndctl branch with these patches is also available at [4]

[2]: https://lore.kernel.org/linux-cxl/20210202005948.241655-1-ben.widawsky@intel.com
[3]: https://lore.kernel.org/linux-cxl/20210217040958.1354670-1-ben.widawsky@intel.com
[4]: https://github.com/pmem/ndctl/tree/cxl-2.0v2


Vishal Verma (13):
  cxl: add a cxl utility and libcxl library
  cxl: add a local copy of the cxl_mem UAPI header
  libcxl: add support for command query and submission
  libcxl: add support for the 'Identify Device' command
  test: rename 'ndctl_test' to 'test_ctx'
  test: rename 'ndctl_test_*' helpers to 'test_*'
  test: introduce a libcxl unit test
  libcxl: add GET_HEALTH_INFO mailbox command and accessors
  libcxl: add support for the 'GET_LSA' command
  util/hexdump: Add a util helper to print a buffer in hex
  test/libcxl: add a test for {set, get}_lsa commands
  Documentation/cxl: add library API documentation
  test/libcxl: introduce a command size fuzzing test

 Documentation/cxl/cxl-list.txt       |  65 ++
 Documentation/cxl/cxl.txt            |  34 ++
 Documentation/cxl/human-option.txt   |   8 +
 Documentation/cxl/lib/cxl_new.txt    |  43 ++
 Documentation/cxl/lib/libcxl.txt     |  56 ++
 Documentation/cxl/verbose-option.txt |   5 +
 configure.ac                         |   4 +
 Makefile.am                          |  10 +-
 Makefile.am.in                       |   5 +
 cxl/lib/private.h                    |  97 +++
 cxl/lib/libcxl.c                     | 879 +++++++++++++++++++++++++++
 cxl/builtin.h                        |   8 +
 cxl/cxl_mem.h                        | 181 ++++++
 cxl/libcxl.h                         |  82 +++
 test.h                               |  40 +-
 test/libcxl-expect.h                 |  13 +
 util/filter.h                        |   2 +
 util/hexdump.h                       |   8 +
 util/json.h                          |   3 +
 util/main.h                          |   3 +
 cxl/cxl.c                            |  95 +++
 cxl/list.c                           | 113 ++++
 ndctl/bat.c                          |   8 +-
 ndctl/test.c                         |   8 +-
 test/ack-shutdown-count-set.c        |  16 +-
 test/blk_namespaces.c                |  14 +-
 test/core.c                          |  32 +-
 test/dax-dev.c                       |  10 +-
 test/dax-pmd.c                       |  13 +-
 test/dax-poison.c                    |   6 +-
 test/daxdev-errors.c                 |   2 +-
 test/device-dax.c                    |  24 +-
 test/dpa-alloc.c                     |  14 +-
 test/dsm-fail.c                      |  14 +-
 test/libcxl.c                        | 514 ++++++++++++++++
 test/libndctl.c                      |  84 +--
 test/multi-pmem.c                    |  23 +-
 test/parent-uuid.c                   |  13 +-
 test/pmem_namespaces.c               |  14 +-
 test/revoke-devmem.c                 |  12 +-
 util/filter.c                        |  20 +
 util/hexdump.c                       |  53 ++
 util/json.c                          |  26 +
 .gitignore                           |   5 +
 Documentation/cxl/Makefile.am        |  58 ++
 Documentation/cxl/lib/Makefile.am    |  58 ++
 README.md                            |   2 +-
 cxl/Makefile.am                      |  21 +
 cxl/lib/Makefile.am                  |  32 +
 cxl/lib/libcxl.pc.in                 |  11 +
 cxl/lib/libcxl.sym                   |  57 ++
 test/Makefile.am                     |  15 +-
 52 files changed, 2754 insertions(+), 179 deletions(-)
 create mode 100644 Documentation/cxl/cxl-list.txt
 create mode 100644 Documentation/cxl/cxl.txt
 create mode 100644 Documentation/cxl/human-option.txt
 create mode 100644 Documentation/cxl/lib/cxl_new.txt
 create mode 100644 Documentation/cxl/lib/libcxl.txt
 create mode 100644 Documentation/cxl/verbose-option.txt
 create mode 100644 cxl/lib/private.h
 create mode 100644 cxl/lib/libcxl.c
 create mode 100644 cxl/builtin.h
 create mode 100644 cxl/cxl_mem.h
 create mode 100644 cxl/libcxl.h
 create mode 100644 test/libcxl-expect.h
 create mode 100644 util/hexdump.h
 create mode 100644 cxl/cxl.c
 create mode 100644 cxl/list.c
 create mode 100644 test/libcxl.c
 create mode 100644 util/hexdump.c
 create mode 100644 Documentation/cxl/Makefile.am
 create mode 100644 Documentation/cxl/lib/Makefile.am
 create mode 100644 cxl/Makefile.am
 create mode 100644 cxl/lib/Makefile.am
 create mode 100644 cxl/lib/libcxl.pc.in
 create mode 100644 cxl/lib/libcxl.sym

-- 
2.29.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
