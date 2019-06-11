Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 911CC41902
	for <lists+linux-nvdimm@lfdr.de>; Wed, 12 Jun 2019 01:40:05 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9286121962301;
	Tue, 11 Jun 2019 16:40:03 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.115; helo=mga14.intel.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id E91FC2128A631
 for <linux-nvdimm@lists.01.org>; Tue, 11 Jun 2019 16:40:01 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Jun 2019 16:40:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,363,1557212400"; d="scan'208";a="184035062"
Received: from dwillia2-desk3.jf.intel.com (HELO
 dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
 by fmsmga002.fm.intel.com with ESMTP; 11 Jun 2019 16:39:59 -0700
Subject: [PATCH 0/6] libnvdimm: Fix async operations and locking
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Tue, 11 Jun 2019 16:25:43 -0700
Message-ID: <156029554317.419799.1324389595953183385.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Erwin Tsaur <erwin.tsaur@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

The libnvdimm subsystem uses async operations to parallelize device
probing operations and to allow sysfs to trigger device_unregister() on
deleted namepsaces. A multithreaded stress test of the libnvdimm sysfs
interface uncovered a case where device_unregister() is triggered
multiple times, and the subsequent investigation uncovered a broken
locking scenario.

The lack of lockdep coverage for device_lock() stymied the debug. That
is, until patch6 "driver-core, libnvdimm: Let device subsystems add
local lockdep coverage" solved that with a shadow lock, with lockdep
coverage, to mirror device_lock() operations. Given the time saved with
shadow-lock debug-hack, patch6 attempts to generalize device_lock()
debug facility that might be able to be carried upstream. Patch6 is
staged at the end of this fix series in case it is contentious and needs
to be dropped.

Patch1 "drivers/base: Introduce kill_device()" could be achieved with
local libnvdimm infrastructure. However, the existing 'dead' flag in
'struct device_private' aims to solve similar async register/unregister
races so the fix in patch2 "libnvdimm/bus: Prevent duplicate
device_unregister() calls" can be implemented with existing driver-core
infrastructure.

Patch3 is a rare lockdep warning that is intermittent based on
namespaces racing ahead of the completion of probe of their parent
region. It is not related to the other fixes, it just happened to
trigger as a result of the async stress test.

Patch4 and patch5 address an ABBA deadlock tripped by the stress test.

These patches pass the failing stress test and the existing libnvdimm
unit tests with CONFIG_PROVE_LOCKING=y and the new "dev->lockdep_mutex"
shadow lock with no lockdep warnings.

---

Dan Williams (6):
      drivers/base: Introduce kill_device()
      libnvdimm/bus: Prevent duplicate device_unregister() calls
      libnvdimm/region: Register badblocks before namespaces
      libnvdimm/bus: Stop holding nvdimm_bus_list_mutex over __nd_ioctl()
      libnvdimm/bus: Fix wait_nvdimm_bus_probe_idle() ABBA deadlock
      driver-core, libnvdimm: Let device subsystems add local lockdep coverage


 drivers/acpi/nfit/core.c        |   28 ++++---
 drivers/acpi/nfit/nfit.h        |   24 ++++++
 drivers/base/core.c             |   30 ++++++--
 drivers/nvdimm/btt_devs.c       |   16 ++--
 drivers/nvdimm/bus.c            |  154 +++++++++++++++++++++++++++------------
 drivers/nvdimm/core.c           |   10 +--
 drivers/nvdimm/dimm_devs.c      |    4 +
 drivers/nvdimm/namespace_devs.c |   36 +++++----
 drivers/nvdimm/nd-core.h        |   71 ++++++++++++++++++
 drivers/nvdimm/pfn_devs.c       |   24 +++---
 drivers/nvdimm/pmem.c           |    4 +
 drivers/nvdimm/region.c         |   24 +++---
 drivers/nvdimm/region_devs.c    |   12 ++-
 include/linux/device.h          |    6 ++
 14 files changed, 308 insertions(+), 135 deletions(-)
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
