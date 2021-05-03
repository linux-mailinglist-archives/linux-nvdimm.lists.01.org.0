Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E93F83720A4
	for <lists+linux-nvdimm@lfdr.de>; Mon,  3 May 2021 21:41:14 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3FF11100EB838;
	Mon,  3 May 2021 12:41:13 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::633; helo=mail-ej1-x633.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0AB68100EB826
	for <linux-nvdimm@lists.01.org>; Mon,  3 May 2021 12:41:10 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id n2so9627379ejy.7
        for <linux-nvdimm@lists.01.org>; Mon, 03 May 2021 12:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=49uMkI2LDJUBbo1RdUn6p3ogziBXNQ+k2mStqHbBt6c=;
        b=Xdo9o1iNXHMcXoN0NEfgUJc2TJ63sNUEPD69vu78K8ePizsDNpXPDhc982m1EM/7rw
         VVW7AeI+SANwHAGZA7LhdV7HmDawhlE4kL0jDTIJQSn6gEQQrHHtf6FQgOaBM5qkXVrT
         yQq0VNtX6b8/syduyyLabAKypJu0VKU+yESPO0hfgRkVw/Weddxa/L5eHKOQdU2aj3VZ
         BNtNV7rt0LQZxw/GqrUiwvYuhP70ijFXkLiVNoPZ1HU0cI1ehmSvhBNn/ZjxiHP+AirF
         gLAs81224BQKYH0PyPjVB7MIjBqIAenvdmOBmXIEnUqx8ARYXVDMt4zfpC1qIw1M0f4h
         4yMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=49uMkI2LDJUBbo1RdUn6p3ogziBXNQ+k2mStqHbBt6c=;
        b=gQdUI1FAYHq0mzT8hADnTi0ZI0VjsskKDKh6LJNT7bAMrGGIjJfl51r9GqHO3d9g1i
         Oh40d16nltmJqVPfNB215pn3M3VIJkbvUFJPEM+jUpsCnTGN8VopE1ziFL8HfWWcdoRh
         1h0ycEd2bWfeR6Rx6drIVC8vblleWnmYXLGmjvmvSjIE1koDmxb8qdtWbqzsL/5p5XNx
         p5R5NVwNiePUxlypmilkwREu4gMZiJ70RD4Gtn9sUgaqnvJTq3QFEBikbPa6DjhRkS40
         3QCi0Z63k+VbrNWmD0j3aWfDzLiZpfKhhyVnB2y+tgsdr5S36zWFhxzyqRWFuh4GSHy1
         PeiA==
X-Gm-Message-State: AOAM530j58HRLO39LYBR9DnwwWab9nbNQuP7CtwrjFq8CBjT+JmzD5ah
	4h6okYO+PInXWEz3OprGGRBkSiBDOLMzTHIvC6oxuw==
X-Google-Smtp-Source: ABdhPJywAb/ut4elT67n769KUoWxWbvJW9JqLHYAMYAkMs55UKOh/83smxXhMif1qIwE3136tou0C0oaWj+RDEtUXOs=
X-Received: by 2002:a17:907:1183:: with SMTP id uz3mr18129036ejb.264.1620070865840;
 Mon, 03 May 2021 12:41:05 -0700 (PDT)
MIME-Version: 1.0
References: <161966810162.652.13723419108625443430.stgit@17be908f7c1c>
 <CAPcyv4gwkyDBG7EZOth-kcZR8Fb+RgGXY=Y9vbuHXAz3PAnLVw@mail.gmail.com> <bca3512d-5437-e8e6-68ae-0c9b887115f9@linux.ibm.com>
In-Reply-To: <bca3512d-5437-e8e6-68ae-0c9b887115f9@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 3 May 2021 12:41:08 -0700
Message-ID: <CAPcyv4hAOC89JOXr-ZCps=n8gEKD5W0jmGU1Enfo8ECVMf3veQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] nvdimm: Enable sync-dax property for nvdimm
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Message-ID-Hash: NVAXLIROPGDGVP6OOMQBF2W4R66I4WMY
X-Message-ID-Hash: NVAXLIROPGDGVP6OOMQBF2W4R66I4WMY
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, marcel.apfelbaum@gmail.com, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, qemu-arm@nongnu.org, richard.henderson@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Haozhong Zhang <haozhong.zhang@intel.com>, shameerali.kolothum.thodi@huawei.com, kwangwoo.lee@sk.com, Markus Armbruster <armbru@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, kvm-ppc@vger.kernel.org, shivaprasadbhat@gmail.com, bharata@linux.vnet.ibm.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NVAXLIROPGDGVP6OOMQBF2W4R66I4WMY/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, May 3, 2021 at 7:06 AM Shivaprasad G Bhat <sbhat@linux.ibm.com> wrote:
>
>
> On 5/1/21 12:44 AM, Dan Williams wrote:
> > Some corrections to terminology confusion below...
> >
> >
> > On Wed, Apr 28, 2021 at 8:49 PM Shivaprasad G Bhat <sbhat@linux.ibm.com> wrote:
> >> The nvdimm devices are expected to ensure write persistence during power
> >> failure kind of scenarios.
> > No, QEMU is not expected to make that guarantee. QEMU is free to lie
> > to the guest about the persistence guarantees of the guest PMEM
> > ranges. It's more accurate to say that QEMU nvdimm devices can emulate
> > persistent memory and optionally pass through host power-fail
> > persistence guarantees to the guest. The power-fail persistence domain
> > can be one of "cpu_cache", or "memory_controller" if the persistent
> > memory region is "synchronous". If the persistent range is not
> > synchronous, it really isn't "persistent memory"; it's memory mapped
> > storage that needs I/O commands to flush.
>
> Since this is virtual nvdimm(v-nvdimm) backed by a file, and the data is
> completely
>
> in the host pagecache, and we need a way to ensure that host pagecaches
>
> are flushed to the backend. This analogous to the WPQ flush being offloaded
>
> to the hypervisor.

No, it isn't analogous. WPQ flush is an optional mechanism to force
data to a higher durability domain. The flush in this interface is
mandatory. It's a different class of device.

The proposal that "sync-dax=unsafe" for non-PPC architectures, is a
fundamental misrepresentation of how this is supposed to work. Rather
than make "sync-dax" a first class citizen of the device-description
interface I'm proposing that you make this a separate device-type.
This also solves the problem that "sync-dax" with an implicit
architecture backend assumption is not precise, but a new "non-nvdimm"
device type would make it explicit what the host is advertising to the
guest.

>
>
> Ref: https://github.com/dgibson/qemu/blob/main/docs/nvdimm.txt
>
>
>
> >
> >> The libpmem has architecture specific instructions like dcbf on POWER
> > Which "libpmem" is this? PMDK is a reference library not a PMEM
> > interface... maybe I'm missing what libpmem has to do with QEMU?
>
>
> I was referrering to semantics of flushing pmem cache lines as in
>
> PMDK/libpmem.
>
>
> >
> >> to flush the cache data to backend nvdimm device during normal writes
> >> followed by explicit flushes if the backend devices are not synchronous
> >> DAX capable.
> >>
> >> Qemu - virtual nvdimm devices are memory mapped. The dcbf in the guest
> >> and the subsequent flush doesn't traslate to actual flush to the backend
> > s/traslate/translate/
> >
> >> file on the host in case of file backed v-nvdimms. This is addressed by
> >> virtio-pmem in case of x86_64 by making explicit flushes translating to
> >> fsync at qemu.
> > Note that virtio-pmem was a proposal for a specific optimization of
> > allowing guests to share page cache. The virtio-pmem approach is not
> > to be confused with actual persistent memory.
> >
> >> On SPAPR, the issue is addressed by adding a new hcall to
> >> request for an explicit flush from the guest ndctl driver when the backend
> > What is an "ndctl" driver? ndctl is userspace tooling, do you mean the
> > guest pmem driver?
>
>
> oops, wrong terminologies. I was referring to guest libnvdimm and
>
> papr_scm kernel modules.
>
>
> >
> >> nvdimm cannot ensure write persistence with dcbf alone. So, the approach
> >> here is to convey when the hcall flush is required in a device tree
> >> property. The guest makes the hcall when the property is found, instead
> >> of relying on dcbf.
> >>
> >> A new device property sync-dax is added to the nvdimm device. When the
> >> sync-dax is 'writeback'(default for PPC), device property
> >> "hcall-flush-required" is set, and the guest makes hcall H_SCM_FLUSH
> >> requesting for an explicit flush.
> > I'm not sure "sync-dax" is a suitable name for the property of the
> > guest persistent memory.
>
>
> sync-dax property translates ND_REGION_ASYNC flag being set/unset

Yes, I am aware, but that property alone is not sufficient to identify
the flush mechanism.

>
> for the pmem region also if the nvdimm_flush callback is provided in the
>
> papr_scm or not. As everything boils down to synchronous nature
>
> of the device, I chose sync-dax for the name.
>
>
> >   There is no requirement that the
> > memory-backend file for a guest be a dax-capable file. It's also
> > implementation specific what hypercall needs to be invoked for a given
> > occurrence of "sync-dax". What does that map to on non-PPC platforms
> > for example?
>
>
> The backend file can be dax-capable, to be hinted using "sync-dax=direct".

All memory-mapped files are "dax-capable". "DAX" is an access
mechanism, not a data-integrity contract.

> When the backend is not dax-capable, the "sync-dax=writeback" to used,

No, the qemu property for this shuold be a separate device-type.

> so that the guest makes the hcall. On all non-PPC archs, with the
>
> "sync-dax=writeback" qemu errors out stating the lack of support.

There is no "lack of support" to be worried about on other archs if
the interface is explicit about the atypical flush arrangement.

>
>
> >   It seems to me that an "nvdimm" device presents the
> > synchronous usage model and a whole other device type implements an
> > async-hypercall setup that the guest happens to service with its
> > nvdimm stack, but it's not an "nvdimm" anymore at that point.
>
>
> In case the file backing the v-nvdimm is not dax-capable, we need flush
>
> semantics on the guest to be mapped to pagecache flush on the host side.
>
>
> >
> >> sync-dax is "unsafe" on all other platforms(x86, ARM) and old pseries machines
> >> prior to 5.2 on PPC. sync-dax="writeback" on ARM and x86_64 is prevented
> >> now as the flush semantics are unimplemented.
> > "sync-dax" has no meaning on its own, I think this needs an explicit
> > mechanism to convey both the "not-sync" property *and* the callback
> > method, it shouldn't be inferred by arch type.
>
>
> Yes. On all platforms the "sync-dax=unsafe" meaning - with host power
>
> failure the host pagecache is lost and subsequently data written by the
>
> guest will also be gone. This is the default for non-PPC.

The default to date has been for the guest to trust that an nvdimm is
an nvdimm with no explicit flushing required. It's too late now to
introduce an "unsafe" default.

>
>
> On PPC, the default is "sync-dax=writeback" - so the ND_REGION_ASYNC
>
> is set for the region and the guest makes hcalls to issue fsync on the host.
>
>
> Are you suggesting me to keep it "unsafe" as default for all architectures
>
> including PPC and a user can set it to "writeback" if desired.

No, I am suggesting that "sync-dax" is insufficient to convey this
property. This behavior warrants its own device type, not an ambiguous
property of the memory-backend-file with implicit architecture
assumptions attached.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
