Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4581510B3
	for <lists+linux-nvdimm@lfdr.de>; Mon,  3 Feb 2020 21:01:28 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F306810FC338C;
	Mon,  3 Feb 2020 12:04:27 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.120; helo=us-smtp-1.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [207.211.31.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 689BA10FC338A
	for <linux-nvdimm@lists.01.org>; Mon,  3 Feb 2020 12:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1580760066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Mq7eC6RWo7NxMEeb9FO/cFzew1eeG07ZdDsPtcMILro=;
	b=gzMWaasP+IfEcPQZpA1UTP7F0CZM6oT0bZVisp3rsvKqT9IqkB18o40NJ8rWOWk37O9sCK
	oo99fCqFwbvekGtNhxucrFTF5YwV8dkotDCH719xB4GIRN1ESqUivizfByYFY6nI0tNbE9
	VB4UVt9XPsv1REvyWrGsFCJ3w2+DhK4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-uWyTju_KPoeAry3qqPmknA-1; Mon, 03 Feb 2020 15:00:50 -0500
X-MC-Unique: uWyTju_KPoeAry3qqPmknA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04E7E800D41;
	Mon,  3 Feb 2020 20:00:49 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 701831001B09;
	Mon,  3 Feb 2020 20:00:46 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id 058A92202E9; Mon,  3 Feb 2020 15:00:45 -0500 (EST)
From: Vivek Goyal <vgoyal@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	linux-nvdimm@lists.01.org,
	dan.j.williams@intel.com,
	hch@infradead.org
Subject: [RFC PATCH 0/5][V2] dax,pmem: Provide a dax operation to zero range of memory
Date: Mon,  3 Feb 2020 15:00:24 -0500
Message-Id: <20200203200029.4592-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Message-ID-Hash: VCUOFKUGBYIRZ6OLILWCTDYDRZWZ5K44
X-Message-ID-Hash: VCUOFKUGBYIRZ6OLILWCTDYDRZWZ5K44
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: dm-devel@redhat.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VCUOFKUGBYIRZ6OLILWCTDYDRZWZ5K44/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

This is V2 of patches. I posted V1 here.

https://lore.kernel.org/linux-fsdevel/20200123165249.GA7664@redhat.com/

Changes since V1.
- Took care of feedback from Christoph.
- Made ->zero_page_range() mandatory operation.
- Provided a generic helper to zero range for non-pmem drivers.
- Merged __dax_zero_page_range() and iomap_dax_zero()
- Made changes to dm drivers.
- Limited range zeroing to with-in single page.
- Tested patches with real hardware.  

description
-----------
This is an RFC patch series to provide a dax operation to zero a range of
memory. It will also clear poison in the process.

Motivation from this patch comes from Christoph's feedback that he will
rather prefer a dax way to zero a range instead of relying on having to
call blkdev_issue_zeroout() in __dax_zero_page_range().

https://lkml.org/lkml/2019/8/26/361

My motivation for this change is virtiofs DAX support. There we use DAX
but we don't have a block device. So any dax code which has the assumption
that there is always a block device associated is a problem. So this
is more of a cleanup of one of the places where dax has this dependency
on block device and if we add a dax operation for zeroing a range, it
can help with not having to call blkdev_issue_zeroout() in dax path.

Thanks
Vivek

Vivek Goyal (5):
  dax, pmem: Add a dax operation zero_page_range
  s390,dax: Add dax zero_page_range operation to dcssblk driver
  dm,dax: Add dax zero_page_range operation
  dax,iomap: Start using dax native zero_page_range()
  dax,iomap: Add helper dax_iomap_zero() to zero a range

 drivers/dax/super.c           | 20 ++++++++++++
 drivers/md/dm-linear.c        | 18 +++++++++++
 drivers/md/dm-log-writes.c    | 17 ++++++++++
 drivers/md/dm-stripe.c        | 23 ++++++++++++++
 drivers/md/dm.c               | 30 ++++++++++++++++++
 drivers/nvdimm/pmem.c         | 50 +++++++++++++++++++++++++++++
 drivers/s390/block/dcssblk.c  |  7 ++++
 fs/dax.c                      | 60 ++++++++++++++---------------------
 fs/iomap/buffered-io.c        |  9 +-----
 include/linux/dax.h           | 17 ++++++----
 include/linux/device-mapper.h |  3 ++
 11 files changed, 204 insertions(+), 50 deletions(-)

-- 
2.18.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
