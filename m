Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A93515E5F1
	for <lists+linux-nvdimm@lfdr.de>; Fri, 14 Feb 2020 17:44:54 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D327D10FC319D;
	Fri, 14 Feb 2020 08:48:09 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.120; helo=us-smtp-1.mimecast.com; envelope-from=jmoyer@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [205.139.110.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 90D171003EC45
	for <linux-nvdimm@lists.01.org>; Fri, 14 Feb 2020 08:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1581698690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o1A1SrX1zBsASGrayq0vRC5S/HwSS0PwydKpbfc/Bgo=;
	b=dB1jl89xsCgHVvyr40cZp0W340VDbPnbXtZjG8pVuxVwDDg92PB5oLyUTGFKrXHiAnFycw
	R7gE6R4LLBkBavr+R/ntzJuc4JvBDbEXx0RyGE6qYu7+afJO3+9vXzI77wJZOzuC0tGSya
	tcc7bnROx1X2W/cWxFjhZiryw9fRNK0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-pBJfwSSoOaanm1qLVXdpgA-1; Fri, 14 Feb 2020 11:44:41 -0500
X-MC-Unique: pBJfwSSoOaanm1qLVXdpgA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4BEA4DB62;
	Fri, 14 Feb 2020 16:44:40 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 67C5B19C4F;
	Fri, 14 Feb 2020 16:44:39 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 2/4] libnvdimm/namespace: Enforce memremap_compat_align()
References: <158155489850.3343782.2687127373754434980.stgit@dwillia2-desk3.amr.corp.intel.com>
	<158155490897.3343782.14216276134794923581.stgit@dwillia2-desk3.amr.corp.intel.com>
	<x49k14q5ezs.fsf@segfault.boston.devel.redhat.com>
	<CAPcyv4hQouRNBcJ4uZ2mysr_aKstLhvUf66gRQ_3QoQNyOy72g@mail.gmail.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Fri, 14 Feb 2020 11:44:38 -0500
In-Reply-To: <CAPcyv4hQouRNBcJ4uZ2mysr_aKstLhvUf66gRQ_3QoQNyOy72g@mail.gmail.com>
	(Dan Williams's message of "Thu, 13 Feb 2020 14:43:28 -0800")
Message-ID: <x49h7ztdsp5.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Message-ID-Hash: 4CBALAJN3TQQVPOPSU7YBYCHXG5NZHXM
X-Message-ID-Hash: 4CBALAJN3TQQVPOPSU7YBYCHXG5NZHXM
X-MailFrom: jmoyer@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4CBALAJN3TQQVPOPSU7YBYCHXG5NZHXM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dan Williams <dan.j.williams@intel.com> writes:

> On Thu, Feb 13, 2020 at 1:55 PM Jeff Moyer <jmoyer@redhat.com> wrote:
>>
>> Dan Williams <dan.j.williams@intel.com> writes:
>>
>> > The pmem driver on PowerPC crashes with the following signature when
>> > instantiating misaligned namespaces that map their capacity via
>> > memremap_pages().
>> >
>> >     BUG: Unable to handle kernel data access at 0xc001000406000000
>> >     Faulting instruction address: 0xc000000000090790
>> >     NIP [c000000000090790] arch_add_memory+0xc0/0x130
>> >     LR [c000000000090744] arch_add_memory+0x74/0x130
>> >     Call Trace:
>> >      arch_add_memory+0x74/0x130 (unreliable)
>> >      memremap_pages+0x74c/0xa30
>> >      devm_memremap_pages+0x3c/0xa0
>> >      pmem_attach_disk+0x188/0x770
>> >      nvdimm_bus_probe+0xd8/0x470
>> >
>> > With the assumption that only memremap_pages() has alignment
>> > constraints, enforce memremap_compat_align() for
>> > pmem_should_map_pages(), nd_pfn, or nd_dax cases.
>> >
>> > Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> > Cc: Jeff Moyer <jmoyer@redhat.com>
>> > Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> > Link: https://lore.kernel.org/r/158041477336.3889308.4581652885008605170.stgit@dwillia2-desk3.amr.corp.intel.com
>> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>> > ---
>> >  drivers/nvdimm/namespace_devs.c |   10 ++++++++++
>> >  1 file changed, 10 insertions(+)
>> >
>> > diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
>> > index 032dc61725ff..aff1f32fdb4f 100644
>> > --- a/drivers/nvdimm/namespace_devs.c
>> > +++ b/drivers/nvdimm/namespace_devs.c
>> > @@ -1739,6 +1739,16 @@ struct nd_namespace_common *nvdimm_namespace_common_probe(struct device *dev)
>> >               return ERR_PTR(-ENODEV);
>> >       }
>> >
>> > +     if (pmem_should_map_pages(dev) || nd_pfn || nd_dax) {
>> > +             struct nd_namespace_io *nsio = to_nd_namespace_io(&ndns->dev);
>> > +             resource_size_t start = nsio->res.start;
>> > +
>> > +             if (!IS_ALIGNED(start | size, memremap_compat_align())) {
>> > +                     dev_dbg(&ndns->dev, "misaligned, unable to map\n");
>> > +                     return ERR_PTR(-EOPNOTSUPP);
>> > +             }
>> > +     }
>> > +
>> >       if (is_namespace_pmem(&ndns->dev)) {
>> >               struct nd_namespace_pmem *nspm;
>> >
>>
>> Actually, I take back my ack.  :) This prevents a previously working
>> namespace from being successfully probed/setup.
>
> Do you have a test case handy? I can see a potential gap with a
> namespace that used internal padding to fix up the alignment.

# ndctl list -v -n namespace0.0
[
  {
    "dev":"namespace0.0",
    "mode":"fsdax",
    "map":"dev",
    "size":52846133248,
    "uuid":"b99f6f6a-2909-4189-9bfa-6eeebd95d40e",
    "raw_uuid":"aff43777-015b-493f-bbf9-7c7b0fe33519",
    "sector_size":512,
    "align":4096,
    "blockdev":"pmem0",
    "numa_node":0
  }
]

# cat /sys/bus/nd/devices/region0/mappings
6

# grep namespace0.0 /proc/iomem
  1860000000-24e0003fff : namespace0.0

> The goal of this check is to catch cases that are just going to fail
> devm_memremap_pages(), and the expectation is that it could not have
> worked before unless it was ported from another platform, or someone
> flipped the page-size switch on PowerPC.

On x86, creation and probing of the namespace worked fine before this
patch.  What *doesn't* work is creating another fsdax namespace after
this one.  sector mode namespaces can still be created, though:

[
  {
    "dev":"namespace0.1",
    "mode":"sector",
    "size":53270768640,
    "uuid":"67ea2c74-d4b1-4fc9-9c1a-a7d2a6c2a4a7",
    "sector_size":512,
    "blockdev":"pmem0.1s"
  },

# grep namespace0.1 /proc/iomem
  24e0004000-3160007fff : namespace0.1

>> I thought we were only going to enforce the alignment for a newly
>> created namespace?  This should only check whether the alignment
>> works for the current platform.
>
> The model is a new default 16MB alignment is enforced at creation
> time, but if you need to support previously created namespaces then
> you can manually trim that alignment requirement to no less than
> memremap_compat_align() because that's the point at which
> devm_memremap_pages() will start failing or crashing.

The problem is that older kernels did not enforce alignment to
SUBSECTION_SIZE.  We shouldn't prevent those namespaces from being
accessed.  The probe itself will not cause the WARN_ON to trigger.
Creating new namespaces at misaligned addresses could, but you've
altered the free space allocation such that we won't hit that anymore.

If I drop this patch, the probe will still work, and allocating new
namespaces will also work:

# ndctl list
[
  {
    "dev":"namespace0.1",
    "mode":"sector",
    "size":53270768640,
    "uuid":"67ea2c74-d4b1-4fc9-9c1a-a7d2a6c2a4a7",
    "sector_size":512,
    "blockdev":"pmem0.1s"
  },
  {
    "dev":"namespace0.0",
    "mode":"fsdax",
    "map":"dev",
    "size":52846133248,
    "uuid":"b99f6f6a-2909-4189-9bfa-6eeebd95d40e",
    "sector_size":512,
    "align":4096,
    "blockdev":"pmem0"
  }
]
 ndctl create-namespace -m fsdax -s 36g -r 0
{
  "dev":"namespace0.2",
  "mode":"fsdax",
  "map":"dev",
  "size":"35.44 GiB (38.05 GB)",
  "uuid":"7893264c-c7ef-4cbe-95e1-ccf2aff041fb",
  "sector_size":512,
  "align":2097152,
  "blockdev":"pmem0.2"
}

proc/iomem:

1860000000-d55fffffff : Persistent Memory
  1860000000-24e0003fff : namespace0.0
  24e0004000-3160007fff : namespace0.1
  3162000000-3a61ffffff : namespace0.2

So, maybe the right thing is to make memremap_compat_align return
PAGE_SIZE for x86 instead of SUBSECTION_SIZE?

-Jeff
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
