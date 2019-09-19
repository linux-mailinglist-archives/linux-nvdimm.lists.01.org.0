Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 636F7B7348
	for <lists+linux-nvdimm@lfdr.de>; Thu, 19 Sep 2019 08:40:08 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 658CB202EBEAD;
	Wed, 18 Sep 2019 23:39:15 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::d41; helo=mail-io1-xd41.google.com;
 envelope-from=dan.j.williams@gmail.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com
 [IPv6:2607:f8b0:4864:20::d41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 31FB021959CB2
 for <linux-nvdimm@lists.01.org>; Wed, 18 Sep 2019 23:39:14 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id m11so5234101ioo.0
 for <linux-nvdimm@lists.01.org>; Wed, 18 Sep 2019 23:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dReIE9rc6h5JdrB0YHk9PxSqeYXqz450LSfK300aT3M=;
 b=WEAEeo+NQiIF/QMhMHlZZ3jSJtuJhNBwXVBLEqvO8AN3uO81Sp3GPOSPGkStFtC4UD
 6A2WBjyHw99hF8EH80q80oL/mW+AvWsfYJ2InjypORCCAFjFKhCYPMx39actm6D7gmov
 eH9+jDeLLYKrTmygZnLS7Boi6NLu1WMzExO/WRd/NAkLuEHr9IctGSOUwCkFZ71j2UOQ
 ePUYY1ihCKJbC/+cR0WahDNy+gsckM4vhkdNU//lrl2maIOc6Rp0ugkcTBQuuK9WTbBs
 AMVcf51eo+9iAPSUpZ5K6s9t6tTMMfzBDlDkE7+Ve6OJ/jZriySfTY6ZeiGZXEc6m7I5
 n6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dReIE9rc6h5JdrB0YHk9PxSqeYXqz450LSfK300aT3M=;
 b=tA5cjFxeB2Bm8FGPU9PZQU3mx1pLGCOZJBI/EuFEsREiKOCmB7Q6bg9hRIwg9K/8bs
 Eovex0HKqvMO0PPvaIXFLvkguOVVXHnAz1mLUKgrBW/dkHo6Hiw5OUAE8WN7j/dnoEQD
 mWYR4PpHD4iFXXwjTUmWD1gcCJBHsidjbPAKgjY5dMkK6k8jn8FUh6rPy3pu4z4LCSnv
 6+X9HmdRD/HHrmObYZBkIF/GoAztvJppyOpk1N0nPTlaKkwu4Ej1tjw4CJEjgWhsVXVH
 1UMcZH9Y7gbHcXZKnHYqxlk/b7MNwIuqqPHXTsvPOAz6Sua0ckWRkYUrta/cG8cjDooq
 2u3A==
X-Gm-Message-State: APjAAAVLKh4FCSzx22q6CgUnpe29AbkPY6fZyDJzTJpnsVEn16wUdrXG
 sjBdLyKMUz8+vSPVYqlP/aUVRJeUSERGfwC0qGo=
X-Google-Smtp-Source: APXvYqz3thQReWTyRG3MXBX476u72dFdLlsu+QCTvdZQQTknbLWixrUhRsKLr/pkFu+cAa6cZ4updIXgDj+EHltCf9Y=
X-Received: by 2002:a6b:a0d:: with SMTP id z13mr9511035ioi.5.1568875204244;
 Wed, 18 Sep 2019 23:40:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190917152544.11216-1-aneesh.kumar@linux.ibm.com>
 <CAPcyv4hs3eAp-=6_9k6UqACafsiR2PpapdXOAVEiS5PeChFFOg@mail.gmail.com>
 <d4466bb4-0747-fc6b-1847-98d707c999dc@linux.ibm.com>
In-Reply-To: <d4466bb4-0747-fc6b-1847-98d707c999dc@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 18 Sep 2019 23:39:52 -0700
Message-ID: <CAA9_cmfhyQ3ZXWMbDQMUgqD2ODBCPju8O_6V2N_OGBXe-gaWKw@mail.gmail.com>
Subject: Re: [PATCH v2] libnvdimm/region: Initialize bad block for volatile
 namespaces
To: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
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

On Wed, Sep 18, 2019, 8:49 PM Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
wrote:

> On 9/19/19 4:05 AM, Dan Williams wrote:
> > On Tue, Sep 17, 2019 at 8:25 AM Aneesh Kumar K.V
> > <aneesh.kumar@linux.ibm.com> wrote:
> >>
> >> We do check for a bad block during namespace init and that use
> >> region bad block list. We need to initialize the bad block
> >> for volatile regions for this to work. We also observe a lockdep
> >> warning as below because the lock is not initialized correctly
> >> since we skip bad block init for volatile regions.
> >>
> >>   INFO: trying to register non-static key.
> >>   the code is fine but needs lockdep annotation.
> >>   turning off the locking correctness validator.
> >>   CPU: 2 PID: 1 Comm: swapper/0 Not tainted
> 5.3.0-rc1-15699-g3dee241c937e #149
> >>   Call Trace:
> >>   [c0000000f95cb250] [c00000000147dd84] dump_stack+0xe8/0x164
> (unreliable)
> >>   [c0000000f95cb2a0] [c00000000022ccd8] register_lock_class+0x308/0xa60
> >>   [c0000000f95cb3a0] [c000000000229cc0] __lock_acquire+0x170/0x1ff0
> >>   [c0000000f95cb4c0] [c00000000022c740] lock_acquire+0x220/0x270
> >>   [c0000000f95cb580] [c000000000a93230] badblocks_check+0xc0/0x290
> >>   [c0000000f95cb5f0] [c000000000d97540] nd_pfn_validate+0x5c0/0x7f0
> >>   [c0000000f95cb6d0] [c000000000d98300] nd_dax_probe+0xd0/0x1f0
> >>   [c0000000f95cb760] [c000000000d9b66c] nd_pmem_probe+0x10c/0x160
> >>   [c0000000f95cb790] [c000000000d7f5ec] nvdimm_bus_probe+0x10c/0x240
> >>   [c0000000f95cb820] [c000000000d0f844] really_probe+0x254/0x4e0
> >>   [c0000000f95cb8b0] [c000000000d0fdfc] driver_probe_device+0x16c/0x1e0
> >>   [c0000000f95cb930] [c000000000d10238] device_driver_attach+0x68/0xa0
> >>   [c0000000f95cb970] [c000000000d1040c] __driver_attach+0x19c/0x1c0
> >>   [c0000000f95cb9f0] [c000000000d0c4c4] bus_for_each_dev+0x94/0x130
> >>   [c0000000f95cba50] [c000000000d0f014] driver_attach+0x34/0x50
> >>   [c0000000f95cba70] [c000000000d0e208] bus_add_driver+0x178/0x2f0
> >>   [c0000000f95cbb00] [c000000000d117c8] driver_register+0x108/0x170
> >>   [c0000000f95cbb70] [c000000000d7edb0] __nd_driver_register+0xe0/0x100
> >>   [c0000000f95cbbd0] [c000000001a6baa4] nd_pmem_driver_init+0x34/0x48
> >>   [c0000000f95cbbf0] [c0000000000106f4] do_one_initcall+0x1d4/0x4b0
> >>   [c0000000f95cbcd0] [c0000000019f499c] kernel_init_freeable+0x544/0x65c
> >>   [c0000000f95cbdb0] [c000000000010d6c] kernel_init+0x2c/0x180
> >>   [c0000000f95cbe20] [c00000000000b954] ret_from_kernel_thread+0x5c/0x68
> >>
> >> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> >> ---
> >> Changes from V1:
> >> * update commit subject
> >
> > What about the is_nd_pmem() call in nvdimm_clear_badblocks_region()?
> >
>
> Missed that. Yes that also needs an updatet. Will you be able to update
> that or you want me to send a V3?
>

v3 please so it will get superseded in patchwork, and can keep the
correlation between patchwork id and kernel commit.

(sent from my phone, forgive the HTML mail)
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
