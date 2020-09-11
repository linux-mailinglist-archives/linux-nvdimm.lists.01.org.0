Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E4D265E06
	for <lists+linux-nvdimm@lfdr.de>; Fri, 11 Sep 2020 12:35:37 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 04398144C8049;
	Fri, 11 Sep 2020 03:35:34 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.120; helo=us-smtp-1.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [205.139.110.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 37AC9144B8F85
	for <linux-nvdimm@lists.01.org>; Fri, 11 Sep 2020 03:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1599820529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1KuXxBJDT9q7FMGTTmPve0j4GWux8SlD+IUyrucmwlw=;
	b=GtwJqSsajUx7DE+lq7cRijZyPE2r5nfRqG5MZJvyBR9cnq48KqceYRagMhvzJCCGKipPVe
	rYkpSt84nej8T3GwaQSppK1Msn9JW9CRiEdpkHcnU9bCOBd9imFJjHlw4sg0vgaHK8cvah
	78Tz+z2EPxTuj44sXZ0+apkGPB14/eQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-586-oFPkKPz2OhqR_nzBBqVMxA-1; Fri, 11 Sep 2020 06:35:25 -0400
X-MC-Unique: oFPkKPz2OhqR_nzBBqVMxA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA7358064AF;
	Fri, 11 Sep 2020 10:35:19 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-186.ams2.redhat.com [10.36.113.186])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7A83881C49;
	Fri, 11 Sep 2020 10:35:00 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/8] selective merging of system ram resources
Date: Fri, 11 Sep 2020 12:34:51 +0200
Message-Id: <20200911103459.10306-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Message-ID-Hash: BYFUALNWKISOCASVYJZ233MNWVPC6ZRT
X-Message-ID-Hash: BYFUALNWKISOCASVYJZ233MNWVPC6ZRT
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: virtualization@lists.linux-foundation.org, linux-mm@kvack.org, linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org, linux-s390@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Andrew Morton <akpmt@linux-foundation.org>, Anton Blanchard <anton@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Eric Biederman <ebiederm@xmission.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Haiyang Zhang <haiyangz@microsoft.com>, Heiko Carstens <hca@linux.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jason Wang <jasowang@redhat.com>, Juergen Gross <jgross@suse.com>, Julien Grall <julien@xen.org>, Kees Cook <keescook@chromium.org>, "K. Y. Srinivasan" <kys@microsoft.com>, Len Brown <lenb@kernel.org>, Leonardo Bras <leo
 bras.c@gmail.com>, Libor Pechacek <lpechacek@suse.cz>, Michael Ellerman <mpe@ellerman.id.au>, "Michael S. Tsirkin" <mst@redhat.com>, Michal Hocko <mhocko@suse.com>, Nathan Lynch <nathanl@linux.ibm.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Paul Mackerras <paulus@samba.org>, Pingfan Liu <kernelfans@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>, Wei Liu <wei.liu@kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BYFUALNWKISOCASVYJZ233MNWVPC6ZRT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Some add_memory*() users add memory in small, contiguous memory blocks.
Examples include virtio-mem, hyper-v balloon, and the XEN balloon.

This can quickly result in a lot of memory resources, whereby the actual
resource boundaries are not of interest (e.g., it might be relevant for
DIMMs, exposed via /proc/iomem to user space). We really want to merge
added resources in this scenario where possible.

Resources are effectively stored in a list-based tree. Having a lot of
resources not only wastes memory, it also makes traversing that tree more
expensive, and makes /proc/iomem explode in size (e.g., requiring
kexec-tools to manually merge resources when creating a kdump header. The
current kexec-tools resource count limit does not allow for more than
~100GB of memory with a memory block size of 128MB on x86-64).

Let's allow to selectively merge system ram resources by specifying a
new flag for add_memory*(). Patch #5 contains a /proc/iomem example. Only
tested with virtio-mem.

v3 -> v4:
- "mm/memory_hotplug: guard more declarations by CONFIG_MEMORY_HOTPLUG"
-- Fix configs without CONFIG_MEMORY_HOTPLUG with the new mhp_t type
-- Did a buch of cross-compiles with different configs, hope there isn't
   anything I missed.

v2 -> v3:
- "mm/memory_hotplug: prepare passing flags to add_memory() and friends"
-- Use proper __bitwise type for flags
-- Use "MHP_NONE" for empty flags
- Rebased to latest -next, added rb's

v1 -> v2:
- I had another look at v1 after vacation and didn't like it - it felt like
  a hack. So I want forward and added a proper flag to add_memory*(), and
  introduce a clean (non-racy) way to mark System RAM resources mergeable.
- "kernel/resource: move and rename IORESOURCE_MEM_DRIVER_MANAGED"
-- Clean that flag up, felt wrong in the PnP section
- "mm/memory_hotplug: prepare passing flags to add_memory() and friends"
-- Previously sent in other context - decided to keep Wei's ack
- "mm/memory_hotplug: MEMHP_MERGE_RESOURCE to specify merging of System
   RAM resources"
-- Cleaner approach to get the job done by using proper flags and only
   merging the single, specified resource
- "virtio-mem: try to merge system ram resources"
  "xen/balloon: try to merge system ram resources"
  "hv_balloon: try to merge system ram resources"
-- Use the new flag MEMHP_MERGE_RESOURCE, much cleaner

RFC -> v1:
- Switch from rather generic "merge_child_mem_resources()" where a resource
  name has to be specified to "merge_system_ram_resources().
- Smaller comment/documentation/patch description changes/fixes

David Hildenbrand (8):
  kernel/resource: make release_mem_region_adjustable() never fail
  kernel/resource: move and rename IORESOURCE_MEM_DRIVER_MANAGED
  mm/memory_hotplug: guard more declarations by CONFIG_MEMORY_HOTPLUG
  mm/memory_hotplug: prepare passing flags to add_memory() and friends
  mm/memory_hotplug: MEMHP_MERGE_RESOURCE to specify merging of System
    RAM resources
  virtio-mem: try to merge system ram resources
  xen/balloon: try to merge system ram resources
  hv_balloon: try to merge system ram resources

 arch/powerpc/platforms/powernv/memtrace.c     |   2 +-
 .../platforms/pseries/hotplug-memory.c        |   2 +-
 drivers/acpi/acpi_memhotplug.c                |   3 +-
 drivers/base/memory.c                         |   3 +-
 drivers/dax/kmem.c                            |   2 +-
 drivers/hv/hv_balloon.c                       |   2 +-
 drivers/s390/char/sclp_cmd.c                  |   2 +-
 drivers/virtio/virtio_mem.c                   |   3 +-
 drivers/xen/balloon.c                         |   2 +-
 include/linux/ioport.h                        |  12 +-
 include/linux/memory_hotplug.h                |  35 +++---
 kernel/kexec_file.c                           |   2 +-
 kernel/resource.c                             | 109 ++++++++++++++----
 mm/memory_hotplug.c                           |  47 +++-----
 mm/sparse.c                                   |   2 +
 15 files changed, 151 insertions(+), 77 deletions(-)

-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
