Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 388142DEFC8
	for <lists+linux-nvdimm@lfdr.de>; Sat, 19 Dec 2020 14:15:48 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B2DEA100ED482;
	Sat, 19 Dec 2020 05:15:46 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.79; helo=aserp2130.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6BD61100EF278
	for <linux-nvdimm@lists.01.org>; Sat, 19 Dec 2020 05:15:43 -0800 (PST)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
	by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BJDE9Z6176966;
	Sat, 19 Dec 2020 13:15:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Dcsogiio8SJnRZOaSCyO6DdwNytM21g2JOcWZx/KC6s=;
 b=bDewbChdLY1PMBBaANCY/MF8cftTUh+XWuWPD5K+qG+fjyFsgASPsC87Q/ikSbRl/Xii
 384kRnwVueFY9fMcWZKeWJVHw1U3OiM/YOudxzeJTAB61gD4cKnkSJc7AEzx75sp7FHm
 ngxoANLvNUjtGfVfhiPLAGuZOju3zbHaVpUgf47Hl4bQVqaxqoP03fC53s77c8ZegjRN
 tveYT2QmqBEcZxq1GdxoJ6Br1HtHTy8mqSUS6SouFamgG+sLewTknjn4qIERjeSsGLnf
 qnPpGWkfwMU2sGN012ESmeuYBzkdcn9C8tfXk+Qn44oCfvUG4HD8UZCOmUDUNLDpSEvq MQ==
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
	by aserp2130.oracle.com with ESMTP id 35h71as0a1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 19 Dec 2020 13:15:34 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
	by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BJDALHK027030;
	Sat, 19 Dec 2020 13:15:33 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by userp3030.oracle.com with ESMTP id 35h6mrwd8n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 19 Dec 2020 13:15:33 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BJDFVTL007615;
	Sat, 19 Dec 2020 13:15:31 GMT
Received: from [192.168.1.188] (/89.180.84.11)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Sat, 19 Dec 2020 05:15:31 -0800
Subject: Re: [PATCH RFC 8/9] RDMA/umem: batch page unpin in __ib_mem_release()
From: Joao Martins <joao.m.martins@oracle.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20201208172901.17384-1-joao.m.martins@oracle.com>
 <20201208172901.17384-10-joao.m.martins@oracle.com>
 <20201208192935.GA1908088@ziepe.ca>
 <543363df-cefd-93e9-1ca1-9256e910a915@oracle.com>
Message-ID: <9a2e7772-905c-54f3-2116-25e14e42a3aa@oracle.com>
Date: Sat, 19 Dec 2020 13:15:27 +0000
MIME-Version: 1.0
In-Reply-To: <543363df-cefd-93e9-1ca1-9256e910a915@oracle.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9839 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012190097
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9839 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0
 mlxscore=0 impostorscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012190098
Message-ID-Hash: SENSGIERQD3RA6RCKFTEQMUESUWXJBZB
X-Message-ID-Hash: SENSGIERQD3RA6RCKFTEQMUESUWXJBZB
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-mm@kvack.org, linux-nvdimm@lists.01.org, Matthew Wilcox <willy@infradead.org>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SENSGIERQD3RA6RCKFTEQMUESUWXJBZB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 12/9/20 10:59 AM, Joao Martins wrote:
> On 12/8/20 7:29 PM, Jason Gunthorpe wrote:
>> On Tue, Dec 08, 2020 at 05:29:00PM +0000, Joao Martins wrote:
>>
>>>  static void __ib_umem_release(struct ib_device *dev, struct ib_umem *umem, int dirty)
>>>  {
>>> +	bool make_dirty = umem->writable && dirty;
>>> +	struct page **page_list = NULL;
>>>  	struct sg_page_iter sg_iter;
>>> +	unsigned long nr = 0;
>>>  	struct page *page;
>>>  
>>> +	page_list = (struct page **) __get_free_page(GFP_KERNEL);
>>
>> Gah, no, don't do it like this!
>>
>> Instead something like:
>>
>> 	for_each_sg(umem->sg_head.sgl, sg, umem->nmap, i)
>> 	      unpin_use_pages_range_dirty_lock(sg_page(sg), sg->length/PAGE_SIZE,
>>                                                umem->writable && dirty);
>>
>> And have the mm implementation split the contiguous range of pages into
>> pairs of (compound head, ntails) with a bit of maths.
>>
> Got it :)
> 
> I was trying to avoid another exported symbol.
> 
> Albeit upon your suggestion below, it doesn't justify the efficiency/clearness lost.
> 
This more efficient suggestion of yours leads to a further speed up from:

	1073 rounds in 5.004 sec: 4663.622 usec / round (hugetlbfs)

to

	1370 rounds in 5.003 sec: 3651.562 usec / round (hugetlbfs)

Right after I come back from holidays I will follow up with this series in separate.

	Joao
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
