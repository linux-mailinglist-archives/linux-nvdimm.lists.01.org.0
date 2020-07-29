Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2046232230
	for <lists+linux-nvdimm@lfdr.de>; Wed, 29 Jul 2020 18:10:48 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5E53B126D6C54;
	Wed, 29 Jul 2020 09:10:47 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.120; helo=mga04.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CF42E126A2F81
	for <linux-nvdimm@lists.01.org>; Wed, 29 Jul 2020 09:10:45 -0700 (PDT)
IronPort-SDR: QIcPm/GkCQTP09mE3tsVxsesMQiCXk+FkpHJ06N0hvGgCnSTvSLD+ZNSm8drPQSuf9EtDGwjol
 pDx71F28rdxw==
X-IronPort-AV: E=McAfee;i="6000,8403,9697"; a="148907552"
X-IronPort-AV: E=Sophos;i="5.75,410,1589266800";
   d="scan'208";a="148907552"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2020 09:10:41 -0700
IronPort-SDR: i7X1v4Hd61tSPtOHwyapVU3DpUiuiiKjbknAuZyuu6ZTZld0mdwSsCKC4UI0xk0/Aw/dKSFeuh
 SD8kUQzhsvYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,410,1589266800";
   d="scan'208";a="290580949"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga006.jf.intel.com with ESMTP; 29 Jul 2020 09:10:40 -0700
Date: Wed, 29 Jul 2020 09:10:40 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Yasunori Goto <y-goto@fujitsu.com>
Subject: Re: Can we change the S_DAX flag immediately on XFS without dropping
 caches?
Message-ID: <20200729161040.GA1250504@iweiny-DESK2.sc.intel.com>
References: <9dc179147f6a47279d801445f3efeecc@G08CNEXMBPEKD04.g08.fujitsu.local>
 <20200728022059.GX2005@dread.disaster.area>
 <573feb69-bc38-8eb4-ee9b-7c49802eb737@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <573feb69-bc38-8eb4-ee9b-7c49802eb737@fujitsu.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: SKQUQVQAEEOGFPJA5ZNJQSAYQ5TA3PHK
X-Message-ID-Hash: SKQUQVQAEEOGFPJA5ZNJQSAYQ5TA3PHK
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Dave Chinner <david@fromorbit.com>, "Li, Hao" <lihao2018.fnst@cn.fujitsu.com>, "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SKQUQVQAEEOGFPJA5ZNJQSAYQ5TA3PHK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jul 29, 2020 at 11:23:21AM +0900, Yasunori Goto wrote:
> Hi,
> 
> On 2020/07/28 11:20, Dave Chinner wrote:
> > On Tue, Jul 28, 2020 at 02:00:08AM +0000, Li, Hao wrote:
> > > Hi,
> > > 
> > > I have noticed that we have to drop caches to make the changing of S_DAX
> > > flag take effect after using chattr +x to turn on DAX for a existing
> > > regular file. The related function is xfs_diflags_to_iflags, whose
> > > second parameter determines whether we should set S_DAX immediately.
> > Yup, as documented in Documentation/filesystems/dax.txt. Specifically:
> > 
> >   6. When changing the S_DAX policy via toggling the persistent FS_XFLAG_DAX flag,
> >      the change in behaviour for existing regular files may not occur
> >      immediately.  If the change must take effect immediately, the administrator
> >      needs to:
> > 
> >      a) stop the application so there are no active references to the data set
> >         the policy change will affect
> > 
> >      b) evict the data set from kernel caches so it will be re-instantiated when
> >         the application is restarted. This can be achieved by:
> > 
> >         i. drop-caches
> >         ii. a filesystem unmount and mount cycle
> >         iii. a system reboot
> > 
> > > I can't figure out why we do this. Is this because the page caches in
> > > address_space->i_pages are hard to deal with?
> > Because of unfixable races in the page fault path that prevent
> > changing the caching behaviour of the inode while concurrent access
> > is possible. The only way to guarantee races can't happen is to
> > cycle the inode out of cache.
> 
> I understand why the drop_cache operation is necessary. Thanks.
> 
> BTW, even normal user becomes to able to change DAX flag for an inode,
> drop_cache operation still requires root permission, right?
> 
> So, if kernel have a feature for normal user can operate drop cache for "a
> inode" with
> its permission, I think it improve the above limitation, and
> we would like to try to implement it recently.
> 
> Do you have any opinion making such feature?
> (Agree/opposition, or any other comment?)

I would not be opposed but there were many hurdles to that implementation.

What is the use case you are thinking of here?

The compromise of dropping caches was reached because we envisioned that many
users would simply want to chose the file mode when a file was created and
maintain that mode through the lifetime of the file.  To that end one can
simply create directories which have the desired dax mode and any files created
in that directory will inherit the dax mode immediately.  So there is no need
to switch the file mode directly as a normal user.

Would that work for your use case?

Ira

> 
> Thanks,
> 
> -- 
> Yasunori Goto
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
