Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F91C6C95A
	for <lists+linux-nvdimm@lfdr.de>; Thu, 18 Jul 2019 08:40:04 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 50D9E212C01F8;
	Wed, 17 Jul 2019 23:42:30 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 2BB53212C01DB
 for <linux-nvdimm@lists.01.org>; Wed, 17 Jul 2019 23:42:27 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id j11so3593518otp.10
 for <linux-nvdimm@lists.01.org>; Wed, 17 Jul 2019 23:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IyEgWa0WdxBWBa6CzxcMcVHbwCGtaOL4SMdcfx2LKzA=;
 b=OECf+WpeGSYLwM1UPTrEag6W4xZtDFGcdAV6czFUyazKwY7DxPaFLoJB9baFzMb4Rw
 zOnfjQ+5NEySGHin2V0JqgZc6DW8ADr9+tVIU/VdGrdQbyFXr0exIEYP7nYZqBIQb0kM
 FSUlnjqJcegqGdXL1KSR9TS+AWZFOBFVSoeY6YqNYDQ8SqGJQ6wh+Y4oRb0zyzKG4RXt
 viMY6DoKhRBk1JkSvdO+8uI35dPHHIBV41lj7kkHKHdzPKXzpgSWUe/lXj9CURFQYGFu
 5nJ4JK08EzY3Ut+d06TzicyadD8Jb/qrZPlsSBJ0vpY5ODNeRcXG+6hSlw33Vx5JNlhV
 IUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IyEgWa0WdxBWBa6CzxcMcVHbwCGtaOL4SMdcfx2LKzA=;
 b=VXipFyKqMK3tBvylRJV17folQdkpfNZIFaL/cclFmyfEJPQRNfH/1vyrDdxZbRmq8/
 btecEApBbTi3fMlBfcaszN285Mg7hfSWP6n4/al9A9PWxzylKjU38j6grb6CJhxHR3qY
 8Z1I6QkhyyudCTqPgQE1QcVlArdiD9BLDLWZo62bcBLRY56xR/vg4G14dmh8XYWYFLuu
 b6VWtb6n2tntDmFoBNKupCFdJecgVNfUWpB2am4DxhB7O/fxoGo29g2eILcEHejZE2yH
 JwR5QTQtE7hkF/dspdZinnKT/i1FRvJts8XKU/m3kSJmYXvyk1zXPBeiPgEoCh4R9Xz9
 pLMw==
X-Gm-Message-State: APjAAAXANnERLPJLdehJqPmj7JfRUA0kDNMa6oetvHk0l1QD9nPXSsaa
 B+B1ENVExFeUxEwZPuBEGO2Mtjpl0dNPsyCxgsmUxA==
X-Google-Smtp-Source: APXvYqxEZPirCKzLti2T8g/ZGZW8+7qImlrZqKYAXzSphnUUeZ01QoSasYDLyCIp6qmv7Xjbb+opoHhbofOs1T0uf1Q=
X-Received: by 2002:a9d:470d:: with SMTP id a13mr32351754otf.126.1563431997958; 
 Wed, 17 Jul 2019 23:39:57 -0700 (PDT)
MIME-Version: 1.0
References: <156341206785.292348.1660822720191643298.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156341210094.292348.2384694131126767789.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190718020448.GE3079@sasha-vm>
In-Reply-To: <20190718020448.GE3079@sasha-vm>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 17 Jul 2019 23:39:47 -0700
Message-ID: <CAPcyv4gMKqxQ0WNeJ3p5XW2cDkNs0+tsViS5MXB+eDXeGcHPjA@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] libnvdimm/bus: Fix wait_nvdimm_bus_probe_idle()
 ABBA deadlock
To: Sasha Levin <sashal@kernel.org>
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
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Jul 17, 2019 at 7:05 PM Sasha Levin <sashal@kernel.org> wrote:
>
> On Wed, Jul 17, 2019 at 06:08:21PM -0700, Dan Williams wrote:
> >A multithreaded namespace creation/destruction stress test currently
> >deadlocks with the following lockup signature:
> >
> >    INFO: task ndctl:2924 blocked for more than 122 seconds.
> >          Tainted: G           OE     5.2.0-rc4+ #3382
> >    "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> >    ndctl           D    0  2924   1176 0x00000000
> >    Call Trace:
> >     ? __schedule+0x27e/0x780
> >     schedule+0x30/0xb0
> >     wait_nvdimm_bus_probe_idle+0x8a/0xd0 [libnvdimm]
> >     ? finish_wait+0x80/0x80
> >     uuid_store+0xe6/0x2e0 [libnvdimm]
> >     kernfs_fop_write+0xf0/0x1a0
> >     vfs_write+0xb7/0x1b0
> >     ksys_write+0x5c/0xd0
> >     do_syscall_64+0x60/0x240
> >
> >     INFO: task ndctl:2923 blocked for more than 122 seconds.
> >           Tainted: G           OE     5.2.0-rc4+ #3382
> >     "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> >     ndctl           D    0  2923   1175 0x00000000
> >     Call Trace:
> >      ? __schedule+0x27e/0x780
> >      ? __mutex_lock+0x489/0x910
> >      schedule+0x30/0xb0
> >      schedule_preempt_disabled+0x11/0x20
> >      __mutex_lock+0x48e/0x910
> >      ? nvdimm_namespace_common_probe+0x95/0x4d0 [libnvdimm]
> >      ? __lock_acquire+0x23f/0x1710
> >      ? nvdimm_namespace_common_probe+0x95/0x4d0 [libnvdimm]
> >      nvdimm_namespace_common_probe+0x95/0x4d0 [libnvdimm]
> >      __dax_pmem_probe+0x5e/0x210 [dax_pmem_core]
> >      ? nvdimm_bus_probe+0x1d0/0x2c0 [libnvdimm]
> >      dax_pmem_probe+0xc/0x20 [dax_pmem]
> >      nvdimm_bus_probe+0x90/0x2c0 [libnvdimm]
> >      really_probe+0xef/0x390
> >      driver_probe_device+0xb4/0x100
> >
> >In this sequence an 'nd_dax' device is being probed and trying to take
> >the lock on its backing namespace to validate that the 'nd_dax' device
> >indeed has exclusive access to the backing namespace. Meanwhile, another
> >thread is trying to update the uuid property of that same backing
> >namespace. So one thread is in the probe path trying to acquire the
> >lock, and the other thread has acquired the lock and tries to flush the
> >probe path.
> >
> >Fix this deadlock by not holding the namespace device_lock over the
> >wait_nvdimm_bus_probe_idle() synchronization step. In turn this requires
> >the device_lock to be held on entry to wait_nvdimm_bus_probe_idle() and
> >subsequently dropped internally to wait_nvdimm_bus_probe_idle().
> >
> >Cc: <stable@vger.kernel.org>
> >Fixes: bf9bccc14c05 ("libnvdimm: pmem label sets and namespace instantiation")
> >Cc: Vishal Verma <vishal.l.verma@intel.com>
> >Tested-by: Jane Chu <jane.chu@oracle.com>
> >Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> Hi Dan,
>
> The way these patches are split, when we take them to stable this patch
> won't apply because it wants "libnvdimm/bus: Prepare the nd_ioctl() path
> to be re-entrant".
>
> If you were to send another iteration of this patchset, could you please
> re-order the patches so they will apply cleanly to stable? this will
> help with reducing mail exchanges later on and possibly a mis-merge into
> stable.
>
> If not, this should serve as a reference for future us to double check
> the backport.

Oh we should backport all of them. I'll tag that one for -stable as
well. It's a hard pre-requisite for the fix.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
