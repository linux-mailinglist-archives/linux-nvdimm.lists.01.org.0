Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7908FC6E
	for <lists+linux-nvdimm@lfdr.de>; Fri, 16 Aug 2019 09:36:18 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2A583202E292C;
	Fri, 16 Aug 2019 00:38:09 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=pagupta@redhat.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 21BFA202C80AD
 for <linux-nvdimm@lists.01.org>; Fri, 16 Aug 2019 00:38:08 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 833BC369D3;
 Fri, 16 Aug 2019 07:36:15 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7302F19C6A;
 Fri, 16 Aug 2019 07:36:15 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com
 (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 5E8582551B;
 Fri, 16 Aug 2019 07:36:15 +0000 (UTC)
Date: Fri, 16 Aug 2019 03:36:14 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Message-ID: <1526809439.8842269.1565940974952.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAPcyv4gLqd43CLDuGYrDdx4xR1_oc3D0hzdETz8uQmV1C2Dp_Q@mail.gmail.com>
References: <20190731111207.12836-1-pagupta@redhat.com>
 <CAPcyv4gLqd43CLDuGYrDdx4xR1_oc3D0hzdETz8uQmV1C2Dp_Q@mail.gmail.com>
Subject: Re: [PATCH] libnvdimm: change disk name of virtio pmem disk
MIME-Version: 1.0
X-Originating-IP: [10.67.116.204, 10.4.195.21]
Thread-Topic: libnvdimm: change disk name of virtio pmem disk
Thread-Index: 9nluNaz18R3eUqbznRETd5vqCIb7PA==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Fri, 16 Aug 2019 07:36:15 +0000 (UTC)
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>


> >
> > This patch adds prefix 'v' in disk name for virtio pmem.
> > This differentiates virtio-pmem disks from the pmem disks.
> 
> I don't think the small matter that this device does not support
> MAP_SYNC warrants a separate naming scheme.  That said I do think we
> need to export this attribute in sysfs, likely at the region level,
> and then display that information in ndctl. This is distinct from the
> btt case where it is operating a different data consistency contract
> than baseline pmem.

o.k. I will look to add the information in sysfs and display using ndctl.

Thanks,
Pankaj

> >
> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > ---
> >  drivers/nvdimm/namespace_devs.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/nvdimm/namespace_devs.c
> > b/drivers/nvdimm/namespace_devs.c
> > index a16e52251a30..8e5d29266fb0 100644
> > --- a/drivers/nvdimm/namespace_devs.c
> > +++ b/drivers/nvdimm/namespace_devs.c
> > @@ -182,8 +182,12 @@ const char *nvdimm_namespace_disk_name(struct
> > nd_namespace_common *ndns,
> >                 char *name)
> >  {
> >         struct nd_region *nd_region = to_nd_region(ndns->dev.parent);
> > +       const char *prefix = "";
> >         const char *suffix = NULL;
> >
> > +       if (!is_nvdimm_sync(nd_region))
> > +               prefix = "v";
> > +
> >         if (ndns->claim && is_nd_btt(ndns->claim))
> >                 suffix = "s";
> >
> > @@ -201,7 +205,7 @@ const char *nvdimm_namespace_disk_name(struct
> > nd_namespace_common *ndns,
> >                         sprintf(name, "pmem%d.%d%s", nd_region->id, nsidx,
> >                                         suffix ? suffix : "");
> >                 else
> > -                       sprintf(name, "pmem%d%s", nd_region->id,
> > +                       sprintf(name, "%spmem%d%s", prefix, nd_region->id,
> >                                         suffix ? suffix : "");
> >         } else if (is_namespace_blk(&ndns->dev)) {
> >                 struct nd_namespace_blk *nsblk;
> > --
> > 2.20.1
> >
> 
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
