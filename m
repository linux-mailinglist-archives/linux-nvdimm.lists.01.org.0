Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7481C056A
	for <lists+linux-nvdimm@lfdr.de>; Thu, 30 Apr 2020 20:58:34 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1D8AD10053E28;
	Thu, 30 Apr 2020 11:57:20 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::644; helo=mail-ej1-x644.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 55A4B10053E0F
	for <linux-nvdimm@lists.01.org>; Thu, 30 Apr 2020 11:57:18 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id rh22so5545953ejb.12
        for <linux-nvdimm@lists.01.org>; Thu, 30 Apr 2020 11:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VO82Y+ddPqwVbejb8yp1YADHo+TiaduERH1aUXgFNdU=;
        b=ftYR3vvy7y4XQUHnig2EWsnYgRjVl+CPW2em4ftSq034hx6ZoqSueCcso+RG9w8AGa
         w0/+YALKEw0FIaP05V+9C0XKOYuOmd59KAW1siA/r09GzwZUf48N8GmxNx1dxSbliixs
         CuBWjC2ORmo5GZgQNulH0b+ykeGy5IQzQog4ZcfdBGWxbr/kGwbKqiBi3jZCbBsGvnNW
         Q5W2E6yv533qZlcTHc6rxcPndCCEwjOVK0cZ2rz6LGVrs0kCEepYAF9z3xs1VIBjMZtf
         A5p7YNgqSxKHyCub+EuUXAZ2xuX50SSxRFhOGGuo9nNwQKHccsh0XWdv0oNDM0uH1ryy
         dbvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VO82Y+ddPqwVbejb8yp1YADHo+TiaduERH1aUXgFNdU=;
        b=OLgsqUvDYN+gA1XKVIMLrs9nwWAIjXLT7vZrpTed1+00Ufm5+uQ9faqXmcaw8ioYOP
         qPc+f8No4TMZJVK4pGktswatNAmcr2JvX/gfxRw/kGszMe916TGoB3OwGDyqbputtRW7
         c96JDsPXo/wyCGL95K+iU28ilZAdt2qMQsbSmvgVEvLltsbQT0o0sJjEdQVYnxRCsQqU
         /wN9VPe1IkFzafWzZ6sInp1cEmwrALUHjs0hX0LZcULUyLG0Hi6ouOCKK+MehxxbodbV
         SJiZngkkTfAAtJIFpPunsqpzYsMQzvin2uQMXOKCYoPNTTEC4ohTGjXXTulezFuwFZSu
         Q/1Q==
X-Gm-Message-State: AGi0PubRsp0sXAuem414IvEsBm+Xc03+VQ2YqOYIbPQbwTigSKNZUbhq
	5QpFqzy/uOv45db547eL+CCCGJfbS9XGOoPA7+iklg==
X-Google-Smtp-Source: APiQypLtO6lmgP+/t4n/a1LprqtsF2znfD77bnYaqHJRks9KFzncsFlKVdj99iACRR541U4ie6ERYFDj3Eno6uEUPdw=
X-Received: by 2002:a17:906:855a:: with SMTP id h26mr4305126ejy.56.1588273108788;
 Thu, 30 Apr 2020 11:58:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200430102908.10107-1-david@redhat.com> <20200430102908.10107-3-david@redhat.com>
 <87pnbp2dcz.fsf@x220.int.ebiederm.org> <1b49c3be-6e2f-57cb-96f7-f66a8f8a9380@redhat.com>
 <871ro52ary.fsf@x220.int.ebiederm.org> <373a6898-4020-4af1-5b3d-f827d705dd77@redhat.com>
 <875zdg26hp.fsf@x220.int.ebiederm.org> <b28c9e02-8cf2-33ae-646b-fe50a185738e@redhat.com>
In-Reply-To: <b28c9e02-8cf2-33ae-646b-fe50a185738e@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 30 Apr 2020 11:58:16 -0700
Message-ID: <CAPcyv4j33bwbrFMu2L0knRGRN1RDiC5kbknMNEwo-OFmPSw47w@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mm/memory_hotplug: Introduce MHP_NO_FIRMWARE_MEMMAP
To: David Hildenbrand <david@redhat.com>
Message-ID-Hash: KFE72MJNA3NFE7OEBHRX745KHMNITHZW
X-Message-ID-Hash: KFE72MJNA3NFE7OEBHRX745KHMNITHZW
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Linux ACPI <linux-acpi@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, linux-hyperv@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>, xen-devel <xen-devel@lists.xenproject.org>, Michal Hocko <mhocko@kernel.org>, "Michael S . Tsirkin" <mst@redhat.com>, Michal Hocko <mhocko@suse.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Wei Yang <richard.weiyang@gmail.com>, Baoquan He <bhe@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KFE72MJNA3NFE7OEBHRX745KHMNITHZW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Apr 30, 2020 at 11:44 AM David Hildenbrand <david@redhat.com> wrote:
>
>  >>> If the class of memory is different then please by all means let's mark
> >>> it differently in struct resource so everyone knows it is different.
> >>> But that difference needs to be more than hotplug.
> >>>
> >>> That difference needs to be the hypervisor loaned us memory and might
> >>> take it back at any time, or this memory is persistent and so it has
> >>> these different characteristics so don't use it as ordinary ram.
> >>
> >> Yes, and I think kmem took an excellent approach of explicitly putting
> >> that "System RAM" into a resource hierarchy. That "System RAM" won't
> >> show up as a root node under /proc/iomem (see patch #3), which already
> >> results in kexec-tools to treat it in a special way. I am thinking about
> >> doing the same for virtio-mem.
> >
> > Reading this and your patch cover letters again my concern is that
> > the justification seems to be letting the tail wag the dog.
> >
> > You want kexec-tools to behave in a certain way so you are changing the
> > kernel.
> >
> > Rather it should be change the kernel to clearly reflect reality and if
> > you can get away without a change to kexec-tools that is a bonus.
> >
>
> Right, because user space has to have a way to figure out what to do.
>
> But talking about the firmware memmap, indicating something via a "raw
> firmware-provided memory map", that is not actually in the "raw
> firmware-provided memory map" feels wrong to me. (below)
>
>
> >>> That information is also useful to other people looking at the system
> >>> and seeing what is going on.
> >>>
> >>> Just please don't muddle the concepts, or assume that whatever subset of
> >>> hotplug memory you are dealing with is the only subset.
> >>
> >> I can certainly rephrase the subject/description/comment, stating that
> >> this is not to be used for ordinary hotplugged DIMMs - only when the
> >> device driver is under control to decide what to do with that memory -
> >> especially when kexec'ing.
> >>
> >> (previously, I called this flag MHP_DRIVER_MANAGED, but I think
> >> MHP_NO_FIRMWARE_MEMMAP is clearer, we just need a better description)
> >>
> >> Would that make it clearer?
> >
> > I am not certain, but Andrew Morton deliberately added that
> > firmware_map_add_hotplug call.  Which means that there is a reason
> > for putting hotplugged memory in the firmware map.
> >
> > So the justification needs to take that reason into account.  The
> > justification can not be it is hotplugged therefore it should not belong
> > in the firmware memory map.  Unless you can show that
> > firmware_map_add_hotplug that was actually a bug and should be removed.
> > But as it has been that way since 2010 that seems like a long shot.
> >
> > So my question is what is right for the firmware map?
>
> We have documentation for that since 2008. Andrews patch is from 2010.
>
> Documentation/ABI/testing/sysfs-firmware-memmap
>
> It clearly talks about "raw firmware-provided memory map" and why the
> interface was introduced at all ("on most architectures that
> firmware-provided memory map is modified afterwards by the kernel itself").
>
> >
> > Why does the firmware map support hotplug entries?
>
> I assume:
>
> The firmware memmap was added primarily for x86-64 kexec (and still, is
> mostly used on x86-64 only IIRC). There, we had ACPI hotplug. When DIMMs
> get hotplugged on real HW, they get added to e820. Same applies to
> memory added via HyperV balloon (unless memory is unplugged via
> ballooning and you reboot ... the the e820 is changed as well). I assume
> we wanted to be able to reflect that, to make kexec look like a real reboot.

I can at least say that this breakdown makes sense to me. Traditional
memory hotplug results in permanent change to the raw firmware memory
map reported by the host at next reboot. These device-driver-owned
memory regions really want a hotplug policy per-kernel boot instance
and should fall back to the default reserved state at reboot (kexec or
otherwise). When I say hotplug-policy I mean whether the current
kernel wants to treat the device range as System RAM or leave it as
device-managed. The intent is that the follow-on kernel needs to
re-decide the device policy.

>
> This worked for a while. Then came dax/kmem. Now comes virtio-mem.
>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
