Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B613E2595F2
	for <lists+linux-nvdimm@lfdr.de>; Tue,  1 Sep 2020 17:58:12 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5AA431396FBF6;
	Tue,  1 Sep 2020 08:58:10 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=batv+00d723da4443b0556009+6218+infradead.org+hch@casper.srs.infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 11C8E125E5506
	for <linux-nvdimm@lists.01.org>; Tue,  1 Sep 2020 08:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=M79so1AwUwPIRouROFaNCg3KdKArTwMSMNd8wl3xC9I=; b=Fo1o7u6IVr6vurOMarEGQIw99y
	WHqyrdok/75XjmzAvs98wm2mZXYI8eGfVJCJLikO8fuOJu/9j6XvoFdlr1RTa038r8DDcHMqAU7lY
	mmSZLC/smn0SnolNwwxdyrpDJlJoZhG0K7MVmnl8ewTBrEYNYAPRaMnE4rjqCK7VlkM7JqAlUWyDU
	YkH9TJZ6yJEEibyeqV37+FBh0RkQQ6BwwzwRxyMvkU7/sD29/P1lImVmElLT8cbRAFklBxMxACP/P
	9Ptq9IU2Xfcl9fIpw/yp4N3MdH0FKE600v4IAuPUo366M4kD36FMV0WaYWth1qfPOYnF35tgpEEiP
	sE6GqZdg==;
Received: from [2001:4bb8:18c:45ba:2f95:e5:ca6b:9b4a] (helo=localhost)
	by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kD8fN-0004OS-MU; Tue, 01 Sep 2020 15:57:50 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: remove revalidate_disk()
Date: Tue,  1 Sep 2020 17:57:39 +0200
Message-Id: <20200901155748.2884-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: JEP6ERG3ERHDSYAWYUZIK24LGLBAFJYT
X-Message-ID-Hash: JEP6ERG3ERHDSYAWYUZIK24LGLBAFJYT
X-MailFrom: BATV+00d723da4443b0556009+6218+infradead.org+hch@casper.srs.infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Josef Bacik <josef@toxicpanda.com>, dm-devel@redhat.com, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, nbd@other.debian.org, ceph-devel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-raid@vger.kernel.org, linux-nvdimm@lists.01.org, linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JEP6ERG3ERHDSYAWYUZIK24LGLBAFJYT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Jens,

this series removes the revalidate_disk() function, which has been a
really odd duck in the last years.  The prime reason why most people
use it is because it propagates a size change from the gendisk to
the block_device structure.  But it also calls into the rather ill
defined ->revalidate_disk method which is rather useless for the
callers.  So this adds a new helper to just propagate the size, and
cleans up all kinds of mess around this area.  Follow on patches
will eventuall kill of ->revalidate_disk entirely, but ther are a lot
more patches needed for that.

Diffstat:
 Documentation/filesystems/locking.rst |    3 --
 block/genhd.c                         |    9 ++----
 drivers/block/nbd.c                   |    8 ++---
 drivers/block/rbd.c                   |    2 -
 drivers/block/rnbd/rnbd-clt.c         |   10 +------
 drivers/block/virtio_blk.c            |    2 -
 drivers/block/zram/zram_drv.c         |    4 +-
 drivers/md/dm-raid.c                  |    2 -
 drivers/md/md-cluster.c               |    6 ++--
 drivers/md/md-linear.c                |    2 -
 drivers/md/md.c                       |   10 +++----
 drivers/md/md.h                       |    2 -
 drivers/nvdimm/blk.c                  |    3 --
 drivers/nvdimm/btt.c                  |    3 --
 drivers/nvdimm/bus.c                  |    9 ++----
 drivers/nvdimm/nd.h                   |    2 -
 drivers/nvdimm/pmem.c                 |    3 --
 drivers/nvme/host/core.c              |   16 +++++++----
 drivers/scsi/sd.c                     |    6 ++--
 fs/block_dev.c                        |   46 ++++++++++++++++------------------
 include/linux/blk_types.h             |    4 ++
 include/linux/genhd.h                 |    6 ++--
 22 files changed, 74 insertions(+), 84 deletions(-)
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
