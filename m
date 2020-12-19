Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A522DECB5
	for <lists+linux-nvdimm@lfdr.de>; Sat, 19 Dec 2020 03:06:51 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6081E100EF250;
	Fri, 18 Dec 2020 18:06:49 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.228.121.143; helo=hqnvemgate24.nvidia.com; envelope-from=jhubbard@nvidia.com; receiver=<UNKNOWN> 
Received: from hqnvemgate24.nvidia.com (hqnvemgate24.nvidia.com [216.228.121.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6F26A100EF24E
	for <linux-nvdimm@lists.01.org>; Fri, 18 Dec 2020 18:06:31 -0800 (PST)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
	id <B5fdd60260000>; Fri, 18 Dec 2020 18:06:30 -0800
Received: from [10.2.61.104] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 19 Dec
 2020 02:06:29 +0000
Subject: Re: [PATCH RFC 7/9] mm/gup: Decrement head page once for group of
 subpages
To: Jason Gunthorpe <jgg@ziepe.ca>, Joao Martins <joao.m.martins@oracle.com>
References: <20201208172901.17384-1-joao.m.martins@oracle.com>
 <20201208172901.17384-9-joao.m.martins@oracle.com>
 <20201208193446.GP5487@ziepe.ca>
 <cf5585f0-1352-e3ab-9dbf-0185ad0a1b31@oracle.com>
 <20201217200530.GK5487@ziepe.ca>
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <604ac536-a829-4ae6-e0c8-291ab9e0138e@nvidia.com>
Date: Fri, 18 Dec 2020 18:06:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <20201217200530.GK5487@ziepe.ca>
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
	t=1608343590; bh=OH53xx8sNxbZpEAHW3MZBKOYLl1Mb9gG8A7DayBo6y4=;
	h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
	 MIME-Version:In-Reply-To:Content-Type:Content-Language:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
	b=rWr1vsQ+xPscwDyZiaTbRZ1RTHZ+mYt3wxd4tuJTV+HypbusMqEDF7xeym/OOp1rA
	 nwJd7Gf1b/Gp825AcnY7gRogjaRYGpNXiUzIdNncQHJWeMj3mPd/ivIFWcbEpeE3yQ
	 SHeki2QqF6+afmqXvruuErOpqgHFMr2cHbnn0mWb+A8sYz3eoGWuW+G0OQ39JlZpXq
	 ch4vilGvKxLmqtvjtrUJ+mq1Bv7UX4+LnbR0gFjdEyrafoxh6a1tY8988OpvOF2OTw
	 TQ42CnFxFj8bRkesPP15z1S8KpHat6lq9x5GRcuVqz/8BjqILqi+GST0GxmKci5XW6
	 /tQFvnC4cBpjA==
Message-ID-Hash: VXLVBTHVEOVXBDVBCJFGCYHBNG4MA4S2
X-Message-ID-Hash: VXLVBTHVEOVXBDVBCJFGCYHBNG4MA4S2
X-MailFrom: jhubbard@nvidia.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-mm@kvack.org, linux-nvdimm@lists.01.org, Matthew Wilcox <willy@infradead.org>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, "Andrew Morton  <akpm@linux-foundation.org>, Daniel Jordan" <daniel.m.jordan@oracle.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VXLVBTHVEOVXBDVBCJFGCYHBNG4MA4S2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 12/17/20 12:05 PM, Jason Gunthorpe wrote:
> On Thu, Dec 17, 2020 at 07:05:37PM +0000, Joao Martins wrote:
>>> No reason not to fix set_page_dirty_lock() too while you are here.
>>
>> The wack of atomics you mentioned earlier you referred to, I suppose it
>> ends being account_page_dirtied(). See partial diff at the end.
> 
> Well, even just eliminating the lock_page, page_mapping, PageDirty,
> etc is already a big win.
> 
> If mapping->a_ops->set_page_dirty() needs to be called multiple times
> on the head page I'd probably just suggest:
> 
>    while (ntails--)
>          rc |= (*spd)(head);

I think once should be enough. There is no counter for page dirtiness,
and this kind of accounting is always tracked in the head page, so there
is no reason to repeatedly call set_page_dirty() from the same
spot.


thanks,
-- 
John Hubbard
NVIDIA
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
