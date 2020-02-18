Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73323163570
	for <lists+linux-nvdimm@lfdr.de>; Tue, 18 Feb 2020 22:49:28 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 65D9410FC35AF;
	Tue, 18 Feb 2020 13:50:04 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.81; helo=us-smtp-delivery-1.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com [207.211.31.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D11DD10FC35AE
	for <linux-nvdimm@lists.01.org>; Tue, 18 Feb 2020 13:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1582062548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1p+PXNm2PJYLW1uVQOTPJCQ5UcLMDsrk6u8/ZoFcnWE=;
	b=SGZKUsZFTLiUEQQkuEM0jfJJFYFZkF3U5Fp61t9LTKXS/jj98nWJaFitGbP7k56QQhWMG4
	9bRg03ENFRfmoZhEqrFlmo9pJmo2j5o+CednUxWFXn2Bi0b3PZ5DuEIToVbnG0IrsDfPmr
	P/rRa7RpBXC9ZnqDBZDCYbdVQXIlHY0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-Cb2kwYg5MtaqK_KBzRzjrA-1; Tue, 18 Feb 2020 16:48:57 -0500
X-MC-Unique: Cb2kwYg5MtaqK_KBzRzjrA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB46010CE784;
	Tue, 18 Feb 2020 21:48:55 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 08AC790534;
	Tue, 18 Feb 2020 21:48:53 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id 8A4B52257D2; Tue, 18 Feb 2020 16:48:52 -0500 (EST)
From: Vivek Goyal <vgoyal@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	linux-nvdimm@lists.01.org,
	hch@infradead.org,
	dan.j.williams@intel.com
Subject: [PATCH v5 0/8] dax/pmem: Provide a dax operation to zero range of memory
Date: Tue, 18 Feb 2020 16:48:33 -0500
Message-Id: <20200218214841.10076-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Message-ID-Hash: 4OFLSEM2KM6KCI5VBHQO5CIDC5JFQZU5
X-Message-ID-Hash: 4OFLSEM2KM6KCI5VBHQO5CIDC5JFQZU5
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: dm-devel@redhat.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4OFLSEM2KM6KCI5VBHQO5CIDC5JFQZU5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi, 

This is V5 of patches. These patches are also available at.

https://github.com/rhvgoyal/linux/commits/dax-zero-range-v5

Changes since V4:

- Rebased on top of 5.6-rc2
- Added a separate patch so that pmem_clear_poison() accepts arbitrary
  offset and len and aligns these as needed. This takes away the burden
  of aligning from callers.

Previous versions of patches are here.
v4:
https://lore.kernel.org/linux-fsdevel/20200217181653.4706-1-vgoyal@redhat.com/
v3:
https://lore.kernel.org/linux-fsdevel/20200214125717.GA18654@redhat.com/T/#t
v2:
https://lore.kernel.org/linux-fsdevel/20200203200029.4592-1-vgoyal@redhat.com/
v1:
https://lore.kernel.org/linux-fsdevel/20200123165249.GA7664@redhat.com/

Thanks
Vivek

Vivek Goyal (8):
  pmem: Add functions for reading/writing page to/from pmem
  drivers/pmem: Allow pmem_clear_poison() to accept arbitrary offset and
    len
  pmem: Enable pmem_do_write() to deal with arbitrary ranges
  dax, pmem: Add a dax operation zero_page_range
  s390,dcssblk,dax: Add dax zero_page_range operation to dcssblk driver
  dm,dax: Add dax zero_page_range operation
  dax,iomap: Start using dax native zero_page_range()
  dax,iomap: Add helper dax_iomap_zero() to zero a range

 drivers/dax/super.c           |  19 +++++
 drivers/md/dm-linear.c        |  21 ++++++
 drivers/md/dm-log-writes.c    |  19 +++++
 drivers/md/dm-stripe.c        |  26 +++++++
 drivers/md/dm.c               |  31 ++++++++
 drivers/nvdimm/pmem.c         | 134 +++++++++++++++++++++++-----------
 drivers/s390/block/dcssblk.c  |  17 +++++
 fs/dax.c                      |  53 ++++----------
 fs/iomap/buffered-io.c        |   9 +--
 include/linux/dax.h           |  20 ++---
 include/linux/device-mapper.h |   3 +
 11 files changed, 246 insertions(+), 106 deletions(-)

-- 
2.20.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
