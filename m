Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 529C12D3779
	for <lists+linux-nvdimm@lfdr.de>; Wed,  9 Dec 2020 01:20:26 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 87AD0100EC1C3;
	Tue,  8 Dec 2020 16:20:24 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.86; helo=userp2130.oracle.com; envelope-from=jane.chu@oracle.com; receiver=<UNKNOWN> 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7D8F2100ED4BB
	for <linux-nvdimm@lists.01.org>; Tue,  8 Dec 2020 16:20:19 -0800 (PST)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B90K9s1089528;
	Wed, 9 Dec 2020 00:20:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=j9tnf+gfvO0ufEAxyR2ChrMzeMfCfvBzgaDibcY+CaU=;
 b=V59sG+JuU9qhlZGI4BrF+NZFGTuf2DN/TCwM+V9zgfZquAwj/dXwdVc1g/sa0VmKlCFx
 FKcaB67peR6VHvJWPQLtRU0tzMmU6+/QTC+CkgLY6PQL8tErdV/9r7obH4URwYvEgLAT
 LaBup94W+8KIr478PcpKv8np6/ljmh8hkwi8WgtMs7kywWTO4/9aE2HB9Jmhzh/X89+T
 4X2TbJKlZYMZF+JG3SySr92Q0uPSjjtsbiKzipjLV82uZUs9l7AhSKAS47okcj/nr7gd
 qb2BDReOFYaGpiPf5kNOMq4tKTf4ZjvJwIqz3JoNc9hSWhSWKSoix50Xkk29HfID3EBV aQ==
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by userp2130.oracle.com with ESMTP id 3581mqwmft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 09 Dec 2020 00:20:09 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B90Atqn053706;
	Wed, 9 Dec 2020 00:20:09 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by userp3020.oracle.com with ESMTP id 358kytquy8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Dec 2020 00:20:09 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
	by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0B90K86n021037;
	Wed, 9 Dec 2020 00:20:08 GMT
Received: from [10.159.230.58] (/10.159.230.58)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Tue, 08 Dec 2020 16:20:08 -0800
Subject: Re: [ndctl PATCH V2 0/8] fix serverl issues reported by Coverity
To: Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>
References: <3211fe8a-33fb-37ca-e192-ad1f116f4acd@huawei.com>
From: Jane Chu <jane.chu@oracle.com>
Organization: Oracle Corporation
Message-ID: <c8a8a260-34c6-dbfc-1f19-25c23d01cb45@oracle.com>
Date: Tue, 8 Dec 2020 16:20:06 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <3211fe8a-33fb-37ca-e192-ad1f116f4acd@huawei.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012080152
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 clxscore=1011 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012090000
Message-ID-Hash: JHZCNMYRGL3KLF75UJEML7ZPKJCJSCSX
X-Message-ID-Hash: JHZCNMYRGL3KLF75UJEML7ZPKJCJSCSX
X-MailFrom: jane.chu@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, linfeilong <linfeilong@huawei.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JHZCNMYRGL3KLF75UJEML7ZPKJCJSCSX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

Hi,

I actually just ran into the NULL deref issue that is fixed here.

Bu I have a question for the experts:
what might cause libndctl to run into the NULL deref like below ?

Program terminated with signal 11, Segmentation fault.
#0  ndctl_pfn_get_bus (pfn=pfn@entry=0x0) at libndctl.c:5540
5540            return pfn->region->bus;

(gdb) print pfn
$1 = (struct ndctl_pfn *) 0x0
(gdb) frame 4
#4  0x000000000040ca70 in setup_namespace (region=region@entry=0x109d910,
     ndns=ndns@entry=0x10a7d40, p=p@entry=0x7ffd8ff73b90) at namespace.c:570
570                     try(ndctl_dax, set_uuid, dax, uuid);
(gdb) info locals
__rc = <optimized out>
dax = 0x0

What I did was to let 2 threads run "create-namespace all" in a tight 
loop, and 2 other threads run "destroy-namespace all" in a tight loop,
while chasing an year old issue that randomly resurfaces -
"nd_region region1: allocation underrun: 0x0 of 0x40000000 bytes"

In addition, there are kmemleaks,
# cat /sys/kernel/debug/kmemleak
[..]
unreferenced object 0xffff976bd46f6240 (size 64):
   comm "ndctl", pid 23556, jiffies 4299514316 (age 5406.733s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 20 c3 37 00 00 00  .......... .7...
     ff ff ff 7f 38 00 00 00 00 00 00 00 00 00 00 00  ....8...........
   backtrace:
     [<00000000064003cf>] __kmalloc_track_caller+0x136/0x379
     [<00000000d85e3c52>] krealloc+0x67/0x92
     [<00000000d7d3ba8a>] __alloc_dev_dax_range+0x73/0x25c
     [<0000000027d58626>] devm_create_dev_dax+0x27d/0x416
     [<00000000434abd43>] __dax_pmem_probe+0x1c9/0x1000 [dax_pmem_core]
     [<0000000083726c1c>] dax_pmem_probe+0x10/0x1f [dax_pmem]
     [<00000000b5f2319c>] nvdimm_bus_probe+0x9d/0x340 [libnvdimm]
     [<00000000c055e544>] really_probe+0x230/0x48d
     [<000000006cabd38e>] driver_probe_device+0x122/0x13b
     [<0000000029c7b95a>] device_driver_attach+0x5b/0x60
     [<0000000053e5659b>] bind_store+0xb7/0xc3
     [<00000000d3bdaadc>] drv_attr_store+0x27/0x31
     [<00000000949069c5>] sysfs_kf_write+0x4a/0x57
     [<000000004a8b5adf>] kernfs_fop_write+0x150/0x1e5
     [<00000000bded60f0>] __vfs_write+0x1b/0x34
     [<00000000b92900f0>] vfs_write+0xd8/0x1d1


thanks,
-jane


On 11/24/2020 5:00 PM, Zhiqiang Liu wrote:
> Changes: V1->V2
> - add one empty line in 1/8 patch as suggested by Jeff Moyer <jmoyer@redhat.com>.
> 
> 
> Recently, we use Coverity to analysis the ndctl package.
> Several issues should be resolved to make Coverity happy.
> 
> Zhiqiang Liu (8):
>    namespace: check whether pfn|dax|btt is NULL in setup_namespace
>    lib/libndctl: fix memory leakage problem in add_bus
>    libdaxctl: fix memory leakage in add_dax_region()
>    dimm: fix potential fd leakage in dimm_action()
>    util/help: check whether strdup returns NULL in exec_man_konqueror
>    lib/inject: check whether cmd is created successfully
>    libndctl: check whether ndctl_btt_get_namespace returns NULL in
>      callers
>    namespace: check whether seed is NULL in validate_namespace_options
> 
>   daxctl/lib/libdaxctl.c |  3 +++
>   ndctl/dimm.c           | 12 +++++++-----
>   ndctl/lib/inject.c     |  8 ++++++++
>   ndctl/lib/libndctl.c   |  1 +
>   ndctl/namespace.c      | 23 ++++++++++++++++++-----
>   test/libndctl.c        | 16 +++++++++++-----
>   test/parent-uuid.c     |  2 +-
>   util/help.c            |  8 +++++++-
>   util/json.c            |  3 +++
>   9 files changed, 59 insertions(+), 17 deletions(-)
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
