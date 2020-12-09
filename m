Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E8A2D47DD
	for <lists+linux-nvdimm@lfdr.de>; Wed,  9 Dec 2020 18:28:16 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8BC48100EBB71;
	Wed,  9 Dec 2020 09:28:14 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.78; helo=aserp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1B632100EBB6B
	for <linux-nvdimm@lists.01.org>; Wed,  9 Dec 2020 09:28:11 -0800 (PST)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B9HPL8V116800;
	Wed, 9 Dec 2020 17:28:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=CKOmHdzJAQLppGXuLuUYLdCo8cZUm9ZP9GGvWeHeNqg=;
 b=zJitd/2UNu+ooYi8jHPPVJlJnqMnaadeEzjWkRD2YtW2/oZ/cu48H9jLRDibs/Y7tkBV
 /2W4CsmXujyGhUdz2+LvkB1Cl0MW+iy2/XO6mrahPBYIv3dS64F+rNw+vCF1SnIFS+AE
 LlofyNoi+CF9Enpq58fRwifyuvgMy2ohq2OOBoaG6+3KYKO/cKVVjmd+Snu1Z2OGxgc6
 3IBI94oIwigL54m57pCLTFUXJTadQtK5iGrOm28MHWW4M36HGZDSUupN9oVZM+wfM8of
 fSyNOGNwJzRBXUUiKmyZg2pPIPYzlaad+WctmnHNwu3uFHmBR9gmW4tmivfusTO6U9JS uQ==
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
	by aserp2120.oracle.com with ESMTP id 35825m9dht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 09 Dec 2020 17:28:04 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
	by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B9HJl2m075657;
	Wed, 9 Dec 2020 17:28:03 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by userp3030.oracle.com with ESMTP id 358m50wp5g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Dec 2020 17:28:03 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
	by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0B9HS17g020576;
	Wed, 9 Dec 2020 17:28:01 GMT
Received: from [10.175.160.66] (/10.175.160.66)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Wed, 09 Dec 2020 09:28:01 -0800
Subject: Re: [PATCH RFC 6/9] mm/gup: Grab head page refcount once for group of
 subpages
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20201208172901.17384-1-joao.m.martins@oracle.com>
 <20201208172901.17384-8-joao.m.martins@oracle.com>
 <20201208194905.GQ5487@ziepe.ca>
 <b7f5fe44-f2f5-aea6-57b3-7e14a9ef624d@oracle.com>
 <20201209151505.GV5487@ziepe.ca>
 <a035661f-a979-c68b-d149-ef3892a5a1ea@oracle.com>
 <20201209162438.GW5487@ziepe.ca>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <3f2ce09a-03b4-6c36-0ea0-7635ec15bf05@oracle.com>
Date: Wed, 9 Dec 2020 17:27:57 +0000
MIME-Version: 1.0
In-Reply-To: <20201209162438.GW5487@ziepe.ca>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=1
 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012090122
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501 mlxscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012090123
Message-ID-Hash: F74QWCHLLQLDBM6GOXPNCA4AB5LXHIZC
X-Message-ID-Hash: F74QWCHLLQLDBM6GOXPNCA4AB5LXHIZC
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-mm@kvack.org, linux-nvdimm@lists.01.org, Matthew Wilcox <willy@infradead.org>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/F74QWCHLLQLDBM6GOXPNCA4AB5LXHIZC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 12/9/20 4:24 PM, Jason Gunthorpe wrote:
> On Wed, Dec 09, 2020 at 04:02:05PM +0000, Joao Martins wrote:
> 
>> Today (without the series) struct pages are not represented the way they
>> are expressed in the page tables, which is what I am hoping to fix in this
>> series thus initializing these as compound pages of a given order. But me
>> introducing PGMAP_COMPOUND was to conservatively keep both old (non-compound)
>> and new (compound pages) co-exist.
> 
> Oooh, that I didn't know.. That is kind of horrible to have a PMD
> pointing at an order 0 page only in this one special case.
> 
> Still, I think it would be easier to teach record_subpages() that a
> PMD doesn't necessarily point to a high order page, eg do something
> like I suggested for the SGL where it extracts the page order and
> iterates over the contiguous range of pfns.
> 
/me nods

> This way it can remain general with no particularly special path for
> devmap or a special PGMAP_COMPOUND check here.

The less special paths the better, indeed.

	Joao
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
