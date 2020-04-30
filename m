Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C701BF2E7
	for <lists+linux-nvdimm@lfdr.de>; Thu, 30 Apr 2020 10:34:18 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5E5E5111B218A;
	Thu, 30 Apr 2020 01:33:06 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::644; helo=mail-ej1-x644.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8FFE1111B2187
	for <linux-nvdimm@lists.01.org>; Thu, 30 Apr 2020 01:33:03 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id pg17so3982680ejb.9
        for <linux-nvdimm@lists.01.org>; Thu, 30 Apr 2020 01:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=87dIcS/jrU3IxflLIkdtnvU4qll0iHvEZNuLGZ4o7wI=;
        b=C7NzSwQeQ8r7hb6zu0mE43nN5BVsWOZy21t9s86oMspwPoqNG+2r9QwYXMI253bkO+
         f2NXbqJEZlVUDXw2jKOJXTdMksOMSeCU/1+d1/KW3kPK6bDnIkjaV85ydvslVx7+7VaK
         H/Wy8s3jtrbog9dFPbt+U8g4F9a/kPxAFzoHfDtTpSCDud/nTiDKxbIHNOx4gDT1cWli
         scShmtfTOkTf1D6LztaDjOZAMAIUOcl9E1Ehg4s+icpPrmffJn6TfhOtMJuuVZZemCWo
         u5q8IaOdIkls7C87+V/X7frCMtH72XB/et/faVXvhnFad5uP3/TQ8BbSLNTCllAusarT
         BwFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=87dIcS/jrU3IxflLIkdtnvU4qll0iHvEZNuLGZ4o7wI=;
        b=NXQhsbX1h+FjddziSFgDApAfE962gy7IIm+OL7Q95dshgqeFuAgNPNYPncc1dret2E
         4cxZi2uAFIYJdYxBBRyxdGAT6djae338ah8Mki8kyqfo153Fojk6rCv4W8ZlUpxwrEkl
         N1zQem1Khgbkc8ObEPDFfC2oTyaY/vJLNo8DCVfCecSK2YYnSmnmexWCnh6ENGMt+Blk
         N0LtFpqFk4mpg6mJk8T+v/IdahgXiRbxF86vRKhp9P8y9kj6LtwDKTNav8/W/eiGQMY6
         W6SHZt1VCim51UDOxwXbeeBko82SaNov4EzdYbRvvC84wsFl+Gs8kxGcvcLA0+EHMedC
         8qbQ==
X-Gm-Message-State: AGi0PuYVIdYj+DWjPNU+NhxJyT9JBNDEg35D7khOiAA38gKpHS9kYZnB
	3OreFmUeJCITTf3YhdmFaG1D9NUmOoczX0lsa+m5cw==
X-Google-Smtp-Source: APiQypLBVztlIIHfr3wCtEt+MVa/TaJHl/O1nuNqStB0TwAKkS6wTTbCgFJlPXMDG8iI601GTPaB481cRsH+FNdImHY=
X-Received: by 2002:a17:906:7750:: with SMTP id o16mr1715515ejn.12.1588235651152;
 Thu, 30 Apr 2020 01:34:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200429160803.109056-1-david@redhat.com> <20200429160803.109056-3-david@redhat.com>
 <a7305cd8-8b2f-1d8f-7654-ecf777c46df6@redhat.com> <CAPcyv4i04+QLxiOyz04_eef2DFetEFKBUmi2A4xxw9abQD8hNQ@mail.gmail.com>
 <e32522cd-31bb-e129-47a6-9ec13b570506@redhat.com>
In-Reply-To: <e32522cd-31bb-e129-47a6-9ec13b570506@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 30 Apr 2020 01:34:00 -0700
Message-ID: <CAPcyv4gjRE23BHsBAnaVWAPUHWdenxYMUwDBnDF7UmoejmmbNQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] mm/memory_hotplug: Introduce MHP_DRIVER_MANAGED
To: David Hildenbrand <david@redhat.com>
Message-ID-Hash: 34EI3RMXK6AZJI7MN4QXW5DQAVMVAR2A
X-Message-ID-Hash: 34EI3RMXK6AZJI7MN4QXW5DQAVMVAR2A
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Linux ACPI <linux-acpi@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, linux-hyperv@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>, xen-devel <xen-devel@lists.xenproject.org>, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, Michal Hocko <mhocko@suse.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Wei Yang <richard.weiyang@gmail.com>, Baoquan He <bhe@redhat.com>, Eric Biederman <ebiederm@xmission.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Dave Hansen <dave.hansen@linux.intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/34EI3RMXK6AZJI7MN4QXW5DQAVMVAR2A/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Apr 30, 2020 at 1:21 AM David Hildenbrand <david@redhat.com> wrote:
> >> Just because we decided to use some DAX memory in the current kernel as
> >> system ram, doesn't mean we should make that decision for the kexec
> >> kernel (e.g., using it as initial memory, placing kexec binaries onto
> >> it, etc.). This is also not what we would observe during a real reboot.
> >
> > Agree.
> >
> >> I can see that the "System RAM" resource will show up as child resource
> >> under the device e.g., in /proc/iomem.
> >>
> >> However, entries in /sys/firmware/memmap/ are created as "System RAM".
> >
> > True. Do you think this rename should just be limited to what type
> > /sys/firmware/memmap/ emits? I have the concern, but no proof
>
> We could split this patch into
>
> MHP_NO_FIRMWARE_MEMMAP (create firmware memmap entries)
>
> and
>
> MHP_DRIVER_MANAGED (name of the resource)
>
> See below, the latter might not be needed.
>
> > currently, that there are /proc/iomem walkers that explicitly look for
> > "System RAM", but might be thrown off by "System RAM (driver
> > managed)". I was not aware of /sys/firmware/memmap until about 5
> > minutes ago.
>
> The only two users of /proc/iomem I am aware of are kexec-tools and some
> s390x tools.
>
> kexec-tools on x86-64 uses /sys/firmware/memmap to craft the initial
> memmap, but uses /proc/iomem to
> a) Find places for kexec images
> b) Detect memory regions to dump via kdump
>
> I am not yet sure if we really need the "System RAM (driver managed)"
> part. If we can teach kexec-tools to
> a) Don't place kexec images on "System RAM" that has a parent resource
> (most likely requires kexec-tools changes)
> b) Consider for kdump "System RAM" that has a parent resource
> we might be able to avoid renaming that. (I assume that's already done)
>
> E.g., regarding virtio-mem (patch #3) I am currently also looking into
> creating a parent resource instead, like dax/kmem to avoid the rename:
>
> :/# cat /proc/iomem
> 00000000-00000fff : Reserved
> [...]
> 100000000-13fffffff : System RAM
> 140000000-33fffffff : virtio0
>   140000000-147ffffff : System RAM
>   148000000-14fffffff : System RAM
>   150000000-157ffffff : System RAM
> 340000000-303fffffff : virtio1
>   340000000-347ffffff : System RAM
> 3280000000-32ffffffff : PCI Bus 0000:00

Looks good to me if it flies with kexec-tools.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
