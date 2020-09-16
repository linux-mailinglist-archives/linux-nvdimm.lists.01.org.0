Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CAF26C202
	for <lists+linux-nvdimm@lfdr.de>; Wed, 16 Sep 2020 13:19:11 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BEE7E14321B65;
	Wed, 16 Sep 2020 04:19:09 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=jack@suse.cz; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 48C4D14321B65
	for <linux-nvdimm@lists.01.org>; Wed, 16 Sep 2020 04:19:06 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id B0AF6ACBF;
	Wed, 16 Sep 2020 11:19:20 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
	id 08DA11E12E1; Wed, 16 Sep 2020 13:19:05 +0200 (CEST)
Date: Wed, 16 Sep 2020 13:19:05 +0200
From: Jan Kara <jack@suse.cz>
To: Adrian Huang12 <ahuang12@lenovo.com>
Subject: Re: [External]  Re: [PATCH 1/1] dax: Fix stack overflow when
 mounting fsdax pmem device
Message-ID: <20200916111904.GD3607@quack2.suse.cz>
References: <20200915075729.12518-1-adrianhuang0701@gmail.com>
 <20200915083716.GA29863@quack2.suse.cz>
 <HK2PR0302MB25945D758119BECF62C7DC73B3210@HK2PR0302MB2594.apcprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <HK2PR0302MB25945D758119BECF62C7DC73B3210@HK2PR0302MB2594.apcprd03.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: ZCKRVHQHTYE3ICLAPJF4KX5XFG7D7D42
X-Message-ID-Hash: ZCKRVHQHTYE3ICLAPJF4KX5XFG7D7D42
X-MailFrom: jack@suse.cz
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jan Kara <jack@suse.cz>, Adrian Huang <adrianhuang0701@gmail.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Coly Li <colyli@suse.de>, Mikulas Patocka <mpatocka@redhat.com>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZCKRVHQHTYE3ICLAPJF4KX5XFG7D7D42/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed 16-09-20 07:02:12, Adrian Huang12 wrote:
> > -----Original Message-----
> > From: Jan Kara <jack@suse.cz>
> > 
> > I'm not sure how you can get __generic_fsdax_supported() called for dm-0?
> > Possibly because there's another dm device stacked on top of it and
> > dm_table_supports_dax() calls generic_fsdax_supported()? That actually seems
> > to be a bug in dm_table_supports_dax() (device_supports_dax() in particular).
> > I'd think it should be calling dax_supported() instead of
> > generic_fsdax_supported() so that proper device callback gets called when
> > determining whether a device supports DAX or not.
> > 
> 
> Yes, you're right. There's another dm device stacked on top of it. 
> 
> When applying the following patch and running 'lvm2-testsuite --only activate-minor.sh', the following error messages are observed.
> 
> dm-3: error: dax access failed (-95)
> dm-3: error: dax access failed (-95)
> dm-3: error: dax access failed (-95)

Right, and that's result of the problem I also describe above. Attached
patch should fix these errors.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--tThc/1wpZn/ma/RB
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-dm-Call-proper-helper-to-determine-dax-support.patch"

From edb67c5b213526a169c13cefbebc26b3ce8ad959 Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Wed, 16 Sep 2020 13:08:44 +0200
Subject: [PATCH] dm: Call proper helper to determine dax support

DM was calling generic_fsdax_supported() to determine whether a device
referenced in the DM table supports DAX. However this is a helper for "leaf" device drivers so that
they don't have to duplicate common generic checks. High level code
should call dax_supported() helper which that calls into appropriate
helper for the particular device. This problem manifested itself as
kernel messages:

dm-3: error: dax access failed (-95)

when lvm2-testsuite run in cases where a DM device was stacked on top of
another DM device.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 drivers/dax/super.c   |  1 +
 drivers/md/dm-table.c |  3 +--
 include/linux/dax.h   | 11 +++++++++--
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index e5767c83ea23..533230bef33c 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -330,6 +330,7 @@ bool dax_supported(struct dax_device *dax_dev, struct block_device *bdev,
 
 	return dax_dev->ops->dax_supported(dax_dev, bdev, blocksize, start, len);
 }
+EXPORT_SYMBOL_GPL(dax_supported);
 
 size_t dax_copy_from_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
 		size_t bytes, struct iov_iter *i)
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 5edc3079e7c1..bed1ff0744ec 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -862,8 +862,7 @@ int device_supports_dax(struct dm_target *ti, struct dm_dev *dev,
 {
 	int blocksize = *(int *) data;
 
-	return generic_fsdax_supported(dev->dax_dev, dev->bdev, blocksize,
-				       start, len);
+	return dax_supported(dev->dax_dev, dev->bdev, blocksize, start, len);
 }
 
 /* Check devices support synchronous DAX */
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 6904d4e0b2e0..9f916326814a 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -130,6 +130,8 @@ static inline bool generic_fsdax_supported(struct dax_device *dax_dev,
 	return __generic_fsdax_supported(dax_dev, bdev, blocksize, start,
 			sectors);
 }
+bool dax_supported(struct dax_device *dax_dev, struct block_device *bdev,
+		int blocksize, sector_t start, sector_t len);
 
 static inline void fs_put_dax(struct dax_device *dax_dev)
 {
@@ -157,6 +159,13 @@ static inline bool generic_fsdax_supported(struct dax_device *dax_dev,
 	return false;
 }
 
+static inline bool dax_supported(struct dax_device *dax_dev,
+		struct block_device *bdev, int blocksize, sector_t start,
+		sector_t len)
+{
+	return false;
+}
+
 static inline void fs_put_dax(struct dax_device *dax_dev)
 {
 }
@@ -195,8 +204,6 @@ bool dax_alive(struct dax_device *dax_dev);
 void *dax_get_private(struct dax_device *dax_dev);
 long dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff, long nr_pages,
 		void **kaddr, pfn_t *pfn);
-bool dax_supported(struct dax_device *dax_dev, struct block_device *bdev,
-		int blocksize, sector_t start, sector_t len);
 size_t dax_copy_from_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
 		size_t bytes, struct iov_iter *i);
 size_t dax_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
-- 
2.16.4


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

--tThc/1wpZn/ma/RB--
