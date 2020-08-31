Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3532B258180
	for <lists+linux-nvdimm@lfdr.de>; Mon, 31 Aug 2020 21:03:18 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 47FC612604A5F;
	Mon, 31 Aug 2020 12:03:16 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.78; helo=aserp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CD0E612604A4E
	for <linux-nvdimm@lists.01.org>; Mon, 31 Aug 2020 12:03:13 -0700 (PDT)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07VIsGAp081431;
	Mon, 31 Aug 2020 19:03:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=EvHBpmnBqVUqg1Epy4rmiAs+aHw+4HLXAULw1u2JKgo=;
 b=PFelmtPFDj17yFh9Cv5pYNXTMfxG0khnQr4HMVjSYug+COd9aAB+KoHhIGDsyBuNINHA
 Hs55myJM7yvmFBjA+o5J449MUh6UqnGNB6aCxvVNlbT+90kHefbig3op23uPS752Nk0f
 mrr71Lt3vk0eSLt02Hfb9Z6AEGX9Fvba431zmuyhAEQ1G5Q3XTswducWNzEwgbv2/XvX
 Ol7zpzlSqh1rlAGQClx5QZlsc8ypzvf3TVzflLUg9iMZHeVuwfzm7Fd0FblHhjgTg0uT
 M4aMPVgmiG9/ds8aZ3/KOqwz9rH0NK0VCOJL/A3xQj1j+LOiJFFqq+5gD4iu6bmc4EZA hw==
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by aserp2120.oracle.com with ESMTP id 337eym001m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 31 Aug 2020 19:03:11 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07VItBE9103502;
	Mon, 31 Aug 2020 19:03:10 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by userp3020.oracle.com with ESMTP id 3380sqfdh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2020 19:03:10 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07VJ39FM030737;
	Mon, 31 Aug 2020 19:03:09 GMT
Received: from [10.175.175.170] (/10.175.175.170)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Mon, 31 Aug 2020 12:03:09 -0700
Subject: Re: [bug report] device-dax: add dis-contiguous resource support
To: Dan Carpenter <dan.carpenter@oracle.com>, dan.j.williams@intel.com
References: <20200831113235.GA512956@mwanda>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <e529f97e-29e0-33e1-5f46-bce76320ba4e@oracle.com>
Date: Mon, 31 Aug 2020 20:03:07 +0100
MIME-Version: 1.0
In-Reply-To: <20200831113235.GA512956@mwanda>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9730 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008310111
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9730 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008310111
Message-ID-Hash: SYJTM2TEI3KRRWJ3XYIFGGQWBNQIYOO4
X-Message-ID-Hash: SYJTM2TEI3KRRWJ3XYIFGGQWBNQIYOO4
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SYJTM2TEI3KRRWJ3XYIFGGQWBNQIYOO4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 8/31/20 12:32 PM, Dan Carpenter wrote:
> Hello Dan Williams,
> 
> This is a semi-automatic email about new static checker warnings.
> 
> The patch 454c727769f5: "device-dax: add dis-contiguous resource
> support" from Aug 26, 2020, leads to the following Smatch complaint:
> 
>     drivers/dax/bus.c:788 alloc_dev_dax_range()
>     error: we previously assumed 'alloc' could be null (see line 772)
> 
> drivers/dax/bus.c
>    771		alloc = __request_region(res, start, size, dev_name(dev), 0);
>    772		if (!alloc && !dev_dax->nr_range) {
>                            ^^
> This should probably be a ||?
> 
>    773			/*
>    774			 * If we adjusted an existing @ranges leave it alone,
>    775			 * but if this was an empty set of ranges nothing else
>    776			 * will release @ranges, so do it now.
>    777			 */
>    778			kfree(ranges);
>    779			return -ENOMEM;
>    780		}
>    781	
>    782		for (i = 0; i < dev_dax->nr_range; i++)
>    783			pgoff += PHYS_PFN(range_len(&ranges[i].range));
>    784		dev_dax->ranges = ranges;
>    785		ranges[dev_dax->nr_range++] = (struct dev_dax_range) {
>    786			.pgoff = pgoff,
>    787			.range = {
>    788				.start = alloc->start,
>                                          ^^^^^^^^^^^^
> Dereferences.
> 
>    789				.end = alloc->end,
>    790			},
> 
This is already fixed in mmots:

https://www.ozlabs.org/~akpm/mmots/broken-out/device-dax-add-dis-contiguous-resource-support-fix.patch
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
