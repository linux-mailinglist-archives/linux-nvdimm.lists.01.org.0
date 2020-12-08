Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9DC2D3148
	for <lists+linux-nvdimm@lfdr.de>; Tue,  8 Dec 2020 18:40:47 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id ADE0E100EB838;
	Tue,  8 Dec 2020 09:40:46 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.86; helo=userp2130.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CE555100EB82E
	for <linux-nvdimm@lists.01.org>; Tue,  8 Dec 2020 09:40:44 -0800 (PST)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B8Hdshc028754;
	Tue, 8 Dec 2020 17:40:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=2h/jbAMZdG4bZiUM0MvKFhVrphOCNaDgfXC+uprxVV4=;
 b=cAhWN4g5Qcw59uPWcR+uvmJjxgnJK4keGBTFoaJRuwzvCkZPL1jBkl9pj4fP3EXD0kCT
 0IW/0IgjLkcr6lt/V9D5sJEsWWyFKGiC/S8jFCaRYrccRNhZ8D1lOqt6MeqCHeSB9dy8
 UxoKp9AeCtpnucdQGMKvRdbPtJCFC2Lo4fs3F2nWRFDkKXmfxc87UMG27aIskY7kOQ32
 0Pd6RzqRlFTXipBfbQcVC6KDA9B7k2/FMkKWOAp9q4nChnQ2q5ytV+FN+n3Ubqcs0mVc
 VUoD8WXgQc0j9m7rWid5QAmG8gx8ZBHzNTq55t2wYkdKe6T0clfxUARnf+Kght7XQgOz Jg==
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by userp2130.oracle.com with ESMTP id 3581mqv1fg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 08 Dec 2020 17:40:37 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B8HaVmH036915;
	Tue, 8 Dec 2020 17:38:36 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by aserp3020.oracle.com with ESMTP id 358m3y2r0w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Dec 2020 17:38:36 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0B8HcZSo009086;
	Tue, 8 Dec 2020 17:38:35 GMT
Received: from [192.168.1.67] (/94.61.1.144)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Tue, 08 Dec 2020 09:38:35 -0800
Subject: Re: [PATCH RFC 3/9] sparse-vmemmap: Reuse vmemmap areas for a given
 mhp_params::align
To: linux-mm@kvack.org
References: <20201208172901.17384-1-joao.m.martins@oracle.com>
 <20201208172901.17384-4-joao.m.martins@oracle.com>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <a91eb22b-c060-ad1b-8e04-5d44b6f5e3a9@oracle.com>
Date: Tue, 8 Dec 2020 17:38:31 +0000
MIME-Version: 1.0
In-Reply-To: <20201208172901.17384-4-joao.m.martins@oracle.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=3 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012080108
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 mlxlogscore=999
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012080109
Message-ID-Hash: UI336WE4DNNYKM6F3RFNGS4UMU5KG42T
X-Message-ID-Hash: UI336WE4DNNYKM6F3RFNGS4UMU5KG42T
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UI336WE4DNNYKM6F3RFNGS4UMU5KG42T/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 12/8/20 5:28 PM, Joao Martins wrote:
> Introduce a new flag, MEMHP_REUSE_VMEMMAP, which signals that that
> struct pages are onlined with a given alignment, and should reuse the
> tail pages vmemmap areas. On that circunstamce we reuse the PFN backing
> only the tail pages subsections, while letting the head page PFN remain
> different. This presumes that the backing page structs are compound
> pages, such as the case for compound pagemaps (i.e. ZONE_DEVICE with
> PGMAP_COMPOUND set)
> 
> On 2M compound pagemaps, it lets us save 6 pages out of the 8 necessary
> PFNs necessary to describe the subsection's 32K struct pages we are
> onlining. On a 1G compound pagemap it let us save 4096 pages.
> 
> Sections are 128M (or bigger/smaller), and such when initializing a
> compound memory map where we are initializing compound struct pages, we
> need to preserve the tail page to be reused across the rest of the areas
> for pagesizes which bigger than a section.
> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>

Sigh, ignore this one.

I mistakenly had stashed an old version of this patch, and wrongly send it up.

	Joao
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
