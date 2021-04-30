Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D7537010E
	for <lists+linux-nvdimm@lfdr.de>; Fri, 30 Apr 2021 21:14:46 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 65BC5100EB33F;
	Fri, 30 Apr 2021 12:14:43 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::635; helo=mail-ej1-x635.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E993F100EB33A
	for <linux-nvdimm@lists.01.org>; Fri, 30 Apr 2021 12:14:39 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id t4so23533058ejo.0
        for <linux-nvdimm@lists.01.org>; Fri, 30 Apr 2021 12:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SVaZEa6T1OlZEI2ZRCjaeg3vEy1Vw6FSwiGIGLqhRiA=;
        b=hSmPGg1woGCWrtib2vDCyHADvNbcXMWY1N4HZoA/Dc0dDn6CIy7oepwfhpSWXQOPAb
         jQSMM2z7PqF5Aeps791PdAuKxHPLHrTIpO3qkwC1U244YOPo3rtC/fJt0zEp+0kh0/qo
         qQWTPvjSFUOLd9HLmgxmuzOXIi2Fh8ruvZrwf1wcv8p1VGQB8KrwlHx5bDb3uHno2BKp
         u9fcgEP+3lbmp+TXxVTo5ZpyBJ4dQUoDggD/ilqOHSP3jjWVembDw/rdFWmcQYId4h3X
         u2LHIta0hJrnJcZFKFPK/ewDqKJGyV+DZxXUPSAeytK2WJI/dZylwU4jqTJr186rjN2b
         fYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SVaZEa6T1OlZEI2ZRCjaeg3vEy1Vw6FSwiGIGLqhRiA=;
        b=Hk4tgrLnqmJiy4hxrm9eT7v6AEqTkTGsUIF/s2CMBM2c/6sQBndYoOFtq+pmT8fIwF
         UwW2vLsuCrmnWmTdx8OJTqQ08FnOjWiDNlA6DS5JWGMsxgDWfO+EkVweJ5IltgOXFNgG
         5wSjnOHxPajTIjB3RPSKqwnjXXvNFYBnRdEI5vJdh0q+KXv3EC/EGVQ9mVgpYPiXMU2O
         ljECPqkgVWiX6zMBzegvDfqI8VyBQyqanc4YzWPd00C/x0urFqqGxd38ETRc9OxcMoMa
         eDpzMYWR/dvo//do0/nJkdK9ELPMlQJ7oMPXwBdKQpnYwCbyt+NqajDD6+vH2w14WVo9
         SFhw==
X-Gm-Message-State: AOAM531TY/4WKHZdQwu4JfeEMWcyezGUREBpWeQux4HFx+Zyh8t6Iwa+
	fLtthjTXPgkeDXO9ryWIsMzG2S+5HaHyMi5x2iapmw==
X-Google-Smtp-Source: ABdhPJxWhl/4Wl06Jd4YyX/1fomQ8w4q0Aps7EkyT3DYr4nAK1VxEw092nPbBy4Dz9d/BnILBkCFzTz+uUt2sIudWMY=
X-Received: by 2002:a17:907:1183:: with SMTP id uz3mr6068141ejb.264.1619810077593;
 Fri, 30 Apr 2021 12:14:37 -0700 (PDT)
MIME-Version: 1.0
References: <161966810162.652.13723419108625443430.stgit@17be908f7c1c>
In-Reply-To: <161966810162.652.13723419108625443430.stgit@17be908f7c1c>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 30 Apr 2021 12:14:37 -0700
Message-ID: <CAPcyv4gwkyDBG7EZOth-kcZR8Fb+RgGXY=Y9vbuHXAz3PAnLVw@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] nvdimm: Enable sync-dax property for nvdimm
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Message-ID-Hash: UMCEA7B3YCDOTZ6VQLQNGBQVOIEZGR3C
X-Message-ID-Hash: UMCEA7B3YCDOTZ6VQLQNGBQVOIEZGR3C
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, marcel.apfelbaum@gmail.com, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, peter.maydell@linaro.org, Eric Blake <eblake@redhat.com>, qemu-arm@nongnu.org, richard.henderson@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Haozhong Zhang <haozhong.zhang@intel.com>, shameerali.kolothum.thodi@huawei.com, kwangwoo.lee@sk.com, Markus Armbruster <armbru@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, kvm-ppc@vger.kernel.org, shivaprasadbhat@gmail.com, bharata@linux.vnet.ibm.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UMCEA7B3YCDOTZ6VQLQNGBQVOIEZGR3C/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Some corrections to terminology confusion below...


On Wed, Apr 28, 2021 at 8:49 PM Shivaprasad G Bhat <sbhat@linux.ibm.com> wrote:
>
> The nvdimm devices are expected to ensure write persistence during power
> failure kind of scenarios.

No, QEMU is not expected to make that guarantee. QEMU is free to lie
to the guest about the persistence guarantees of the guest PMEM
ranges. It's more accurate to say that QEMU nvdimm devices can emulate
persistent memory and optionally pass through host power-fail
persistence guarantees to the guest. The power-fail persistence domain
can be one of "cpu_cache", or "memory_controller" if the persistent
memory region is "synchronous". If the persistent range is not
synchronous, it really isn't "persistent memory"; it's memory mapped
storage that needs I/O commands to flush.

> The libpmem has architecture specific instructions like dcbf on POWER

Which "libpmem" is this? PMDK is a reference library not a PMEM
interface... maybe I'm missing what libpmem has to do with QEMU?

> to flush the cache data to backend nvdimm device during normal writes
> followed by explicit flushes if the backend devices are not synchronous
> DAX capable.
>
> Qemu - virtual nvdimm devices are memory mapped. The dcbf in the guest
> and the subsequent flush doesn't traslate to actual flush to the backend

s/traslate/translate/

> file on the host in case of file backed v-nvdimms. This is addressed by
> virtio-pmem in case of x86_64 by making explicit flushes translating to
> fsync at qemu.

Note that virtio-pmem was a proposal for a specific optimization of
allowing guests to share page cache. The virtio-pmem approach is not
to be confused with actual persistent memory.

> On SPAPR, the issue is addressed by adding a new hcall to
> request for an explicit flush from the guest ndctl driver when the backend

What is an "ndctl" driver? ndctl is userspace tooling, do you mean the
guest pmem driver?

> nvdimm cannot ensure write persistence with dcbf alone. So, the approach
> here is to convey when the hcall flush is required in a device tree
> property. The guest makes the hcall when the property is found, instead
> of relying on dcbf.
>
> A new device property sync-dax is added to the nvdimm device. When the
> sync-dax is 'writeback'(default for PPC), device property
> "hcall-flush-required" is set, and the guest makes hcall H_SCM_FLUSH
> requesting for an explicit flush.

I'm not sure "sync-dax" is a suitable name for the property of the
guest persistent memory. There is no requirement that the
memory-backend file for a guest be a dax-capable file. It's also
implementation specific what hypercall needs to be invoked for a given
occurrence of "sync-dax". What does that map to on non-PPC platforms
for example? It seems to me that an "nvdimm" device presents the
synchronous usage model and a whole other device type implements an
async-hypercall setup that the guest happens to service with its
nvdimm stack, but it's not an "nvdimm" anymore at that point.

> sync-dax is "unsafe" on all other platforms(x86, ARM) and old pseries machines
> prior to 5.2 on PPC. sync-dax="writeback" on ARM and x86_64 is prevented
> now as the flush semantics are unimplemented.

"sync-dax" has no meaning on its own, I think this needs an explicit
mechanism to convey both the "not-sync" property *and* the callback
method, it shouldn't be inferred by arch type.

> When the backend file is actually synchronous DAX capable and no explicit
> flushes are required, the sync-dax mode 'direct' is to be used.
>
> The below demonstration shows the map_sync behavior with sync-dax writeback &
> direct.
> (https://github.com/avocado-framework-tests/avocado-misc-tests/blob/master/memory/ndctl.py.data/map_sync.c)
>
> The pmem0 is from nvdimm with With sync-dax=direct, and pmem1 is from
> nvdimm with syn-dax=writeback, mounted as
> /dev/pmem0 on /mnt1 type xfs (rw,relatime,attr2,dax=always,inode64,logbufs=8,logbsize=32k,noquota)
> /dev/pmem1 on /mnt2 type xfs (rw,relatime,attr2,dax=always,inode64,logbufs=8,logbsize=32k,noquota)
>
> [root@atest-guest ~]# ./mapsync /mnt1/newfile ----> When sync-dax=unsafe/direct
> [root@atest-guest ~]# ./mapsync /mnt2/newfile ----> when sync-dax=writeback
> Failed to mmap  with Operation not supported
>
> The first patch does the header file cleanup necessary for the
> subsequent ones. Second patch implements the hcall, adds the necessary
> vmstate properties to spapr machine structure for carrying the hcall
> status during save-restore. The nature of the hcall being asynchronus,
> the patch uses aio utilities to offload the flush. The third patch adds
> the 'sync-dax' device property and enables the device tree property
> for the guest to utilise the hcall.
>
> The kernel changes to exploit this hcall is at
> https://github.com/linuxppc/linux/commit/75b7c05ebf9026.patch
>
> ---
> v3 - https://lists.gnu.org/archive/html/qemu-devel/2021-03/msg07916.html
> Changes from v3:
>       - Fixed the forward declaration coding guideline violations in 1st patch.
>       - Removed the code waiting for the flushes to complete during migration,
>         instead restart the flush worker on destination qemu in post load.
>       - Got rid of the randomization of the flush tokens, using simple
>         counter.
>       - Got rid of the redundant flush state lock, relying on the BQL now.
>       - Handling the memory-backend-ram usage
>       - Changed the sync-dax symantics from on/off to 'unsafe','writeback' and 'direct'.
>         Added prevention code using 'writeback' on arm and x86_64.
>       - Fixed all the miscellaneous comments.
>
> v2 - https://lists.gnu.org/archive/html/qemu-devel/2020-11/msg07031.html
> Changes from v2:
>       - Using the thread pool based approach as suggested
>       - Moved the async hcall handling code to spapr_nvdimm.c along
>         with some simplifications
>       - Added vmstate to preserve the hcall status during save-restore
>         along with pre_save handler code to complete all ongoning flushes.
>       - Added hw_compat magic for sync-dax 'on' on previous machines.
>       - Miscellanious minor fixes.
>
> v1 - https://lists.gnu.org/archive/html/qemu-devel/2020-11/msg06330.html
> Changes from v1
>       - Fixed a missed-out unlock
>       - using QLIST_FOREACH instead of QLIST_FOREACH_SAFE while generating token
>
> Shivaprasad G Bhat (3):
>       spapr: nvdimm: Forward declare and move the definitions
>       spapr: nvdimm: Implement H_SCM_FLUSH hcall
>       nvdimm: Enable sync-dax device property for nvdimm
>
>
>  hw/arm/virt.c                 |   28 ++++
>  hw/i386/pc.c                  |   28 ++++
>  hw/mem/nvdimm.c               |   52 +++++++
>  hw/ppc/spapr.c                |   16 ++
>  hw/ppc/spapr_nvdimm.c         |  285 +++++++++++++++++++++++++++++++++++++++++
>  include/hw/mem/nvdimm.h       |   11 ++
>  include/hw/ppc/spapr.h        |   11 +-
>  include/hw/ppc/spapr_nvdimm.h |   27 ++--
>  qapi/common.json              |   20 +++
>  9 files changed, 455 insertions(+), 23 deletions(-)
>
> --
> Signature
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
