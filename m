Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6883621FED
	for <lists+linux-nvdimm@lfdr.de>; Fri, 17 May 2019 23:54:46 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 845AD212657B5;
	Fri, 17 May 2019 14:54:44 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::82d; helo=mail-qt1-x82d.google.com;
 envelope-from=pasha.tatashin@soleen.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 9277E212532E0
 for <linux-nvdimm@lists.01.org>; Fri, 17 May 2019 14:54:42 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id k24so9768557qtq.7
 for <linux-nvdimm@lists.01.org>; Fri, 17 May 2019 14:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soleen.com; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cdLOc+SMSQhawrzrqz+8WbUA4suNHX51mq88wClVqBo=;
 b=K88wU7ZUdBNygUX/4hEfsdd3b5xw9qN0XpxIE3OHk+2F1YuEDlAXKpNWqMhqXami4k
 Rq+M0mPPlolFRa1Iqmv4IcS37oJ6ecEX1N9eDvHI1FXqYVx7PRBWSHcO938AyPfAy6n2
 XgwYJuNGHk+mmQXu6QNfgphRBW3Qw+ggZG4Zn/k3agq3jrmMX47lHDL3hgntkK3tlrFe
 MzTPFgiV5z2kkoxd2Czl5jcUGWo/Rp0FKQZ5nPu4hugHjmx6/T5MlDD54tQFv+ms1ZFi
 6hnAso8+98I16B6QtlV21IU3kzIM2/pM8GLq4UAnkoEW0JAODRiqXdfFAoS2nAe3TANG
 3GFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cdLOc+SMSQhawrzrqz+8WbUA4suNHX51mq88wClVqBo=;
 b=V6hyVpMObek7dI4aK3B41lMqsk8GOvIOKMEBv47GX2cLqVvmW2Q2ifvIqQITzB+T2G
 rSKy/9bzyMdD9vOPi7jIeomrftmJ0e31/TYm6EcReMgZVuqPY0N+RRv+MJeeAfvTUqgL
 GbJRNYl3hM0fGrm+sjPli/U+8lZ2xHcUHP8WqbhtCLM7e5Na+1vzwIU22p5+ay3dovZj
 5I7FMg6YCb4DnWLw2ConJdQOSuO/mApmKrzZir+rWU/EldJmSwqOEFu/8+btkh72WdkU
 Ogh0vsKlzeZQsUYV7m92+jJe2kg3fxCZJ69WoqPjhmdlJljZ1+98NIqzE5tZ0ni+Idzj
 aLaw==
X-Gm-Message-State: APjAAAVxrxdlmb+wBQXN9sO9/vGwqbWDPjYN7JwxosBNJlNmg2L0YhkY
 1dLMuWbjhyY98pd1kue1Od4YIQ==
X-Google-Smtp-Source: APXvYqzDq7uOxY4NjgPSre5B/TFHOi6ZL1hpPZUFQQ6FbqLBzaj9XaKLtw0yJDUtXZwxmvAQtpAwaQ==
X-Received: by 2002:ac8:1b0a:: with SMTP id y10mr47723392qtj.91.1558130080605; 
 Fri, 17 May 2019 14:54:40 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net.
 [73.69.118.222])
 by smtp.gmail.com with ESMTPSA id n36sm6599813qtk.9.2019.05.17.14.54.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 17 May 2019 14:54:39 -0700 (PDT)
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
Subject: [v6 0/3] "Hotremove" persistent memory
Date: Fri, 17 May 2019 17:54:35 -0400
Message-Id: <20190517215438.6487-1-pasha.tatashin@soleen.com>
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
2.21.0

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
