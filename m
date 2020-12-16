Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC3D2DBF5E
	for <lists+linux-nvdimm@lfdr.de>; Wed, 16 Dec 2020 12:29:05 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A7D5B100EC1F7;
	Wed, 16 Dec 2020 03:29:03 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.78; helo=aserp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0D09D100ED49F
	for <linux-nvdimm@lists.01.org>; Wed, 16 Dec 2020 03:29:00 -0800 (PST)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BGBJiDA186129;
	Wed, 16 Dec 2020 11:28:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=TRAf2TA8H2YH2VGRlx39q6dC8D5KdnzkjOGqIsW9JRo=;
 b=yufS3QkHxNtz9f8giSfNuYeaEZAYzT//WBHdFr5nAKFpYXZ+Ym45nci39Cya8YddVOUR
 oKOAXvolf0uo/kGVX1SYheEhGZXd7jG9G2uioLp/5Fq/8om8X+iQbYMoQo4hrTfDR8nj
 7uRGV4Ze6sc4vhmC/jTUMZPZfendc1fAyIbo9e/nKExb5HM/0hQ3qAKkb+Uy7cDn7szg
 RBFmvqyMdeS3Vy4f23tHGbl0UtKSDt2SWv+CvzH+LMt2qcaKs7Cq9x30HUWiEgWj2q2V
 xONzLkx3pEpv5s4lIMN/awvR6BuPjl19CIa4YDlINqMjEWKGkBViCuKpdvTND7Ow3qZd uw==
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by aserp2120.oracle.com with ESMTP id 35cntm7kyb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 16 Dec 2020 11:28:58 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BGBLFLp134593;
	Wed, 16 Dec 2020 11:28:58 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by aserp3030.oracle.com with ESMTP id 35d7epcyar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Dec 2020 11:28:58 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BGBSvvX005241;
	Wed, 16 Dec 2020 11:28:57 GMT
Received: from [10.175.202.27] (/10.175.202.27)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Wed, 16 Dec 2020 03:28:57 -0800
Subject: Re: [PATCH ndctl v2 10/10] daxctl/test: Add tests for dynamic dax
 regions
To: "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>
References: <20200713160837.13774-1-joao.m.martins@oracle.com>
 <20200713160837.13774-11-joao.m.martins@oracle.com>
 <5cf76b3d-21db-daf9-dc1d-d38714a9a7c2@oracle.com>
 <42e0711f-b26b-65af-4f12-efb28b07a096@oracle.com>
 <68ae54e05494ca82db67107bb1f44b982146b5bf.camel@intel.com>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <392bf623-115e-1ad6-dd88-c20f0cd26c7f@oracle.com>
Date: Wed, 16 Dec 2020 11:28:55 +0000
MIME-Version: 1.0
In-Reply-To: <68ae54e05494ca82db67107bb1f44b982146b5bf.camel@intel.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9836 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012160073
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9836 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012160073
Message-ID-Hash: TEVNEONYSRUH4TZI3CMA5K2WN4MIQ3SW
X-Message-ID-Hash: TEVNEONYSRUH4TZI3CMA5K2WN4MIQ3SW
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TEVNEONYSRUH4TZI3CMA5K2WN4MIQ3SW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 12/16/20 10:25 AM, Verma, Vishal L wrote:
> On Thu, 2020-12-10 at 15:01 +0000, Joao Martins wrote:
>> On 7/21/20 5:49 PM, Joao Martins wrote:
>>> On 7/13/20 5:08 PM, Joao Martins wrote:
>>>> Add a couple tests which exercise the new sysfs based
>>>> interface for Soft-Reserved regions (by EFI/HMAT, or
>>>> efi_fake_mem).
>>>>
>>>> The tests exercise the daxctl orchestration surrounding
>>>> for creating/disabling/destroying/reconfiguring devices.
>>>> Furthermore it exercises dax region space allocation
>>>> code paths particularly:
>>>>
>>>>  1) zeroing out and reconfiguring a dax device from
>>>>  its current size to be max available and back to initial
>>>>  size
>>>>
>>>>  2) creates devices from holes in the beginning,
>>>>  middle of the region.
>>>>
>>>>  3) reconfigures devices in a interleaving fashion
>>>>
>>>>  4) test adjust of the region towards beginning and end
>>>>
>>>> The tests assume you pass a valid efi_fake_mem parameter
>>>> marked as EFI_MEMORY_SP e.g.
>>>>
>>>> 	efi_fake_mem=112G@16G:0x40000
>>>>
>>>> Naturally it bails out from the test if hmem device driver
>>>> isn't loaded or builtin. If hmem regions are found, only
>>>> region 0 is used, and the others remain untouched.
>>>>
>>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>>
>>> Following your suggestion[0], I added a couple more validations
>>> to this test suite, covering the mappings. So on top of this patch
>>> I added the following snip below the scissors mark. Mainly, I check
>>> that the size calculated by mappingNNNN is the same as advertised by
>>> the sysfs size attribute, thus looping through all the mappings.
>>>
>>> Perhaps it would be enough to have just such validation in setup_dev()
>>> to catch the bug in [0]. But I went ahead and also validated the test
>>> cases where a certain amount of mappings are meant to be created.
>>>
>>> My only worry is the last piece in daxctl_test_adjust() where we might
>>> be tying too much on how a kernel version picks space from the region;
>>> should this logic change in an unforeseeable future (e.g. allowing space
>>> at the beginning to be adjusted). Otherwise, if this no concern, let me
>>> know and I can resend a v3 with the adjustment below.
>>>
>>
>> Ping?
> 
> Hi Joao,
> 
> Thanks for the patience on these, I've gone through the patches in
> preparation for the next release, and they all look mostly fine. I had a
> few minor fixups - to the documentation and the test (fixup module name,
> and shellcheck complaints). I've appended a diff below of all the fixups
> I added.
> 
The adjustments are looking good AFAICT.

> I've also included the patch below for the mapping size validation. I
> think the concern for future kernel layout changes is valid, but if/when
> that happens, we can always come back and relax or adjust the test as
> needed. So for now, I think having a pickier test should be better than
> not having one.
> 
Yeah, makes sense.

Thanks!
	Joao
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
