Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A43D2D4078
	for <lists+linux-nvdimm@lfdr.de>; Wed,  9 Dec 2020 11:59:34 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B2110100EBBB1;
	Wed,  9 Dec 2020 02:59:32 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.86; helo=userp2130.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BEA83100EBBAB
	for <linux-nvdimm@lists.01.org>; Wed,  9 Dec 2020 02:59:28 -0800 (PST)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B9As32V179167;
	Wed, 9 Dec 2020 10:59:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=mAQoBvZSA1QWuYtRVOFMl3224SBS073y0vaYACV/l9Q=;
 b=OGYWAem0jnGXCqNqXXwqyr9QiAXaXyuAm45DpnZP9I33R9KKUp5t4o+W+ofOM+kdFLFB
 WfSGueeEs3HBLc+A+4FbZGRaM3EfJ9QFakO+h99UJcey6haWIRMB53GV56qtdMH2uiqX
 Egkem7s4wpdkO14db59TIA0BXIoeD5HQRaA1AJY3/m4WJIpk6+AVoPzQPp9ZMFi5szXo
 Q165bnA8sgEtqrXULYs17+KBp4C8JIgYvG9RB0BuO/5+qwn8ad5jo9BkJ1TS5Y2BOWsY
 0/LrdzlPrNb7zBTV7JP9bzrQ6pppt8jWDdyjtVtsroMVcKRiWKbEMSE8Pe7G/9FzSJ1B zg==
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
	by userp2130.oracle.com with ESMTP id 3581mqyfe9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 09 Dec 2020 10:59:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
	by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B9AtlbT100906;
	Wed, 9 Dec 2020 10:59:15 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by userp3030.oracle.com with ESMTP id 358m50ccfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Dec 2020 10:59:15 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B9AxDnS030207;
	Wed, 9 Dec 2020 10:59:14 GMT
Received: from [10.175.160.66] (/10.175.160.66)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Wed, 09 Dec 2020 02:59:13 -0800
Subject: Re: [PATCH RFC 8/9] RDMA/umem: batch page unpin in __ib_mem_release()
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20201208172901.17384-1-joao.m.martins@oracle.com>
 <20201208172901.17384-10-joao.m.martins@oracle.com>
 <20201208192935.GA1908088@ziepe.ca>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <543363df-cefd-93e9-1ca1-9256e910a915@oracle.com>
Date: Wed, 9 Dec 2020 10:59:09 +0000
MIME-Version: 1.0
In-Reply-To: <20201208192935.GA1908088@ziepe.ca>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=5
 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012090076
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=5 mlxlogscore=999
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012090076
Message-ID-Hash: 4PKHBE7PYLAYGKUHJHCTP2G76XBEIW4K
X-Message-ID-Hash: 4PKHBE7PYLAYGKUHJHCTP2G76XBEIW4K
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-mm@kvack.org, linux-nvdimm@lists.01.org, Matthew Wilcox <willy@infradead.org>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4PKHBE7PYLAYGKUHJHCTP2G76XBEIW4K/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 12/8/20 7:29 PM, Jason Gunthorpe wrote:
> On Tue, Dec 08, 2020 at 05:29:00PM +0000, Joao Martins wrote:
> 
>>  static void __ib_umem_release(struct ib_device *dev, struct ib_umem *umem, int dirty)
>>  {
>> +	bool make_dirty = umem->writable && dirty;
>> +	struct page **page_list = NULL;
>>  	struct sg_page_iter sg_iter;
>> +	unsigned long nr = 0;
>>  	struct page *page;
>>  
>> +	page_list = (struct page **) __get_free_page(GFP_KERNEL);
> 
> Gah, no, don't do it like this!
> 
> Instead something like:
> 
> 	for_each_sg(umem->sg_head.sgl, sg, umem->nmap, i)
> 	      unpin_use_pages_range_dirty_lock(sg_page(sg), sg->length/PAGE_SIZE,
>                                                umem->writable && dirty);
> 
> And have the mm implementation split the contiguous range of pages into
> pairs of (compound head, ntails) with a bit of maths.
> 
Got it :)

I was trying to avoid another exported symbol.

Albeit upon your suggestion below, it doesn't justify the efficiency/clearness lost.

	Joao
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
