Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E7515AE1D
	for <lists+linux-nvdimm@lfdr.de>; Wed, 12 Feb 2020 18:08:05 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1A75610FC3380;
	Wed, 12 Feb 2020 09:11:18 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.61; helo=us-smtp-delivery-1.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com [205.139.110.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 196851007B191
	for <linux-nvdimm@lists.01.org>; Wed, 12 Feb 2020 09:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1581527276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uVtVcsiKhkuKKf+gRgkYGjwkWDveu2K52NRmmgOy/F0=;
	b=KRBd1zRBi9AQzncaxbt68Uxp6ys3VIFemT1/XLg+2e+Uiatz9X2Ia1pIxQ43RcEPKR3oTP
	NtisM7HxVoFI08Du/pN8PvnrAAjqOt9ZGmj1KSiiRtGTmg4YknpA7t8kO0J331SI7kasyW
	uK87tDQF6LtB4IWgeJkB23+q8QixTwM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-w09-80CIMHqzsasM6BehBw-1; Wed, 12 Feb 2020 12:07:51 -0500
X-MC-Unique: w09-80CIMHqzsasM6BehBw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BCD1EDBA5;
	Wed, 12 Feb 2020 17:07:49 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2445C89F30;
	Wed, 12 Feb 2020 17:07:47 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id AAF6C220A24; Wed, 12 Feb 2020 12:07:46 -0500 (EST)
From: Vivek Goyal <vgoyal@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	linux-nvdimm@lists.01.org,
	dan.j.williams@intel.com,
	hch@infradead.org
Subject: [RFC PATCH 0/6] dax: Replace bdev_dax_pgoff() with dax_pgoff()
Date: Wed, 12 Feb 2020 12:07:27 -0500
Message-Id: <20200212170733.8092-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Message-ID-Hash: YTXY3PFQ3AB5BUUZ62SFCKMWU6YTIMSR
X-Message-ID-Hash: YTXY3PFQ3AB5BUUZ62SFCKMWU6YTIMSR
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: dm-devel@redhat.com, jack@suse.cz
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YTXY3PFQ3AB5BUUZ62SFCKMWU6YTIMSR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Currently dax code assumes that there is always a block device
associated with it. And block device is passed around in few routines. I
am implementing DAX support for virtiofs and there is no block device
while we are using dax device. So I need dax code to move away from
this assumption that there is always a block device.

We seem to pass around block deivce only to calculate the partition
offset into dax device. bdev_dax_pgoff() does get_start_sect(bdev).

There are two proposed solutions to this problem.

- Get rid of kernel partition support for pmem devices.

- Caller stores offset into dax device and passes that in along with
  dax_device.

First solution was discussed recently in this thread.

https://lore.kernel.org/linux-fsdevel/20200107125159.GA15745@infradead.org/

I feel we already shipped partition support for dax block devices and
going back now will be painful and its easy to break users out there
which are using partitions.

Hence I thought of writing patches for second proposal and see how bad
it looks. To me patches are fairly small and don't break backward 
compatibility and seem like a good step in the direction of removing
dax assumptions about block device.

So I am posting this RFC patch series, which is just boot tested.

Any feedback or comments are welcome.

Thanks
Vivek
 

Vivek Goyal (6):
  dax: Define a helper dax_pgoff() which takes in dax_offset as argument
  dax,iomap,ext4,ext2,xfs: Save dax_offset in "struct iomap"
  fs/dax.c: Start using dax_pgoff() instead of bdev_dax_pgoff()
  dax, dm/md: Use dax_pgoff() instead of bdev_dax_pgoff()
  drivers/dax: Use dax_pgoff() instead of bdev_dax_pgoff()
  dax: Remove bdev_dax_pgoff() helper

 drivers/dax/super.c        | 11 +++++------
 drivers/md/dm-linear.c     |  9 ++++++---
 drivers/md/dm-log-writes.c |  9 ++++++---
 drivers/md/dm-stripe.c     |  8 +++++---
 fs/dax.c                   | 13 ++++++-------
 fs/ext2/inode.c            |  1 +
 fs/ext4/inode.c            |  1 +
 fs/xfs/xfs_iomap.c         |  2 ++
 include/linux/dax.h        |  2 +-
 include/linux/iomap.h      |  1 +
 10 files changed, 34 insertions(+), 23 deletions(-)

-- 
2.20.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
