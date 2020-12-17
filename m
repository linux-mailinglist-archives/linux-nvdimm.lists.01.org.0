Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDAB2DDB78
	for <lists+linux-nvdimm@lfdr.de>; Thu, 17 Dec 2020 23:35:20 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 25016100EBB7E;
	Thu, 17 Dec 2020 14:35:19 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.79; helo=aserp2130.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7A8A5100ED4B7
	for <linux-nvdimm@lists.01.org>; Thu, 17 Dec 2020 14:35:14 -0800 (PST)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
	by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BHMNlhh138563;
	Thu, 17 Dec 2020 22:35:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Rj9JexLQvCq04VdywbMjg/pDy339pdcvwh3h1VS2XJk=;
 b=q7u+TFNC9C6A3Ev2o074el7vk5+7DkDIuH7INufTPS2OwTHn2BUkbFpf17dNL/2SClzJ
 8SqKsmuQZs/TsKwtcOBa8XFs/LFrYe170ntiGA8QCLm3sWWmec2fp5Pu4MJpq0faLJkD
 XVZHonDI+2XPcmJdVHx7mM/KjZ9d4kRwGUnrB1aV63RJ/jjR7mhFJ9wmIEhdBN5y4UyP
 TUcdGbX2b5QdeMBvuBuxRYkndZ6+jp7+JajKq6u0HvTpAPd4Z9hjeOODNEuCOUBABlpo
 LgAupZgSKLxxrWvKa74j4Sx12Y9qw9Ui0MV77NuF1X+nuoBvSzQzdZutkvdrCAvUGwv+ PA==
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
	by aserp2130.oracle.com with ESMTP id 35ckcbr13f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 17 Dec 2020 22:35:03 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
	by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BHMKNf4031276;
	Thu, 17 Dec 2020 22:35:02 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by userp3030.oracle.com with ESMTP id 35d7t123qf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Dec 2020 22:35:02 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BHMYx29017874;
	Thu, 17 Dec 2020 22:34:59 GMT
Received: from [10.175.218.25] (/10.175.218.25)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Thu, 17 Dec 2020 14:34:59 -0800
Subject: Re: [PATCH RFC 7/9] mm/gup: Decrement head page once for group of
 subpages
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20201208172901.17384-1-joao.m.martins@oracle.com>
 <20201208172901.17384-9-joao.m.martins@oracle.com>
 <20201208193446.GP5487@ziepe.ca>
 <cf5585f0-1352-e3ab-9dbf-0185ad0a1b31@oracle.com>
 <20201217200530.GK5487@ziepe.ca>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <7c8078df-1151-3668-5cee-80c976df1ff6@oracle.com>
Date: Thu, 17 Dec 2020 22:34:54 +0000
MIME-Version: 1.0
In-Reply-To: <20201217200530.GK5487@ziepe.ca>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9838 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012170146
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9838 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012170146
Message-ID-Hash: CYD4PGXMWLKSVF7FAHUQ7GZGYBOORJCL
X-Message-ID-Hash: CYD4PGXMWLKSVF7FAHUQ7GZGYBOORJCL
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-mm@kvack.org, linux-nvdimm@lists.01.org, Matthew Wilcox <willy@infradead.org>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Daniel Jordan <daniel.m.jordan@oracle.com>, John Hubbard <jhubbard@nvidia.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CYD4PGXMWLKSVF7FAHUQ7GZGYBOORJCL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 12/17/20 8:05 PM, Jason Gunthorpe wrote:
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
>   while (ntails--)
>         rc |= (*spd)(head);
> 
> At least as a start.
> 
/me nods

> If you have workloads that have page_mapping != NULL then look at
> another series to optimze that. Looks a bit large though given the
> number of places implementing set_page_dirty
> 
Yes. I don't have a particular workload, was just wondering what you had in
mind, as at a glance, changing all the places without messing filesystems looks like
the subject of a separate series.

> I think the current reality is calling set_page_dirty on an actual
> file system is busted anyhow, so I think mapping is generally going to
> be NULL here?

Perhaps -- I'll have to check.

	Joao
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
