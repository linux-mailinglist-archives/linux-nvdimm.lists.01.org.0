Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 921E126C404
	for <lists+linux-nvdimm@lfdr.de>; Wed, 16 Sep 2020 17:08:49 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A6F6C13FE81D5;
	Wed, 16 Sep 2020 08:08:47 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=jack@suse.cz; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DA9A013FE81D3
	for <linux-nvdimm@lists.01.org>; Wed, 16 Sep 2020 08:08:44 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id B2334ABCC;
	Wed, 16 Sep 2020 15:08:58 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
	id 08FF41E12E1; Wed, 16 Sep 2020 17:08:42 +0200 (CEST)
Date: Wed, 16 Sep 2020 17:08:42 +0200
From: Jan Kara <jack@suse.cz>
To: Adrian Huang12 <ahuang12@lenovo.com>
Subject: Re: [External]  Re: [PATCH 1/1] dax: Fix stack overflow when
 mounting fsdax pmem device
Message-ID: <20200916150842.GJ3607@quack2.suse.cz>
References: <20200915075729.12518-1-adrianhuang0701@gmail.com>
 <20200915083716.GA29863@quack2.suse.cz>
 <HK2PR0302MB25945D758119BECF62C7DC73B3210@HK2PR0302MB2594.apcprd03.prod.outlook.com>
 <20200916111904.GD3607@quack2.suse.cz>
 <HK2PR0302MB2594F6503ECF4BAEDF76E9F4B3210@HK2PR0302MB2594.apcprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <HK2PR0302MB2594F6503ECF4BAEDF76E9F4B3210@HK2PR0302MB2594.apcprd03.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: D4U7IDZOPF5UK24OC5XPEZWNDYGTG5EA
X-Message-ID-Hash: D4U7IDZOPF5UK24OC5XPEZWNDYGTG5EA
X-MailFrom: jack@suse.cz
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jan Kara <jack@suse.cz>, Adrian Huang <adrianhuang0701@gmail.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Coly Li <colyli@suse.de>, Mikulas Patocka <mpatocka@redhat.com>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/D4U7IDZOPF5UK24OC5XPEZWNDYGTG5EA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed 16-09-20 14:02:19, Adrian Huang12 wrote:
> > -----Original Message-----
> > From: Jan Kara <jack@suse.cz>
> > Sent: Wednesday, September 16, 2020 7:19 PM
> > >
> > > dm-3: error: dax access failed (-95)
> > > dm-3: error: dax access failed (-95)
> > > dm-3: error: dax access failed (-95)
> > 
> > Right, and that's result of the problem I also describe above. Attached patch
> > should fix these errors.
> 
> The patch introduces the following panic during boot. Apparently, the
> dax_dev is NULL in dax_supported(). So, the address 0x00000000000002d0 is
> offset of the member 'flags' in struct dax_device (the member 'flags' is
> referenced in dax_alive()):

Thanks for testing!

> The following patch solves the panic. Feel free to add it to your patch. 

I've added you fixup to the patch. Thanks for it.
 
> BTW, feel free to add my tested-by to your patch after including the following patch to your patch (I don't see any dax error messages when running lvm2-testsuite).
> Tested-by: Adrian Huang <ahuang12@lenovo.com>
> 
> Thanks for looking into the issue triggered by lvm2-testsuite.
> 
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index 0d2dcbb1e549..e84070b55463 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -325,6 +325,9 @@ EXPORT_SYMBOL_GPL(dax_direct_access);
>  bool dax_supported(struct dax_device *dax_dev, struct block_device *bdev,
>                 int blocksize, sector_t start, sector_t len)
>  {
> +       if (!dax_dev)
> +               return false;
> +
>         if (!dax_alive(dax_dev))
>                 return false;
> 
> BTW, I just submitted the v2 version:
> https://lore.kernel.org/linux-nvdimm/20200916133923.31-1-adrianhuang0701@gmail.com/T/#u
> 
> Hopefully/ideally, your patch and mine can be merged at the same rc release.

Yup, I'll send it rightaway.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
