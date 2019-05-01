Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F381610D1F
	for <lists+linux-nvdimm@lfdr.de>; Wed,  1 May 2019 21:18:56 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D82CB21B02822;
	Wed,  1 May 2019 12:18:53 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::830; helo=mail-qt1-x830.google.com;
 envelope-from=pasha.tatashin@soleen.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id A64DD21214959
 for <linux-nvdimm@lists.01.org>; Wed,  1 May 2019 12:18:51 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id p20so21053424qtc.9
 for <linux-nvdimm@lists.01.org>; Wed, 01 May 2019 12:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soleen.com; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=OAQ69X4DsUUmu2uoyueJmu5Yn4QG8MsXOg4ekEMYq7c=;
 b=f+VLFHlWekiPkTa0WJsOHu6qXrPme8uyI7C6FYdAM/ZJbXyW9yGBW+ehN7l854M2a1
 sD2ZcHq6fLNkAp7BSjgRXdCLPLNlfcSG+MsXJ9E6phebMZbuQXGwq1Gdvzv0ww7/HxBX
 6ai2BDJVLAi55EM5q5NZOv+Kmapu5KQ7y0W6G0YKVRoQdNZENRE26wj03jtLhrW0JbnC
 fdCsOv1XGOc1JcYJe7/cvrndachOYHniG0PtUXaJ0kLDvAM+69bi5jFbmjTGwHY8D3mb
 GB1SkcRRPWSjp7ncevM/tGHZtRLdSZz5m/FSvx41CzXWldx50mAHFat1UDjm20hf5Ovo
 BUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=OAQ69X4DsUUmu2uoyueJmu5Yn4QG8MsXOg4ekEMYq7c=;
 b=YjvA8v4kqBbbREuxL+JwV1l1BUO8F0I4uwPKKNwyu/ej8M31uY8MssNk6p9uTNrlz3
 cTL5TqEPqe7pAK14ZWv4iTLBGRuzbPcLhOEWOWJGlpXrOeJJvQrzUq5Gih0gRncbri9l
 XxY/GiYWrCOts9U6t7NOGVwj9G6TctxyNwm0ttvn32e0Qn7F7p9WL5Yhy9VH5CmlVa58
 LxUI4QI8g80Bs3x9vpE08Wyy/beE7Thy+AMxd2rCxIxAVjbOvKoy1k+i97Pd9pACVRll
 ChKjTGIH4G2PaDWBq2zww5rUBlAUfH/Qo7JunCHbTTDqyZXz++aIvmCtXTsiMWUNgr+N
 lsag==
X-Gm-Message-State: APjAAAXCrutAZSN2zwRZu4njLKVWrvkI5G0U847g9/wj7HVrik2sYzhU
 VU1y9zDONTdZ32782M+xtJmQSw==
X-Google-Smtp-Source: APXvYqzCyZTLdMErMvymnUr9OdlM5mz0rF37cxcBelrdS0nhZsEoaskJaHaEp/ddHKjZfP6CgNs73w==
X-Received: by 2002:aed:2124:: with SMTP id 33mr6517015qtc.35.1556738328959;
 Wed, 01 May 2019 12:18:48 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net.
 [73.69.118.222])
 by smtp.gmail.com with ESMTPSA id x47sm12610946qth.68.2019.05.01.12.18.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 01 May 2019 12:18:48 -0700 (PDT)
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
Subject: [v4 0/2] "Hotremove" persistent memory
Date: Wed,  1 May 2019 15:18:44 -0400
Message-Id: <20190501191846.12634-1-pasha.tatashin@soleen.com>
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

Pavel Tatashin (2):
  device-dax: fix memory and resource leak if hotplug fails
  device-dax: "Hotremove" persistent memory that is used like normal RAM

 drivers/dax/dax-private.h |   2 +
 drivers/dax/kmem.c        | 104 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 101 insertions(+), 5 deletions(-)

-- 
2.21.0

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
