Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B2D207E69
	for <lists+linux-nvdimm@lfdr.de>; Wed, 24 Jun 2020 23:22:30 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 22EBA10FCC6C8;
	Wed, 24 Jun 2020 14:22:29 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.85; helo=userp2120.oracle.com; envelope-from=jane.chu@oracle.com; receiver=<UNKNOWN> 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 722A710FCC6CB
	for <linux-nvdimm@lists.01.org>; Wed, 24 Jun 2020 14:22:26 -0700 (PDT)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05OLHoBr027937;
	Wed, 24 Jun 2020 21:22:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=yufN0XxJzJQeTdABB88RFqrUDd4WVI2yUa+YwJerl+0=;
 b=G8ReoIBqVSMsVhEeO/+gDLznIerACz9a0GRmAXBu6RAiuU44VHeqLLgxdQCu/JUviyc2
 IP8NRs8NY/dbxF5rYOx9S3as+MWwwieJ/ja8wEipx4wMfARydl95nhq3LZnmo4cTdio9
 VzHJZ3ObCVRvqtFjsIJP6VLNDYZ0F6PMA87AFj/a3C0Txi0EcQbMNwhLZozCTs2JApPq
 kaGuWwvugC5lWUpQgU8+cHhB5kapYfoABj2gdRaAhR77qt/9WCTEPLZhVV7NmZVafuJY
 3Bzl3UGrTQeQe270jqKG+Y7aKtVEwu/YQfhR6sZHLFYBsDfTms8gi9UGkxgow4u++gVy 4g==
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by userp2120.oracle.com with ESMTP id 31uustn8qq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 24 Jun 2020 21:22:17 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05OLEEc4168398;
	Wed, 24 Jun 2020 21:22:17 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by userp3020.oracle.com with ESMTP id 31uur7xqs0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jun 2020 21:22:17 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05OLMEfm011648;
	Wed, 24 Jun 2020 21:22:14 GMT
Received: from [10.159.255.168] (/10.159.255.168)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Wed, 24 Jun 2020 21:22:14 +0000
Subject: Re: [RFC] Make the memory failure blast radius more precise
To: Matthew Wilcox <willy@infradead.org>, "Luck, Tony" <tony.luck@intel.com>
References: <20200623201745.GG21350@casper.infradead.org>
 <20200623220412.GA21232@agluck-desk2.amr.corp.intel.com>
 <20200623221741.GH21350@casper.infradead.org>
 <20200623222658.GA21817@agluck-desk2.amr.corp.intel.com>
 <20200623224027.GI21350@casper.infradead.org>
From: Jane Chu <jane.chu@oracle.com>
Organization: Oracle Corporation
Message-ID: <24367ca1-ecb0-de96-b9e5-f94747838c74@oracle.com>
Date: Wed, 24 Jun 2020 14:22:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200623224027.GI21350@casper.infradead.org>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9662 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006240138
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9662 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 cotscore=-2147483648 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006240138
Message-ID-Hash: ZFCH7QDN4R23JR25SDVNP242R2SGJ4ZY
X-Message-ID-Hash: ZFCH7QDN4R23JR25SDVNP242R2SGJ4ZY
X-MailFrom: jane.chu@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Borislav Petkov <bp@alien8.de>, Naoya Horiguchi <naoya.horiguchi@nec.com>, linux-edac@vger.kernel.org, linux-mm@kvack.org, linux-nvdimm@lists.01.org, "Darrick J. Wong" <darrick.wong@oracle.com>, David Rientjes <rientjes@google.com>, Mike Kravetz <mike.kravetz@oracle.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZFCH7QDN4R23JR25SDVNP242R2SGJ4ZY/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 6/23/2020 3:40 PM, Matthew Wilcox wrote:
> On Tue, Jun 23, 2020 at 03:26:58PM -0700, Luck, Tony wrote:
>> On Tue, Jun 23, 2020 at 11:17:41PM +0100, Matthew Wilcox wrote:
>>> It might also be nice to have an madvise() MADV_ZERO option so the
>>> application doesn't have to look up the fd associated with that memory
>>> range, but we haven't floated that idea with the customer yet; I just
>>> thought of it now.
>>
>> So the conversation between OS and kernel goes like this?
>>
>> 1) machine check
>> 2) Kernel unmaps the 4K page surroundinng the poison and sends
>>     SIGBUS to the application to say that one cache line is gone
>> 3) App says madvise(MADV_ZERO, that cache line)
>> 4) Kernel says ... "oh, you know how to deal with this" and allocates
>>     a new page, copying the 63 good cache lines from the old page and
>>     zeroing the missing one. New page is mapped to user.
> 
> That could be one way of implementing it.  My understanding is that
> pmem devices will reallocate bad cachelines on writes, so a better
> implementation would be:
> 
> 1) Kernel receives machine check
> 2) Kernel sends SIGBUS to the application
> 3) App send madvise(MADV_ZERO, addr, 1 << granularity)
> 4) Kernel does special writes to ensure the cacheline is zeroed
> 5) App does whatever it needs to recover (reconstructs the data or marks
> it as gone)

Thanks Matthew!

Both the RFC patch and the above 5-step recovery plan look neat, step 4) 
is nice to carry forward on icelake when a single instruction to clear
poison is available.

Next, what are the preferred ways to deal with the signal handling race 
when multiple processes are sharing the poisoned pmem page?

Also, is it advisable to application to ignore SIGBUS with MCEERR_AO?

> 
>> Do you have folks lined up to use that?  I don't know that many
>> folks are even catching the SIGBUS :-(
> 
> Had a 75 minute meeting with some people who want to use pmem this
> afternoon ...
>
thanks!
-jane
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
