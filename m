Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0345173D09
	for <lists+linux-nvdimm@lfdr.de>; Fri, 28 Feb 2020 17:35:26 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4B64C10FC36ED;
	Fri, 28 Feb 2020 08:36:16 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.61; helo=us-smtp-delivery-1.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com [205.139.110.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E0D4410FC3370
	for <linux-nvdimm@lists.01.org>; Fri, 28 Feb 2020 08:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1582907719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fHdhFTbN6MmSbeB96emcKmmClPxoPnJtYjBRwbsxQXA=;
	b=VPjMrldeCywOSzJwshJiVFxDMK9ko15lvARkt2+Sg7KJt6xrq2DbToeL6YF94gsuuVP6nw
	77rxBlV2GgexnmIWsP30J+DEL3t0YNdrQLDiJ1HnGLoSIqOUJ6/tEL7ZDvVysoacxt6s8H
	M0X1mrrhLywbpdWrkDTAXsdXcUwcShI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-Q4Rf6BBGOCyJsuNU7mjueg-1; Fri, 28 Feb 2020 11:35:15 -0500
X-MC-Unique: Q4Rf6BBGOCyJsuNU7mjueg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12855107ACC5;
	Fri, 28 Feb 2020 16:35:14 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2B48A90F5B;
	Fri, 28 Feb 2020 16:35:11 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id BED052257D2; Fri, 28 Feb 2020 11:35:10 -0500 (EST)
From: Vivek Goyal <vgoyal@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	linux-nvdimm@lists.01.org,
	hch@infradead.org,
	dan.j.williams@intel.com
Subject: [PATCH v6 0/6] dax/pmem: Provide a dax operation to zero page range
Date: Fri, 28 Feb 2020 11:34:50 -0500
Message-Id: <20200228163456.1587-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Message-ID-Hash: YEZ2CLLFDWWMRWGVHVODNE7T4GOLSYWL
X-Message-ID-Hash: YEZ2CLLFDWWMRWGVHVODNE7T4GOLSYWL
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: david@fromorbit.com, dm-devel@redhat.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YEZ2CLLFDWWMRWGVHVODNE7T4GOLSYWL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

This is V6 of patches. These patches are also available at.

Changes since V5:

- Dan Williams preferred ->zero_page_range() to only accept PAGE_SIZE
  aligned request and clear poison only on page size aligned zeroing. So
  I changed it accordingly. 

- Dropped all the modifications which were required to support arbitrary
  range zeroing with-in a page.

- This patch series also fixes the issue where "truncate -s 512 foo.txt"
  will fail if first sector of file is poisoned. Currently it succeeds
  and filesystem expectes whole of the filesystem block to be free of
  poison at the end of the operation.

Christoph, I have dropped your Reviewed-by tag on 1-2 patches because
these patches changed substantially. Especially signature of of
dax zero_page_range() helper.

Thanks
Vivek

Vivek Goyal (6):
  pmem: Add functions for reading/writing page to/from pmem
  dax, pmem: Add a dax operation zero_page_range
  s390,dcssblk,dax: Add dax zero_page_range operation to dcssblk driver
  dm,dax: Add dax zero_page_range operation
  dax: Use new dax zero page method for zeroing a page
  dax,iomap: Add helper dax_iomap_zero() to zero a range

 drivers/dax/super.c           | 20 ++++++++
 drivers/md/dm-linear.c        | 18 +++++++
 drivers/md/dm-log-writes.c    | 17 ++++++
 drivers/md/dm-stripe.c        | 23 +++++++++
 drivers/md/dm.c               | 30 +++++++++++
 drivers/nvdimm/pmem.c         | 97 ++++++++++++++++++++++-------------
 drivers/s390/block/dcssblk.c  | 15 ++++++
 fs/dax.c                      | 59 ++++++++++-----------
 fs/iomap/buffered-io.c        |  9 +---
 include/linux/dax.h           | 21 +++-----
 include/linux/device-mapper.h |  3 ++
 11 files changed, 221 insertions(+), 91 deletions(-)

-- 
2.20.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
