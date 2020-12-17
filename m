Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3020A2DCD7E
	for <lists+linux-nvdimm@lfdr.de>; Thu, 17 Dec 2020 09:18:28 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 65AAD100EB82A;
	Thu, 17 Dec 2020 00:18:26 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 73158100EBBBB
	for <linux-nvdimm@lists.01.org>; Thu, 17 Dec 2020 00:18:22 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id p22so27646932edu.11
        for <linux-nvdimm@lists.01.org>; Thu, 17 Dec 2020 00:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CYGS8pWyE8q2JUKHyneJ8EPZ/SE2JIJ/gm+Of5ZmpdA=;
        b=KnYEVX+VktLSlpv0q2Ihl4osG3Y16MDlg9Wuw+38riJa0bmrqz24zHlZVm7pCJUb4n
         EdZ7sbmpHpFiW2ByuV/4hjFuLV3+UgC7lANMn/tZyqm4ugy/pwd81uPs2WWpwN9b+8ag
         NDWCYTsqf7nsgvIOLwSBWZ6frS7ccW6T0FFuZ2UV2DBX2gN4ctCrHlNCL7/cK/VHZIzH
         FDgkmnPa1k7Q3C9pRYMSQ3yZv576a+SatTPX7GubMKMi7uvGyAriXjAYgyEMOCYOiH5E
         YDpUM1Gk9bcjQrtpXgzvI6V6OeZkSaqia77r6Xcmj01NGq5ugHc39uA0XWabYsKxProu
         fK1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CYGS8pWyE8q2JUKHyneJ8EPZ/SE2JIJ/gm+Of5ZmpdA=;
        b=Z9Uz5Q1BEZGoADEK7+7UpoP6fV0Jgq3J6nN9XvKX+O/6zG+hhoK3Rixl+qCbORmham
         cAKwHMb/0XbWSxN1zkhzg5j9a+qW/TaQoMLm7y2u/hQ0ODMLyam/MqdzB36htgIpQBIU
         j9TT1iPBnCadAH22gHJhoomGyuNXpDJKFdi2TM2MPCISdeOTOt7u8or5SbIv7OvQrW8d
         +tNNry227xKjdzQCOxYCPv2sGggjyK1JBzMPbFvdFz/3sXyJ7ijMeuN7/+Ok7rHJrYRD
         m3ySv2esb0DOimtavjJApeCbXjXiVsx+QGnAfJeBQsnGmoIebUqqc8e1YcN6twGihyGC
         W6FQ==
X-Gm-Message-State: AOAM5303o2XvjDf/KIvpbUVrxTGxWgR4aJpUzM0K7TC4z74ztXEr4xYp
	0mkSKy4v5FgH6KzZ6M+aGprmClTVIu3qzcoWXHuiwg==
X-Google-Smtp-Source: ABdhPJyGioclYMHY6ezf9R4xao0pTrcrXwdZI225qUl/0lIJZmchrLhbZcwl+CwTmxPFWz0CHulgo5bWPHS/wHFh7Eg=
X-Received: by 2002:aa7:c2d8:: with SMTP id m24mr22619527edp.300.1608193100666;
 Thu, 17 Dec 2020 00:18:20 -0800 (PST)
MIME-Version: 1.0
References: <3211fe8a-33fb-37ca-e192-ad1f116f4acd@huawei.com> <c8a8a260-34c6-dbfc-1f19-25c23d01cb45@oracle.com>
In-Reply-To: <c8a8a260-34c6-dbfc-1f19-25c23d01cb45@oracle.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 17 Dec 2020 00:18:08 -0800
Message-ID: <CAPcyv4i1rY53QeAm2nhwv9_yP1hhw33qBTrMdrepxcVQOrDDqg@mail.gmail.com>
Subject: Re: [ndctl PATCH V2 0/8] fix serverl issues reported by Coverity
To: Jane Chu <jane.chu@oracle.com>
Message-ID-Hash: JCLYSH37I672C2TSYZZDCJ4DZ7M55U2E
X-Message-ID-Hash: JCLYSH37I672C2TSYZZDCJ4DZ7M55U2E
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Zhiqiang Liu <liuzhiqiang26@huawei.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, linfeilong <linfeilong@huawei.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JCLYSH37I672C2TSYZZDCJ4DZ7M55U2E/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Dec 8, 2020 at 4:20 PM Jane Chu <jane.chu@oracle.com> wrote:
>
> Hi,
>
> I actually just ran into the NULL deref issue that is fixed here.
>
> Bu I have a question for the experts:
> what might cause libndctl to run into the NULL deref like below ?
>
> Program terminated with signal 11, Segmentation fault.
> #0  ndctl_pfn_get_bus (pfn=pfn@entry=0x0) at libndctl.c:5540
> 5540            return pfn->region->bus;
>
> (gdb) print pfn
> $1 = (struct ndctl_pfn *) 0x0
> (gdb) frame 4
> #4  0x000000000040ca70 in setup_namespace (region=region@entry=0x109d910,
>      ndns=ndns@entry=0x10a7d40, p=p@entry=0x7ffd8ff73b90) at namespace.c:570
> 570                     try(ndctl_dax, set_uuid, dax, uuid);
> (gdb) info locals
> __rc = <optimized out>
> dax = 0x0
>
> What I did was to let 2 threads run "create-namespace all" in a tight
> loop, and 2 other threads run "destroy-namespace all" in a tight loop,

This will definitely cause libndctl to get confused the expectation is
that only one ndctl instance is operating on one region at a time.
What likely happened is TOCTOU in ndctl_region_get_pfn_seed() where
the seed device name is destroyed by the time it tries to convert it
to an ndctl object. The reason libndctl does not perform its own
locking is to keep the library stateless and allow locking to imposed
from a higher level. Two ndctl instances must not be allowed to
operate in the same region otherwise the 2 libndctl instances will get
out of sync.

This is no different than 2 fdisk processes running at the same time,
they are going to invalidate each other's view of the cached partition
state. The fix is not for fdisk to implement locking internally
instead it requires the admin to arrange for only one fdisk to run
against one disk at a time.

> while chasing an year old issue that randomly resurfaces -
> "nd_region region1: allocation underrun: 0x0 of 0x40000000 bytes"

It would be interesting to get more data on the sequence of
allocations that lead up to this event, and a dump of the resource
tree when this happens:

for (i = 0; i < nd_region->ndr_mappings; i++)
    ndd = to_ndd(&nd_region->mapping[i]);
    for_each_dpa_resource(...)
        nd_dbg_dpa(...)


>
> In addition, there are kmemleaks,
> # cat /sys/kernel/debug/kmemleak
> [..]
> unreferenced object 0xffff976bd46f6240 (size 64):
>    comm "ndctl", pid 23556, jiffies 4299514316 (age 5406.733s)
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 00 00 20 c3 37 00 00 00  .......... .7...
>      ff ff ff 7f 38 00 00 00 00 00 00 00 00 00 00 00  ....8...........
>    backtrace:
>      [<00000000064003cf>] __kmalloc_track_caller+0x136/0x379
>      [<00000000d85e3c52>] krealloc+0x67/0x92
>      [<00000000d7d3ba8a>] __alloc_dev_dax_range+0x73/0x25c
>      [<0000000027d58626>] devm_create_dev_dax+0x27d/0x416
>      [<00000000434abd43>] __dax_pmem_probe+0x1c9/0x1000 [dax_pmem_core]
>      [<0000000083726c1c>] dax_pmem_probe+0x10/0x1f [dax_pmem]
>      [<00000000b5f2319c>] nvdimm_bus_probe+0x9d/0x340 [libnvdimm]
>      [<00000000c055e544>] really_probe+0x230/0x48d
>      [<000000006cabd38e>] driver_probe_device+0x122/0x13b
>      [<0000000029c7b95a>] device_driver_attach+0x5b/0x60
>      [<0000000053e5659b>] bind_store+0xb7/0xc3
>      [<00000000d3bdaadc>] drv_attr_store+0x27/0x31
>      [<00000000949069c5>] sysfs_kf_write+0x4a/0x57
>      [<000000004a8b5adf>] kernfs_fop_write+0x150/0x1e5
>      [<00000000bded60f0>] __vfs_write+0x1b/0x34
>      [<00000000b92900f0>] vfs_write+0xd8/0x1d1

Hmm... maybe this?

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 27513d311242..506549235e03 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -1393,6 +1393,7 @@ struct dev_dax *devm_create_dev_dax(struct
dev_dax_data *data)
 err_pgmap:
        free_dev_dax_ranges(dev_dax);
 err_range:
+       kfree(dev_dax->ranges);
        free_dev_dax_id(dev_dax);
 err_id:
        kfree(dev_dax);
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
