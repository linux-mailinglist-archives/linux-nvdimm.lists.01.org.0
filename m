Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9752EA336
	for <lists+linux-nvdimm@lfdr.de>; Tue,  5 Jan 2021 03:13:51 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7ABF8100EC1D6;
	Mon,  4 Jan 2021 18:13:49 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.31; helo=mga06.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 16871100EC1D1
	for <linux-nvdimm@lists.01.org>; Mon,  4 Jan 2021 18:13:47 -0800 (PST)
IronPort-SDR: CZ24SqlxAGy/Zyt1J5AChBoajvVZGmAnAcI51XMhqqIjkdZjmNusQlgW16y1XPJSdkzjj6F3F8
 IpW9rV7LzUWQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="238590162"
X-IronPort-AV: E=Sophos;i="5.78,475,1599548400";
   d="scan'208";a="238590162"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2021 18:13:45 -0800
IronPort-SDR: /QYSAF+tuWgKCIFBQZLiICHKkGWylSoiNZp39SysTo/J9Xa4sPH1Ke+sjoWmZ8cElkK04gNuBc
 GiR7CtHbt49w==
X-IronPort-AV: E=Sophos;i="5.78,475,1599548400";
   d="scan'208";a="378668580"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2021 18:13:45 -0800
Date: Mon, 4 Jan 2021 18:13:45 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] libnvdimm/pmem: remove unused header.
Message-ID: <20210105021345.GK3097896@iweiny-DESK2.sc.intel.com>
References: <20201225013546.300116-1-jianpeng.ma@intel.com>
 <20201228171758.GO1563847@iweiny-DESK2.sc.intel.com>
 <CAPcyv4gm-CnOAYqNYL29TUCQF04f9uCQOgF1ndRpu=_7e6T_kQ@mail.gmail.com>
 <20210104221858.GJ3097896@iweiny-DESK2.sc.intel.com>
 <CAPcyv4gb3ONLZRtgwrf1toT0o3=_Ke2agdSGjJW3b5mEECf4kA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4gb3ONLZRtgwrf1toT0o3=_Ke2agdSGjJW3b5mEECf4kA@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: ZQODRH2VVWDKDD6UDS7N3FEK6VXWD6LH
X-Message-ID-Hash: ZQODRH2VVWDKDD6UDS7N3FEK6VXWD6LH
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Jianpeng Ma <jianpeng.ma@intel.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Christoph Hellwig <hch@lst.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZQODRH2VVWDKDD6UDS7N3FEK6VXWD6LH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jan 04, 2021 at 02:32:06PM -0800, Dan Williams wrote:
> On Mon, Jan 4, 2021 at 2:19 PM Ira Weiny <ira.weiny@intel.com> wrote:
> >
> > On Mon, Jan 04, 2021 at 01:16:32PM -0800, Dan Williams wrote:
> > > On Mon, Dec 28, 2020 at 9:18 AM Ira Weiny <ira.weiny@intel.com> wrote:
> > > >
> > > > On Fri, Dec 25, 2020 at 09:35:46AM +0800, Jianpeng Ma wrote:
> > > > > 'commit a8b456d01cd6 ("bdi: remove BDI_CAP_SYNCHRONOUS_IO")' forgot
> > > >
> > > > This information should be part of a fixes tag.
> > >
> > > Oh, I was just about to comment "don't provide a Fixes tag for pure
> > > cleanups". Fixes is for functional issues that a backporter should
> > > consider.
> >
> > I thought this was discussed recently and it was concluded that 'fixes' does
> > not indicate something should be backported?
> >
> > ...
> >
> > https://lore.kernel.org/lkml/X8flmVAwl0158872@kroah.com/
> >
> > At least that is what Greg KH said.  But Dave C. was not happy with this...
> 
> I was thinking of it more from the distro automation tooling that I
> know fires up it sees a "Fixes" tag. At a minimum this would make
> those systems / humans fire up just to notice, "oh, just a plain
> cleanup with no logical side-effects".

I'm not really following but I don't think it is a big deal either way.  It
just seemed like the text used looked like a 'fixes' line and seemed ok to put
in there.

In this case it is probably fine.

Sorry for the noise,
Ira
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
