Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34AE5271F73
	for <lists+linux-nvdimm@lfdr.de>; Mon, 21 Sep 2020 11:58:09 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5B8AE14462382;
	Mon, 21 Sep 2020 02:58:07 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=jack@suse.cz; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id F2DB914462380
	for <linux-nvdimm@lists.01.org>; Mon, 21 Sep 2020 02:58:04 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id 9BB5BB019;
	Mon, 21 Sep 2020 09:58:39 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
	id 4361B1E12E1; Mon, 21 Sep 2020 11:58:03 +0200 (CEST)
Date: Mon, 21 Sep 2020 11:58:03 +0200
From: Jan Kara <jack@suse.cz>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH v2] dm: Call proper helper to determine dax support
Message-ID: <20200921095803.GE5862@quack2.suse.cz>
References: <160040692945.25320.13233625491405115889.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CA+G9fYud7x0TfTDNWHa_0hzYHNQyet-a2==gQzDaZKXywY1meg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Pk6IbRAofICFmK5e"
Content-Disposition: inline
In-Reply-To: <CA+G9fYud7x0TfTDNWHa_0hzYHNQyet-a2==gQzDaZKXywY1meg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Content-Transfer-Encoding: 7bit
Message-ID-Hash: O5JUPZM3DBJGE3LEGLW4ENTXWSYOA6EK
X-Message-ID-Hash: O5JUPZM3DBJGE3LEGLW4ENTXWSYOA6EK
X-MailFrom: jack@suse.cz
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jan Kara <jack@suse.cz>, linux-nvdimm@lists.01.org, linux- stable <stable@vger.kernel.org>, Adrian Huang <ahuang12@lenovo.com>, Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com, open list <linux-kernel@vger.kernel.org>, mpatocka@redhat.com, lkft-triage@lists.linaro.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/O5JUPZM3DBJGE3LEGLW4ENTXWSYOA6EK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>


--Pk6IbRAofICFmK5e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 21-09-20 11:23:07, Naresh Kamboju wrote:
> On Fri, 18 Sep 2020 at 11:18, Dan Williams <dan.j.williams@intel.com> w=
rote:
> >
> > From: Jan Kara <jack@suse.cz>
> >
> > DM was calling generic_fsdax_supported() to determine whether a devic=
e
> > referenced in the DM table supports DAX. However this is a helper for=
 "leaf" device drivers so that
> > they don't have to duplicate common generic checks. High level code
> > should call dax_supported() helper which that calls into appropriate
> > helper for the particular device. This problem manifested itself as
> > kernel messages:
> >
> > dm-3: error: dax access failed (-95)
> >
> > when lvm2-testsuite run in cases where a DM device was stacked on top=
 of
> > another DM device.
> >
> > Fixes: 7bf7eac8d648 ("dax: Arrange for dax_supported check to span mu=
ltiple devices")
> > Cc: <stable@vger.kernel.org>
> > Tested-by: Adrian Huang <ahuang12@lenovo.com>
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > Acked-by: Mike Snitzer <snitzer@redhat.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> > Changes since v1 [1]:
> > - Add missing dax_read_lock() around dax_supported()
> >
> > [1]: http://lore.kernel.org/r/20200916151445.450-1-jack@suse.cz
> >
> >  drivers/dax/super.c   |    4 ++++
> >  drivers/md/dm-table.c |   10 +++++++---
> >  include/linux/dax.h   |   11 +++++++++--
> >  3 files changed, 20 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> > index e5767c83ea23..b6284c5cae0a 100644
> > --- a/drivers/dax/super.c
> > +++ b/drivers/dax/super.c
> > @@ -325,11 +325,15 @@ EXPORT_SYMBOL_GPL(dax_direct_access);
> >  bool dax_supported(struct dax_device *dax_dev, struct block_device *=
bdev,
> >                 int blocksize, sector_t start, sector_t len)
> >  {
> > +       if (!dax_dev)
> > +               return false;
> > +
> >         if (!dax_alive(dax_dev))
> >                 return false;
> >
> >         return dax_dev->ops->dax_supported(dax_dev, bdev, blocksize, =
start, len);
> >  }
> > +EXPORT_SYMBOL_GPL(dax_supported);
>=20
> arm build error while building with allmodconfig.
>=20
> ../drivers/dax/super.c:325:6: error: redefinition of =E2=80=98dax_suppo=
rted=E2=80=99
>   325 | bool dax_supported(struct dax_device *dax_dev, struct
> block_device *bdev,
>       |      ^~~~~~~~~~~~~
> In file included from ../drivers/dax/super.c:16:
> ../include/linux/dax.h:162:20: note: previous definition of
> =E2=80=98dax_supported=E2=80=99 was here
>   162 | static inline bool dax_supported(struct dax_device *dax_dev,
>       |                    ^~~~~~~~~~~~~
> make[3]: *** [../scripts/Makefile.build:283: drivers/dax/super.o] Error=
 1
>=20
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
>=20
> Ref:
> https://builds.tuxbuild.com/IO690jFQDp0qP9zFuWBqpA/build.log

Thanks for report! Attached patch should fix the build (at least I've
tested it with CONFIG_DAX && CONFIG_FS_DAX, CONFIG_DAX && !CONFIG_FS_DAX,
and !CONFIG_DAX cases). Dan can you please merge the fix?

								Honza
--=20
Jan Kara <jack@suse.com>
SUSE Labs, CR

--Pk6IbRAofICFmK5e
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-dax-Fix-compilation-for-CONFIG_DAX-CONFIG_FS_DAX.patch"

From c48c9d1ee41ca17561dfd7ec5247b5afc527d40e Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Mon, 21 Sep 2020 11:33:23 +0200
Subject: [PATCH] dax: Fix compilation for CONFIG_DAX && !CONFIG_FS_DAX

dax_supported() is defined whenever CONFIG_DAX is enabled. So dummy
implementation should be defined only in !CONFIG_DAX case, not in
!CONFIG_FS_DAX case.

Fixes: e2ec51282545 ("dm: Call proper helper to determine dax support")
Cc: <stable@vger.kernel.org>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 include/linux/dax.h | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/include/linux/dax.h b/include/linux/dax.h
index 497031392e0a..43b39ab9de1a 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -58,6 +58,8 @@ static inline void set_dax_synchronous(struct dax_device *dax_dev)
 {
 	__set_dax_synchronous(dax_dev);
 }
+bool dax_supported(struct dax_device *dax_dev, struct block_device *bdev,
+		int blocksize, sector_t start, sector_t len);
 /*
  * Check if given mapping is supported by the file / underlying device.
  */
@@ -104,6 +106,12 @@ static inline bool dax_synchronous(struct dax_device *dax_dev)
 static inline void set_dax_synchronous(struct dax_device *dax_dev)
 {
 }
+static inline bool dax_supported(struct dax_device *dax_dev,
+		struct block_device *bdev, int blocksize, sector_t start,
+		sector_t len)
+{
+	return false;
+}
 static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
 				struct dax_device *dax_dev)
 {
@@ -130,8 +138,6 @@ static inline bool generic_fsdax_supported(struct dax_device *dax_dev,
 	return __generic_fsdax_supported(dax_dev, bdev, blocksize, start,
 			sectors);
 }
-bool dax_supported(struct dax_device *dax_dev, struct block_device *bdev,
-		int blocksize, sector_t start, sector_t len);
 
 static inline void fs_put_dax(struct dax_device *dax_dev)
 {
@@ -159,13 +165,6 @@ static inline bool generic_fsdax_supported(struct dax_device *dax_dev,
 	return false;
 }
 
-static inline bool dax_supported(struct dax_device *dax_dev,
-		struct block_device *bdev, int blocksize, sector_t start,
-		sector_t len)
-{
-	return false;
-}
-
 static inline void fs_put_dax(struct dax_device *dax_dev)
 {
 }
-- 
2.16.4


--Pk6IbRAofICFmK5e
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

--Pk6IbRAofICFmK5e--
