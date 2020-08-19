Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D290124A924
	for <lists+linux-nvdimm@lfdr.de>; Thu, 20 Aug 2020 00:21:33 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 60A6C134BE06A;
	Wed, 19 Aug 2020 15:21:23 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.61; helo=us-smtp-delivery-1.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com [205.139.110.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C91BC134BE05C
	for <linux-nvdimm@lists.01.org>; Wed, 19 Aug 2020 15:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1597875679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RVpkWZgoV/McsG5/jmbAEgGEb94GIerA/7gyN/jgusE=;
	b=R5f9BcpyYzh0wLqULRDxukQxyr2hI7m0KR7SAy8pdiA90IHRQ47aAX86bYLg4VAZm8iSc/
	5MQoicXblMrcEmguUQFyJQKPh5xbbLh82LAWBmsHoLVXWoEW4d6jkuKlnjrJxs3H6xfL2g
	wpqVUtx+hWaiqQHhnSFkeJL27+x76g0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-Vhl7GqQLPZ6PGB3isPPanQ-1; Wed, 19 Aug 2020 18:21:02 -0400
X-MC-Unique: Vhl7GqQLPZ6PGB3isPPanQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3A88807332;
	Wed, 19 Aug 2020 22:21:00 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-197.rdu2.redhat.com [10.10.115.197])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3C85E5C893;
	Wed, 19 Aug 2020 22:20:54 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id BC4D3223C69; Wed, 19 Aug 2020 18:20:53 -0400 (EDT)
From: Vivek Goyal <vgoyal@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvdimm@lists.01.org,
	virtio-fs@redhat.com
Subject: [PATCH v3 00/18] virtiofs: Add DAX support
Date: Wed, 19 Aug 2020 18:19:38 -0400
Message-Id: <20200819221956.845195-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Message-ID-Hash: SNVYJCTZVGMQUYMYM26JGVFGXRUWN6SQ
X-Message-ID-Hash: SNVYJCTZVGMQUYMYM26JGVFGXRUWN6SQ
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: miklos@szeredi.hu, stefanha@redhat.com, dgilbert@redhat.com, Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@infradead.org>, "Michael S. Tsirkin" <mst@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SNVYJCTZVGMQUYMYM26JGVFGXRUWN6SQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi All,

This is V3 of patches. I had posted version v2 version here.

https://lore.kernel.org/linux-fsdevel/20200807195526.426056-1-vgoyal@redhat.com/

I have taken care of comments from V2. Changes from V2 are.

- Rebased patches on top of 5.9-rc1

- Renamed couple of functions to get rid of iomap prefix. (Dave Chinner)

- Modified truncate/punch_hole paths to serialize with dax fault
  path. For now did this only for dax paths. May be non-dax path
  can benefit from this too. But that is an option for a different
  day. (Dave Chinner).

- Took care of comments by Jan Kara in dax_layout_busy_page_range()
  implementation patch.

- Dropped one of the patches which forced sync release in
  fuse_file_put() path for DAX files. It was redundant now as virtiofs
  already sets fs_context->destroy which forces sync release. (Miklos)

- Took care of some of the errors flagged by checkpatch.pl.

Description from previous post
------------------------------

This patch series adds DAX support to virtiofs filesystem. This allows
bypassing guest page cache and allows mapping host page cache directly
in guest address space.

When a page of file is needed, guest sends a request to map that page
(in host page cache) in qemu address space. Inside guest this is
a physical memory range controlled by virtiofs device. And guest
directly maps this physical address range using DAX and hence gets
access to file data on host.

This can speed up things considerably in many situations. Also this
can result in substantial memory savings as file data does not have
to be copied in guest and it is directly accessed from host page
cache.

Most of the changes are limited to fuse/virtiofs. There are couple
of changes needed in generic dax infrastructure and couple of changes
in virtio to be able to access shared memory region.

Thanks
Vivek

Sebastien Boeuf (3):
  virtio: Add get_shm_region method
  virtio: Implement get_shm_region for PCI transport
  virtio: Implement get_shm_region for MMIO transport

Stefan Hajnoczi (2):
  virtio_fs, dax: Set up virtio_fs dax_device
  fuse,dax: add DAX mmap support

Vivek Goyal (13):
  dax: Modify bdev_dax_pgoff() to handle NULL bdev
  dax: Create a range version of dax_layout_busy_page()
  virtiofs: Provide a helper function for virtqueue initialization
  fuse: Get rid of no_mount_options
  fuse,virtiofs: Add a mount option to enable dax
  fuse,virtiofs: Keep a list of free dax memory ranges
  fuse: implement FUSE_INIT map_alignment field
  fuse: Introduce setupmapping/removemapping commands
  fuse, dax: Implement dax read/write operations
  fuse,virtiofs: Define dax address space operations
  fuse, dax: Serialize truncate/punch_hole and dax fault path
  fuse,virtiofs: Maintain a list of busy elements
  fuse,virtiofs: Add logic to free up a memory range

 drivers/dax/super.c                |    3 +-
 drivers/virtio/virtio_mmio.c       |   31 +
 drivers/virtio/virtio_pci_modern.c |   95 +++
 fs/dax.c                           |   29 +-
 fs/fuse/dir.c                      |   32 +-
 fs/fuse/file.c                     | 1198 +++++++++++++++++++++++++++-
 fs/fuse/fuse_i.h                   |  114 ++-
 fs/fuse/inode.c                    |  146 +++-
 fs/fuse/virtio_fs.c                |  279 ++++++-
 include/linux/dax.h                |    6 +
 include/linux/virtio_config.h      |   17 +
 include/uapi/linux/fuse.h          |   34 +-
 include/uapi/linux/virtio_fs.h     |    3 +
 include/uapi/linux/virtio_mmio.h   |   11 +
 include/uapi/linux/virtio_pci.h    |   11 +-
 15 files changed, 1933 insertions(+), 76 deletions(-)

Cc: Jan Kara <jack@suse.cz>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Vishal L Verma <vishal.l.verma@intel.com>
-- 
2.25.4
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
