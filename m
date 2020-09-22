Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D75273F2D
	for <lists+linux-nvdimm@lfdr.de>; Tue, 22 Sep 2020 12:05:05 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EA06D14781C20;
	Tue, 22 Sep 2020 03:05:02 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=riteshh@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DA5BD143B300A
	for <linux-nvdimm@lists.01.org>; Tue, 22 Sep 2020 03:04:59 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08MA3bd3075189;
	Tue, 22 Sep 2020 06:04:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=xap9xZDBEoQ31ceOF8DdsfiPqgBfihwBvB7r2Zr7KNI=;
 b=LnOf884PsFCVyw8yIy7Dh7YgA4jq/XL+Pp7lD92M5tNXowfUEtuE3LTypDfQOdvx6yeD
 FfNfZr4ZOKxdgyDIHpClewISe9NQ6Y4/6w6m1B/dIZUiiuYaJSOq0lU+g6luH7eUrZok
 DLAePVHbuoHw514CLz73u13lD1UxuiPwhD/2fKpz0XXHlTKjWDgAojfj8z1uot3c2ugk
 WrQ6bF/EAd1U/sngTbNRWtPmufY21kxS5kvt31CAvML09MiHpKWlYIzdogRCBv5yU/UR
 PIjxovpLxWrIzGoRLiPdPkMKpBnbwbL56LET35ghgS/DotgkkHeBEjFyqTi0Q6kF0qVo vA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 33qf6dg197-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2020 06:04:47 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08MA3mIE075613;
	Tue, 22 Sep 2020 06:04:46 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 33qf6dg17t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2020 06:04:46 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
	by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08MA1ZHt010123;
	Tue, 22 Sep 2020 10:04:43 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
	by ppma04fra.de.ibm.com with ESMTP id 33n9m7sh4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2020 10:04:43 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
	by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08MA4dQJ29950400
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Sep 2020 10:04:39 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 19D6FAE05A;
	Tue, 22 Sep 2020 10:04:41 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D3D5AE051;
	Tue, 22 Sep 2020 10:04:38 +0000 (GMT)
Received: from [9.199.40.71] (unknown [9.199.40.71])
	by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Tue, 22 Sep 2020 10:04:37 +0000 (GMT)
Subject: Re: [RFC] nvfs: a filesystem for persistent memory
To: Matthew Wilcox <willy@infradead.org>,
        Mikulas Patocka <mpatocka@redhat.com>
References: <alpine.LRH.2.02.2009140852030.22422@file01.intranet.prod.int.rdu2.redhat.com>
 <20200915130012.GC5449@casper.infradead.org>
From: Ritesh Harjani <riteshh@linux.ibm.com>
Message-ID: <20d31308-e60a-99f2-3309-c9f6c115e32b@linux.ibm.com>
Date: Tue, 22 Sep 2020 15:34:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200915130012.GC5449@casper.infradead.org>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-22_06:2020-09-21,2020-09-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 clxscore=1011 adultscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009220082
Message-ID-Hash: TJTLSJNLLRZAWLVXFKNHMVHZEDJ4LB23
X-Message-ID-Hash: TJTLSJNLLRZAWLVXFKNHMVHZEDJ4LB23
X-MailFrom: riteshh@linux.ibm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>, Eric Sandeen <esandeen@redhat.com>, Dave Chinner <dchinner@redhat.com>, "Tadakamadla, Rajesh (DCIG/CDI/HPS Perf)" <rajesh.tadakamadla@hpe.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TJTLSJNLLRZAWLVXFKNHMVHZEDJ4LB23/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit



On 9/15/20 6:30 PM, Matthew Wilcox wrote:
> On Tue, Sep 15, 2020 at 08:34:41AM -0400, Mikulas Patocka wrote:
>> - when the fsck.nvfs tool mmaps the device /dev/pmem0, the kernel uses
>> buffer cache for the mapping. The buffer cache slows does fsck by a factor
>> of 5 to 10. Could it be possible to change the kernel so that it maps DAX
>> based block devices directly?
> 
> Oh, because fs/block_dev.c has:
>          .mmap           = generic_file_mmap,
> 
> I don't see why we shouldn't have a blkdev_mmap modelled after
> ext2_file_mmap() with the corresponding blkdev_dax_vm_ops.
> 

pls help with below 2 queries:-

1. Can't we use ->direct_IO here to avoid the mentioned performance problem?
2. Any other existing use case where having this blkdev_dax_vm_ops be 
useful?

-ritesh
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
