Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9071C4696
	for <lists+linux-nvdimm@lfdr.de>; Mon,  4 May 2020 21:03:06 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DAE841162A524;
	Mon,  4 May 2020 12:01:24 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.61; helo=us-smtp-delivery-1.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com [205.139.110.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1E8B21161C344
	for <linux-nvdimm@lists.01.org>; Mon,  4 May 2020 12:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1588618979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mP9q+4tMTUFFbHWKmZ6XyIVd8J3nRNyyGmILxDAp3rM=;
	b=CRsaquWQerzl88VxeMXNnQceRzPXubJFUokrLQGGSy00uU8wvaw3oXVk94RKbjU06/cx9A
	hUrTEjPr83CRV54k1UutbyXLjsDof1n4KTHyqNo1Wrx4q40xArHpkBYfuO5ZGcSWqg9SHc
	6jbTXUAlFGa7wfyHeubXAsY4eQT+EcE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-NZ081FhiM1eWnMh_6FGHpA-1; Mon, 04 May 2020 15:02:51 -0400
X-MC-Unique: NZ081FhiM1eWnMh_6FGHpA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A42CB107ACCD;
	Mon,  4 May 2020 19:02:48 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-235.ams2.redhat.com [10.36.114.235])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B21522B4AF;
	Mon,  4 May 2020 19:02:42 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] mm/memory_hotplug: Interface to add driver-managed system ram
Date: Mon,  4 May 2020 21:02:24 +0200
Message-Id: <20200504190227.18269-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Message-ID-Hash: LRDXP3D3GNUKML2WIHSVZM6OR7F6NVNE
X-Message-ID-Hash: LRDXP3D3GNUKML2WIHSVZM6OR7F6NVNE
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-mm@kvack.org, linux-nvdimm@lists.01.org, kexec@lists.infradead.org, Pavel Tatashin <pasha.tatashin@soleen.com>, David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eric Biederman <ebiederm@xmission.com>, Michal Hocko <mhocko@suse.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Wei Yang <richard.weiyang@gmail.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LRDXP3D3GNUKML2WIHSVZM6OR7F6NVNE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Third time is the charm? Let's see ... :)

This is the follow up of [1]:
 [PATCH v1 0/3] mm/memory_hotplug: Make virtio-mem play nicely with
 kexec-tools
and [2]:
 [PATCH v2 0/3] mm/memory_hotplug: Allow to not create firmware memmap
 entries

kexec (via kexec_load()) can currently not properly handle memory added via
dax/kmem, and will have similar issues with virtio-mem. kexec-tools will
currently add all memory to the fixed-up initial firmware memmap. In case
of dax/kmem, this means that - in contrast to a proper reboot - how that
persistent memory will be used can no longer be configured by the kexec'd
kernel. In case of virtio-mem it will be harmful, because that memory
might contain inaccessible pieces that require coordination with hypervisor
first.

In both cases, we want to let the driver in the kexec'd kernel handle
detecting and adding the memory, like during an ordinary reboot.
Introduce add_memory_driver_managed(). More on the samentics are in patch
#1.

In the future, we might want to make this behavior configurable for
dax/kmem- either by configuring it in the kernel (which would then also
allow to configure kexec_file_load()) or in kexec-tools by also adding
"System RAM (kmem)" memory from /proc/iomem to the fixed-up initial
firmware memmap.

More on the motivation can be found in [1] and [2].

v2 -> v3:
- Don't use flags for add_memory() and friends, provide
  add_memory_driver_managed() instead.
- Flag memory resources via IORESOURCE_MEM_DRIVER_MANAGED and handle them
  in kexec.
- Name memory resources "System RAM ($DRIVER)", visible via /proc/iomem
- Added more details to the patch descriptions, especially regarding the
  history of /sys/firmware/memmap
- Add a comment to the device-dax change. Dropped Dave's Ack as the

v1 -> v2:
- Don't change the resource name
- Rename the flag to MHP_NO_FIRMWARE_MEMMAP to reflect what it is doing
- Rephrase subjects/descriptions
- Use the flag for dax/kmem

[1] https://lkml.kernel.org/r/20200429160803.109056-1-david@redhat.com
[2] https://lkml.kernel.org/r/20200430102908.10107-1-david@redhat.com

David Hildenbrand (3):
  mm/memory_hotplug: Introduce add_memory_device_managed()
  kexec_file: Don't place kexec images on IORESOURCE_MEM_DRIVER_MANAGED
  device-dax: Add memory via add_memory_driver_managed()

 drivers/dax/kmem.c             |  8 ++++-
 include/linux/ioport.h         |  1 +
 include/linux/memory_hotplug.h |  2 ++
 kernel/kexec_file.c            |  5 +++
 mm/memory_hotplug.c            | 62 +++++++++++++++++++++++++++++++---
 5 files changed, 73 insertions(+), 5 deletions(-)

-- 
2.25.3
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
