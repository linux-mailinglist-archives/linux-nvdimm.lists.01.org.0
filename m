Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04877B6F64
	for <lists+linux-nvdimm@lfdr.de>; Thu, 19 Sep 2019 00:35:45 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A2B3E21A00AE6;
	Wed, 18 Sep 2019 15:34:54 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::242; helo=mail-oi1-x242.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com
 [IPv6:2607:f8b0:4864:20::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 21A62202EA41E
 for <linux-nvdimm@lists.01.org>; Wed, 18 Sep 2019 15:34:53 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id k20so1070454oih.3
 for <linux-nvdimm@lists.01.org>; Wed, 18 Sep 2019 15:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CYfSWYACGFxZkGTZQX4FiG/34xS/3Dj07lx54IrjUuE=;
 b=BZIQLhIyFah99oRFUo4jY2oxJvXSFZJshiX7k8PjON1hnqQWVurB+0M4MGYBYam2HC
 fnVhxG6DXDvImYMBH0TQyb10FIULW4s6HaOjLJxHAjhLX13KaI+HfBRbrhnZSEE1pMmt
 LO44bK5XJiOCPCiksUaizwwIxxPYVqQqu3YZBNhIOM4JbGTQ5Ok7coabqLd+9ITpXk0l
 dOpMfF003O/kvdhz/49SenJPYBDMmeciO4Sm9BrCzmJedkRtmcLEo9fjrAYud/DFVmvS
 vKDqe0XdrvpJCPEcMh0VNHGD61bJqLEbdQ6elhxzGr/Q/a4qaCCtqTWoE7YjrOYzXvTd
 1asw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CYfSWYACGFxZkGTZQX4FiG/34xS/3Dj07lx54IrjUuE=;
 b=k+FvfX/AnCLIAmA5Umea7twEdRALelcvO7yFXcZTtJnhHh5+vXFNmZ5LElS7NB8dXt
 AxaDhxWu72i3oL6/7VGvCwfWuDpgmL/uE1GUxT+T6HH8h9XGZEpeDkLv+gcFsz3/WyKK
 iLcLfFSB7+xkaFzYB088pihLRwzdkUC8YRCaJTThgI6EH/rNWafq+A7I7VeTJSRwuokI
 AEGzgiMwh5CR03RunlqY5exUyx6QlM1wNz8UfmOM7O4/J+YrqUG8/hGjX14XgzOqLMH1
 pVxh3oTEJ2gLWjWWMMrBe2ZzeaRvv7gwdpCdTV3x6sgDKWpDNnj5xStgYYgXr9QIxa5m
 pdxg==
X-Gm-Message-State: APjAAAX3O9jsDd1W0coW6exTWxiDemXyOvtf+VoobdOo2z2wfuOvEd/w
 lozLkac2pMjjYCYPz5HKb3kClQAbRrLNXvToOWezHw==
X-Google-Smtp-Source: APXvYqyDrwbYmf02ERRRngJ39fdlmbmG9CCmGZzhNUvIvevwfSfK/DMUnRmHILKbYfrdj2bYcezaqnUWsOCDdUqie6A=
X-Received: by 2002:a54:4f13:: with SMTP id e19mr181153oiy.149.1568846141840; 
 Wed, 18 Sep 2019 15:35:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190917152544.11216-1-aneesh.kumar@linux.ibm.com>
In-Reply-To: <20190917152544.11216-1-aneesh.kumar@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 18 Sep 2019 15:35:30 -0700
Message-ID: <CAPcyv4hs3eAp-=6_9k6UqACafsiR2PpapdXOAVEiS5PeChFFOg@mail.gmail.com>
Subject: Re: [PATCH v2] libnvdimm/region: Initialize bad block for volatile
 namespaces
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue, Sep 17, 2019 at 8:25 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> We do check for a bad block during namespace init and that use
> region bad block list. We need to initialize the bad block
> for volatile regions for this to work. We also observe a lockdep
> warning as below because the lock is not initialized correctly
> since we skip bad block init for volatile regions.
>
>  INFO: trying to register non-static key.
>  the code is fine but needs lockdep annotation.
>  turning off the locking correctness validator.
>  CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.3.0-rc1-15699-g3dee241c937e #149
>  Call Trace:
>  [c0000000f95cb250] [c00000000147dd84] dump_stack+0xe8/0x164 (unreliable)
>  [c0000000f95cb2a0] [c00000000022ccd8] register_lock_class+0x308/0xa60
>  [c0000000f95cb3a0] [c000000000229cc0] __lock_acquire+0x170/0x1ff0
>  [c0000000f95cb4c0] [c00000000022c740] lock_acquire+0x220/0x270
>  [c0000000f95cb580] [c000000000a93230] badblocks_check+0xc0/0x290
>  [c0000000f95cb5f0] [c000000000d97540] nd_pfn_validate+0x5c0/0x7f0
>  [c0000000f95cb6d0] [c000000000d98300] nd_dax_probe+0xd0/0x1f0
>  [c0000000f95cb760] [c000000000d9b66c] nd_pmem_probe+0x10c/0x160
>  [c0000000f95cb790] [c000000000d7f5ec] nvdimm_bus_probe+0x10c/0x240
>  [c0000000f95cb820] [c000000000d0f844] really_probe+0x254/0x4e0
>  [c0000000f95cb8b0] [c000000000d0fdfc] driver_probe_device+0x16c/0x1e0
>  [c0000000f95cb930] [c000000000d10238] device_driver_attach+0x68/0xa0
>  [c0000000f95cb970] [c000000000d1040c] __driver_attach+0x19c/0x1c0
>  [c0000000f95cb9f0] [c000000000d0c4c4] bus_for_each_dev+0x94/0x130
>  [c0000000f95cba50] [c000000000d0f014] driver_attach+0x34/0x50
>  [c0000000f95cba70] [c000000000d0e208] bus_add_driver+0x178/0x2f0
>  [c0000000f95cbb00] [c000000000d117c8] driver_register+0x108/0x170
>  [c0000000f95cbb70] [c000000000d7edb0] __nd_driver_register+0xe0/0x100
>  [c0000000f95cbbd0] [c000000001a6baa4] nd_pmem_driver_init+0x34/0x48
>  [c0000000f95cbbf0] [c0000000000106f4] do_one_initcall+0x1d4/0x4b0
>  [c0000000f95cbcd0] [c0000000019f499c] kernel_init_freeable+0x544/0x65c
>  [c0000000f95cbdb0] [c000000000010d6c] kernel_init+0x2c/0x180
>  [c0000000f95cbe20] [c00000000000b954] ret_from_kernel_thread+0x5c/0x68
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
> Changes from V1:
> * update commit subject

What about the is_nd_pmem() call in nvdimm_clear_badblocks_region()?
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
