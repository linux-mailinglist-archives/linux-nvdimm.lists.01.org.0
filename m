Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F22F9375A3C
	for <lists+linux-nvdimm@lfdr.de>; Thu,  6 May 2021 20:36:39 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 34DE9100EAB60;
	Thu,  6 May 2021 11:36:38 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.78; helo=aserp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 564E0100EAB56
	for <linux-nvdimm@lists.01.org>; Thu,  6 May 2021 11:36:36 -0700 (PDT)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 146IKDhr169383;
	Thu, 6 May 2021 18:36:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=7slUrep9Nu26y6m09Y38ht4Cg+iPIyfQgVWBhX/oQT4=;
 b=fmE84Wi0U2cHeQKpv7Z/t0JKxsT55sWRjV17fYENMBbivvEQyenA4vhIGLPuCsHV0Exs
 pW8TEq21XDidIh9oT4eambBblrlmbGb5sYJLT3dDXSXoET0fv3lsg3QGk6koRtlvrGOL
 z0MCUGEyf/I+3oaeK1IcJcel4rHUMmBmTCmrSeHLOc0KiIWGjFhfR2PvlcTMzGQscfZS
 XhUnqU0GYSKb7Zdxf2VfCvmyvO6mIwJZe8rioZhs7/lnQ/gYJ40LCjV1+3SBtYNLylUi
 TLDLXCuyiGFPBVOoHYq/tcYvmk9w93KML5BuZfcAQ9+qg7kpXcisjd1pEnLBq7vSKzLc fg==
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by aserp2120.oracle.com with ESMTP id 38bemjnx7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 May 2021 18:36:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 146IaMQX174186;
	Thu, 6 May 2021 18:36:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by aserp3020.oracle.com with ESMTP id 38bebmwajq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 May 2021 18:36:29 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 146IaSM0175707;
	Thu, 6 May 2021 18:36:28 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by aserp3020.oracle.com with ESMTP id 38bebmwahj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 May 2021 18:36:28 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 146IaNWt000863;
	Thu, 6 May 2021 18:36:23 GMT
Received: from [10.175.182.44] (/10.175.182.44)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Thu, 06 May 2021 11:36:23 -0700
Subject: Re: [PATCH v1 06/11] mm/sparse-vmemmap: refactor
 vmemmap_populate_basepages()
From: Joao Martins <joao.m.martins@oracle.com>
To: Dan Williams <dan.j.williams@intel.com>
References: <20210325230938.30752-1-joao.m.martins@oracle.com>
 <20210325230938.30752-7-joao.m.martins@oracle.com>
 <CAPcyv4gf_gc6pGSZYaDp3A++enFF1aTdDVA2YbxHX_v_TM3rpg@mail.gmail.com>
 <ccceef6c-e87f-10a5-1cbb-d2b2e65823f1@oracle.com>
Message-ID: <00d349e3-eb3e-5048-56b0-9c44b56f4b75@oracle.com>
Date: Thu, 6 May 2021 19:36:19 +0100
MIME-Version: 1.0
In-Reply-To: <ccceef6c-e87f-10a5-1cbb-d2b2e65823f1@oracle.com>
Content-Language: en-US
X-Proofpoint-ORIG-GUID: VxEvGVqxoCgvFKb9f9Lz3nXXp6J_fwGq
X-Proofpoint-GUID: VxEvGVqxoCgvFKb9f9Lz3nXXp6J_fwGq
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9976 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 mlxscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105060127
Message-ID-Hash: 7723NWM7CSL7B3BWAPPKVORTFSK7EG4X
X-Message-ID-Hash: 7723NWM7CSL7B3BWAPPKVORTFSK7EG4X
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Jane Chu <jane.chu@oracle.com>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7723NWM7CSL7B3BWAPPKVORTFSK7EG4X/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 5/6/21 11:27 AM, Joao Martins wrote:
> On 5/5/21 11:43 PM, Dan Williams wrote:
>> I suspect it's a good sign I'm only finding cosmetic and changelog
>> changes in the review... 
> 
> Hopefully it continues that way, but the meat of the series is located
> in patches 4, 6, 7 and 11. *Specially* 6 and 7.
> 
Ugh, I meant 7 and 8 *not* 6 and 7.

> I very strongly suspect I am gonna get non-cosmetic comments there.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
