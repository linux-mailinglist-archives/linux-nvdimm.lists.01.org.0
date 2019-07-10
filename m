Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D94F63EDA
	for <lists+linux-nvdimm@lfdr.de>; Wed, 10 Jul 2019 03:16:54 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0C3D8212B0FFF;
	Tue,  9 Jul 2019 18:16:52 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::744; helo=mail-qk1-x744.google.com;
 envelope-from=pasha.tatashin@soleen.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id EA435212B0FFA
 for <linux-nvdimm@lists.01.org>; Tue,  9 Jul 2019 18:16:50 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id r4so600899qkm.13
 for <linux-nvdimm@lists.01.org>; Tue, 09 Jul 2019 18:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soleen.com; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PqeszyHnpa09JchLWcVjDqXY/gdBDHevYPDmL0qjCG8=;
 b=NYgWnJLbG4IKERgDp8Mh8rchqpvIRzQaOzF4bWc2NXG+eqFvzv5WLLXJh22Y51w5Vz
 o5hkqppdjfxAY+lffbn7o8xckUMuJcFpHvgEMfSqFSqpBj4swXlJYkJp+Qx1BZsFy3zx
 NxitqsOKFA568E0jamBAdwfoc2KarmcCjYBRmq7tpXPZYM9UWel6pBB9e0RdCbN1G7lM
 6k84/FODP8iMFFaxMzdhUE2L/A725PpjkSamO8doAbClan8mRDNB97MBDEik0/8ocSNz
 d+gQ2ptWEdcPoMakj2qwdSXqlVfZuL8x4wgGqvURqZy3xb4pceimmbiVvvVeNxBXFfps
 bTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PqeszyHnpa09JchLWcVjDqXY/gdBDHevYPDmL0qjCG8=;
 b=DQA24TyTleQVVWkSWUCTadONy99/D7ObBF1pd4on7V26fH8fVByXVu/x2ds0SQGRY7
 MNb0OY/MFCzemkX8jpjhJ7ULr5oWuE1UmOwlGP/yb8Pk9/4X+bpVro4fgCy51PkF2fyF
 CekZZ6jAuxrG+0UyXhL1KRwC71jMzu6anF4gnGySndKViVSnSCpib2RhiSa5fBqpP49N
 dLp6w8E4wGt/SCd2if4g7kjQcjtOo4bMjrTlWn137rEyq74C4TG8gz0u7uzB/SoDmbOH
 c2cmsxLvxuZB3dXQQAdN9UG/S9IJGHCucXSpG0AbE6RI85u9jpms3upRrJpqSayV3wEv
 UYcQ==
X-Gm-Message-State: APjAAAX6l3UDFIorp2DlizEESVbP2xLK6cg3b5ww8rhqxx0V3vxuZ6o7
 qC7ty5uSWAsTQ6Gv18BBtfKDPw==
X-Google-Smtp-Source: APXvYqzHJ58xkPz/UnFmZw8DxydXmBaaklCvE3hDIpuyBcyWl2zdGdbL4YcSPkWWV6dS4LNlSnmtaw==
X-Received: by 2002:a37:9481:: with SMTP id
 w123mr20792761qkd.319.1562721409590; 
 Tue, 09 Jul 2019 18:16:49 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net.
 [73.69.118.222])
 by smtp.gmail.com with ESMTPSA id u7sm260057qta.82.2019.07.09.18.16.48
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 09 Jul 2019 18:16:48 -0700 (PDT)
From: Pavel Tatashin <pasha.tatashin@soleen.com>
To: pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-nvdimm@lists.01.org, akpm@linux-foundation.org, mhocko@suse.com,
 dave.hansen@linux.intel.com, dan.j.williams@intel.com,
 keith.busch@intel.com, vishal.l.verma@intel.com, dave.jiang@intel.com,
 zwisler@kernel.org, thomas.lendacky@amd.com, ying.huang@intel.com,
 fengguang.wu@intel.com, bp@suse.de, bhelgaas@google.com,
 baiyaowei@cmss.chinamobile.com, tiwai@suse.de, jglisse@redhat.com,
 david@redhat.com
Subject: [v7 0/3] "Hotremove" persistent memory
Date: Tue,  9 Jul 2019 21:16:44 -0400
Message-Id: <20190710011647.10944-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.22.0
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Changelog:
v7
- Added Dan Williams Reviewed-by to the last patch, and small change to
  dev_err() otput format as was suggested by Dan.

v6
- A few minor changes and added reviewed-by's.
- Spent time studying lock ordering issue that was reported by Vishal
  Verma, but that issue already exists in Linux, and can be reproduced
  with exactly the same steps with ACPI memory hotplugging.

v5
- Addressed comments from Dan Williams: made remove_memory() to return
  an error code, and use this function from dax.

v4
- Addressed comments from Dave Hansen

v3
- Addressed comments from David Hildenbrand. Don't release
  lock_device_hotplug after checking memory status, and rename
  memblock_offlined_cb() to check_memblock_offlined_cb()

v2
- Dan Williams mentioned that drv->remove() return is ignored
  by unbind. Unbind always succeeds. Because we cannot guarantee
  that memory can be offlined from the driver, don't even
  attempt to do so. Simply check that every section is offlined
  beforehand and only then proceed with removing dax memory.

---

Recently, adding a persistent memory to be used like a regular RAM was
added to Linux. This work extends this functionality to also allow hot
removing persistent memory.

We (Microsoft) have an important use case for this functionality.

The requirement is for physical machines with small amount of RAM (~8G)
to be able to reboot in a very short period of time (<1s). Yet, there is
a userland state that is expensive to recreate (~2G).

The solution is to boot machines with 2G preserved for persistent
memory.

Copy the state, and hotadd the persistent memory so machine still has
all 8G available for runtime. Before reboot, offline and hotremove
device-dax 2G, copy the memory that is needed to be preserved to pmem0
device, and reboot.

The series of operations look like this:

1. After boot restore /dev/pmem0 to ramdisk to be consumed by apps.
   and free ramdisk.
2. Convert raw pmem0 to devdax
   ndctl create-namespace --mode devdax --map mem -e namespace0.0 -f
3. Hotadd to System RAM
   echo dax0.0 > /sys/bus/dax/drivers/device_dax/unbind
   echo dax0.0 > /sys/bus/dax/drivers/kmem/new_id
   echo online_movable > /sys/devices/system/memoryXXX/state
4. Before reboot hotremove device-dax memory from System RAM
   echo offline > /sys/devices/system/memoryXXX/state
   echo dax0.0 > /sys/bus/dax/drivers/kmem/unbind
5. Create raw pmem0 device
   ndctl create-namespace --mode raw  -e namespace0.0 -f
6. Copy the state that was stored by apps to ramdisk to pmem device
7. Do kexec reboot or reboot through firmware if firmware does not
   zero memory in pmem0 region (These machines have only regular
   volatile memory). So to have pmem0 device either memmap kernel
   parameter is used, or devices nodes in dtb are specified.


Pavel Tatashin (3):
  device-dax: fix memory and resource leak if hotplug fails
  mm/hotplug: make remove_memory() interface useable
  device-dax: "Hotremove" persistent memory that is used like normal RAM

 drivers/dax/dax-private.h      |  2 ++
 drivers/dax/kmem.c             | 46 +++++++++++++++++++++---
 include/linux/memory_hotplug.h |  8 +++--
 mm/memory_hotplug.c            | 64 +++++++++++++++++++++++-----------
 4 files changed, 92 insertions(+), 28 deletions(-)

-- 
2.22.0

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
