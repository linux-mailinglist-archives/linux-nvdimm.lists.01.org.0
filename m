Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8E16C4C9
	for <lists+linux-nvdimm@lfdr.de>; Thu, 18 Jul 2019 04:04:52 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 201C4212C01EB;
	Wed, 17 Jul 2019 19:07:19 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=sashal@kernel.org;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 4ADC4212C01E1
 for <linux-nvdimm@lists.01.org>; Wed, 17 Jul 2019 19:07:18 -0700 (PDT)
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 721E0205F4;
 Thu, 18 Jul 2019 02:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1563415489;
 bh=IlFLXWD66Je93ddE8P2KBQiIDc6A3q7YUNHssh7SATw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pfc80XueSJ3B4Cv4x9oiFuBr1Y3WWmpnMmsgvWgsdvGeyrK7W+gBi8hNZKM3vXNd6
 Mge8KjMGYEmWl7GTBEJ4Li9KRnFpxpd8iwYj92rK2p07xktkd9ReOfPA9/v4sEFdM7
 SNYhxes6eOfwi01dIvRYIePtDUNmm7SfAZ27gRec=
Date: Wed, 17 Jul 2019 22:04:48 -0400
From: Sasha Levin <sashal@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 6/7] libnvdimm/bus: Fix wait_nvdimm_bus_probe_idle()
 ABBA deadlock
Message-ID: <20190718020448.GE3079@sasha-vm>
References: <156341206785.292348.1660822720191643298.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156341210094.292348.2384694131126767789.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <156341210094.292348.2384694131126767789.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: linux-nvdimm@lists.01.org, peterz@infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Jul 17, 2019 at 06:08:21PM -0700, Dan Williams wrote:
>A multithreaded namespace creation/destruction stress test currently
>deadlocks with the following lockup signature:
>
>    INFO: task ndctl:2924 blocked for more than 122 seconds.
>          Tainted: G           OE     5.2.0-rc4+ #3382
>    "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>    ndctl           D    0  2924   1176 0x00000000
>    Call Trace:
>     ? __schedule+0x27e/0x780
>     schedule+0x30/0xb0
>     wait_nvdimm_bus_probe_idle+0x8a/0xd0 [libnvdimm]
>     ? finish_wait+0x80/0x80
>     uuid_store+0xe6/0x2e0 [libnvdimm]
>     kernfs_fop_write+0xf0/0x1a0
>     vfs_write+0xb7/0x1b0
>     ksys_write+0x5c/0xd0
>     do_syscall_64+0x60/0x240
>
>     INFO: task ndctl:2923 blocked for more than 122 seconds.
>           Tainted: G           OE     5.2.0-rc4+ #3382
>     "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>     ndctl           D    0  2923   1175 0x00000000
>     Call Trace:
>      ? __schedule+0x27e/0x780
>      ? __mutex_lock+0x489/0x910
>      schedule+0x30/0xb0
>      schedule_preempt_disabled+0x11/0x20
>      __mutex_lock+0x48e/0x910
>      ? nvdimm_namespace_common_probe+0x95/0x4d0 [libnvdimm]
>      ? __lock_acquire+0x23f/0x1710
>      ? nvdimm_namespace_common_probe+0x95/0x4d0 [libnvdimm]
>      nvdimm_namespace_common_probe+0x95/0x4d0 [libnvdimm]
>      __dax_pmem_probe+0x5e/0x210 [dax_pmem_core]
>      ? nvdimm_bus_probe+0x1d0/0x2c0 [libnvdimm]
>      dax_pmem_probe+0xc/0x20 [dax_pmem]
>      nvdimm_bus_probe+0x90/0x2c0 [libnvdimm]
>      really_probe+0xef/0x390
>      driver_probe_device+0xb4/0x100
>
>In this sequence an 'nd_dax' device is being probed and trying to take
>the lock on its backing namespace to validate that the 'nd_dax' device
>indeed has exclusive access to the backing namespace. Meanwhile, another
>thread is trying to update the uuid property of that same backing
>namespace. So one thread is in the probe path trying to acquire the
>lock, and the other thread has acquired the lock and tries to flush the
>probe path.
>
>Fix this deadlock by not holding the namespace device_lock over the
>wait_nvdimm_bus_probe_idle() synchronization step. In turn this requires
>the device_lock to be held on entry to wait_nvdimm_bus_probe_idle() and
>subsequently dropped internally to wait_nvdimm_bus_probe_idle().
>
>Cc: <stable@vger.kernel.org>
>Fixes: bf9bccc14c05 ("libnvdimm: pmem label sets and namespace instantiation")
>Cc: Vishal Verma <vishal.l.verma@intel.com>
>Tested-by: Jane Chu <jane.chu@oracle.com>
>Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Hi Dan,

The way these patches are split, when we take them to stable this patch
won't apply because it wants "libnvdimm/bus: Prepare the nd_ioctl() path
to be re-entrant".

If you were to send another iteration of this patchset, could you please
re-order the patches so they will apply cleanly to stable? this will
help with reducing mail exchanges later on and possibly a mis-merge into
stable.

If not, this should serve as a reference for future us to double check
the backport.

--
Thanks,
Sasha
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
