Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B05137B5D
	for <lists+linux-nvdimm@lfdr.de>; Sat, 11 Jan 2020 05:33:37 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3FD2910096CAC;
	Fri, 10 Jan 2020 20:36:54 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0C1B110096C9B
	for <linux-nvdimm@lists.01.org>; Fri, 10 Jan 2020 20:36:51 -0800 (PST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00B4WJFd093848
	for <linux-nvdimm@lists.01.org>; Fri, 10 Jan 2020 23:33:31 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2xf73arcyc-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Fri, 10 Jan 2020 23:33:31 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <aneesh.kumar@linux.ibm.com>;
	Sat, 11 Jan 2020 04:33:29 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
	by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Sat, 11 Jan 2020 04:33:28 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00B4XRoR57016420
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 11 Jan 2020 04:33:27 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 54964A405B;
	Sat, 11 Jan 2020 04:33:27 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6576AA4054;
	Sat, 11 Jan 2020 04:33:26 +0000 (GMT)
Received: from [9.85.72.79] (unknown [9.85.72.79])
	by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
	Sat, 11 Jan 2020 04:33:26 +0000 (GMT)
Subject: Re: [PATCH v3 1/6] libnvdimm/namespace: Make namespace size
 validation arch dependent
To: Jeff Moyer <jmoyer@redhat.com>
References: <20200108065219.171221-1-aneesh.kumar@linux.ibm.com>
 <x49muavm4gx.fsf@segfault.boston.devel.redhat.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date: Sat, 11 Jan 2020 10:03:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <x49muavm4gx.fsf@segfault.boston.devel.redhat.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20011104-0012-0000-0000-0000037C676E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20011104-0013-0000-0000-000021B88D31
Message-Id: <253f7f57-d27f-91f1-4e99-ff69a0e88084@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-10_04:2020-01-10,2020-01-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 phishscore=0 mlxscore=0
 mlxlogscore=731 priorityscore=1501 suspectscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001110037
Message-ID-Hash: HM3XADCHUWXILLJ63NSXENNK6RL3FFKK
X-Message-ID-Hash: HM3XADCHUWXILLJ63NSXENNK6RL3FFKK
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HM3XADCHUWXILLJ63NSXENNK6RL3FFKK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 1/11/20 2:08 AM, Jeff Moyer wrote:
> Hi, Aneesh,
> 
> After applying this patch series, several of my namespaces no longer
> enumerate:
> 
> Before:
> 
> # ndctl list
> [
>    {
>      "dev":"namespace0.2",
>      "mode":"sector",
>      "size":106541672960,
>      "uuid":"ea1122b2-c219-424c-b09c-38a6e94a1042",
>      "sector_size":512,
>      "blockdev":"pmem0.2s"
>    },
>    {
>      "dev":"namespace0.1",
>      "mode":"fsdax",
>      "map":"dev",
>      "size":10567548928,
>      "uuid":"68b6746f-481a-4ae6-80b5-71d62176606c",
>      "sector_size":512,
>      "align":4096,
>      "blockdev":"pmem0.1"
>    },
>    {
>      "dev":"namespace0.0",
>      "mode":"fsdax",
>      "map":"dev",
>      "size":52850327552,
>      "uuid":"6d3a0199-5d9a-4fed-830d-e25249b70571",
>      "sector_size":512,
>      "align":2097152,
>      "blockdev":"pmem0"
>    }
> ]
> 
> After:
> 
> # ndctl list
> [
>    {
>      "dev":"namespace0.0",
>      "mode":"fsdax",
>      "map":"dev",
>      "size":52850327552,
>      "uuid":"6d3a0199-5d9a-4fed-830d-e25249b70571",
>      "sector_size":512,
>      "align":2097152,
>      "blockdev":"pmem0"
>    }
> ]
> 
> I won't have time to dig into it this week, but I wanted to mention it
> before Dan merged these patches.
> 
> I'll follow up next week with more information.
> 

dmesg should contain details  like

[    5.810939] nd_pmem namespace0.1: invalid size/SPA
[    5.810969] nd_pmem: probe of namespace0.1 failed with error -95

This is mostly due to the namespace start address not aligned to 
subsection size.

"namespace0.2" not having a 2MB aligned size which cause namespace 0.1 
start addr to be not aligned. Hence both the namespace are marked disabled.

-aneesh
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
