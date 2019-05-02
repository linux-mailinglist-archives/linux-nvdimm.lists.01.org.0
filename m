Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 243741220D
	for <lists+linux-nvdimm@lfdr.de>; Thu,  2 May 2019 20:43:45 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3AEEE21243BDF;
	Thu,  2 May 2019 11:43:43 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::82e; helo=mail-qt1-x82e.google.com;
 envelope-from=pasha.tatashin@soleen.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 38C1721243BD8
 for <linux-nvdimm@lists.01.org>; Thu,  2 May 2019 11:43:41 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id j6so3826059qtq.1
 for <linux-nvdimm@lists.01.org>; Thu, 02 May 2019 11:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soleen.com; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xoemE8OPi9tqBHaKmVDMP6fqzg3JRjWrdojq7V/9jr4=;
 b=FJISljxNrMpf4BKlSGlFeUIV8YCdFaNtpEv6AsymPhEDpG/AYIOG564YnNgyiSZWYs
 er3AMBJemBc5rus9Wxn9a3q92pMjyIY35YjJBnrjKns6nNaTIL3+Kv7qqcHlJw75OsYD
 zPDMcCNUOhEBpj14TxzAHyzuYb/L0bCZe37EIL49iHNzw/vfuyUmJHW9EOpqOPC5nnS+
 tfWu9kNx5xZbaPzjIk5/kJO7U65ZWbAy3mcTyDUBHmXgAxsW8gu6gSS7xABffa88s0Rf
 5V9s4F2DpoSRTPMKZSEB51TgBtnUSFEFXIVol4hVNm8XpV5s8aQBbDGBGq5AbPhUbIvu
 FIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xoemE8OPi9tqBHaKmVDMP6fqzg3JRjWrdojq7V/9jr4=;
 b=V/+aAD4hp1ccFfH9Q2jLZfWQQ6kdUFt1vmSknF46yU7cspsbuj7AlCAxSIEDMiaB6S
 j7nyqLiD44fePQjz3a1ZwDVIiPO2F9S6jannKfgH/dsL050+GOtHXdfwy7CGSV7bZih/
 YCwwtBGztrw3wLAWLu2/pPsdYU2Ksso0pNfeZAF5t/ffsajWfOw/5ZX9y4sm6RDsJBh6
 kTffCmeIkoy1NoAohjFLq0Hq5N4Cust3RfPMcSmNIF8ItyRsYzwPS+Z+yevGDf8q/Wos
 vJ4hide/zEpGIf6T29oOTBkb4ypYryVow+9Dru1OUF4mP4QOEaY9zrozbNwhzJuDCEF3
 V6/w==
X-Gm-Message-State: APjAAAXJUs8H3c+fJ7ENotXLFlTWhsw/LPoPz/l/mdn+/sRflbFNEwOS
 uDc2BdEkB6D61LDGg3awg8xUTg==
X-Google-Smtp-Source: APXvYqydvQA3tm1YLVyZkJR+Xcl7phv6H18jB1wWNP5r4MBakwaedC5LCXAOSAq7RroNt91CriKhcg==
X-Received: by 2002:aed:3512:: with SMTP id a18mr4319879qte.181.1556822619826; 
 Thu, 02 May 2019 11:43:39 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net.
 [73.69.118.222])
 by smtp.gmail.com with ESMTPSA id 8sm25355751qtr.32.2019.05.02.11.43.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 02 May 2019 11:43:39 -0700 (PDT)
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
Subject: [v5 0/3] "Hotremove" persistent memory
Date: Thu,  2 May 2019 14:43:34 -0400
Message-Id: <20190502184337.20538-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.21.0
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
 drivers/dax/kmem.c             | 46 ++++++++++++++++++++++---
 include/linux/memory_hotplug.h |  8 +++--
 mm/memory_hotplug.c            | 61 ++++++++++++++++++++++------------
 4 files changed, 89 insertions(+), 28 deletions(-)

-- 
2.21.0

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
