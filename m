Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBE633DC6
	for <lists+linux-nvdimm@lfdr.de>; Tue,  4 Jun 2019 06:18:00 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C77A621A070B8;
	Mon,  3 Jun 2019 21:17:58 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::344; helo=mail-ot1-x344.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 7CF0921283A5A
 for <linux-nvdimm@lists.01.org>; Mon,  3 Jun 2019 21:17:56 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id c3so18281890otr.3
 for <linux-nvdimm@lists.01.org>; Mon, 03 Jun 2019 21:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hltidb8QtHOPGObUrHtf/4ZtTKSopSnDSqcRsOo2rxw=;
 b=Ylkho9VZmxrfNPZuXnkJqmPSoMFRbrUkdrtYfi9TjOfn5rg1xJOod4IoGWz/MBoi1z
 SKaIfklCToaQ05NrOxSCmDKfVaQoJciFCLThIiUTVOm8h1cZYWNBEvS31DqUaCzTt7lj
 D85LvLurfQi+AwomNGxJ4J+bTDtmYwVSStL+Z0WY44DZdbovZH7MZN8azhTPVgTtpj8l
 aGi+QoS4/idCbF/AJjecqoBpmBYZDsC82qz3wGtO4cB+aYfi2CQK94fw5Z47Mfhfru48
 1J8TMQPUj+L4my+E+d5z6GzzvleTKb8BJSaUOx3aFfZQhvuVA7Weh4QDbpGZDAsPTth0
 6YUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hltidb8QtHOPGObUrHtf/4ZtTKSopSnDSqcRsOo2rxw=;
 b=mCeQ12QYEM8VKONAv38lb/njjIfsVoQHUT3Ui6sKeCjv15xqEr9RAmCQPFIE3KQVYZ
 Jw22tIlX9daZ8pyV7L5J3XxPR1w/uYIy0FmBl1ozxOsHxdSZ8lAuFYZ253wp/UgzUDFF
 agkPNXk/FrZD1ZQDHNwVJcWvOfHKUfGOjRZMUPHPRWRp6oq/eKbtkrNQGOlhhHFpxWwo
 5Tn/pMdCv5Pytspe57LUUY6o/xJiTUOuPksKV2iNwXLoypOMpGBwI7HaEGu+iYYtV0c/
 rRqUw7ph5nNdkEFkS0pXKOshAmh5f7fE0qvJfpX8wL6kMv10J0FKljLDNt/cB3OnLhzk
 7IAg==
X-Gm-Message-State: APjAAAX25TWvm8DL98JiDhnrX5w/XnoLqAjO+cdnM85Gp+AOewwhmrfL
 Z3E1CJETmv3CwpMxYowwom/LovoAuSuOrAuXw5vW0w==
X-Google-Smtp-Source: APXvYqwo/LUbj2pYOXZO3ffCZPIeLTijVrKjdQTitvOc7MYQLuagna3P5yWym8s7Wsy/jQis1++NrNsm5wG+0k9zBSo=
X-Received: by 2002:a9d:6e96:: with SMTP id a22mr3655013otr.207.1559621875900; 
 Mon, 03 Jun 2019 21:17:55 -0700 (PDT)
MIME-Version: 1.0
References: <155677652226.2336373.8700273400832001094.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155677657023.2336373.4452495266651002382.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190503125634.GH15740@linux>
In-Reply-To: <20190503125634.GH15740@linux>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 3 Jun 2019 21:17:44 -0700
Message-ID: <CAPcyv4jx-+QJC3Aw-wY9PWshCWpu2VZKZz=PjTO7jN5Ojxz+pg@mail.gmail.com>
Subject: Re: [PATCH v7 09/12] mm/sparsemem: Support sub-section hotplug
To: Oscar Salvador <osalvador@suse.de>
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
Cc: Michal Hocko <mhocko@suse.com>, linux-nvdimm <linux-nvdimm@lists.01.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux MM <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, May 3, 2019 at 5:56 AM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Wed, May 01, 2019 at 10:56:10PM -0700, Dan Williams wrote:
> > The libnvdimm sub-system has suffered a series of hacks and broken
> > workarounds for the memory-hotplug implementation's awkward
> > section-aligned (128MB) granularity. For example the following backtrace
> > is emitted when attempting arch_add_memory() with physical address
> > ranges that intersect 'System RAM' (RAM) with 'Persistent Memory' (PMEM)
> > within a given section:
> >
> >  WARNING: CPU: 0 PID: 558 at kernel/memremap.c:300 devm_memremap_pages+0x3b5/0x4c0
> >  devm_memremap_pages attempted on mixed region [mem 0x200000000-0x2fbffffff flags 0x200]
> >  [..]
> >  Call Trace:
> >    dump_stack+0x86/0xc3
> >    __warn+0xcb/0xf0
> >    warn_slowpath_fmt+0x5f/0x80
> >    devm_memremap_pages+0x3b5/0x4c0
> >    __wrap_devm_memremap_pages+0x58/0x70 [nfit_test_iomap]
> >    pmem_attach_disk+0x19a/0x440 [nd_pmem]
> >
> > Recently it was discovered that the problem goes beyond RAM vs PMEM
> > collisions as some platform produce PMEM vs PMEM collisions within a
> > given section. The libnvdimm workaround for that case revealed that the
> > libnvdimm section-alignment-padding implementation has been broken for a
> > long while. A fix for that long-standing breakage introduces as many
> > problems as it solves as it would require a backward-incompatible change
> > to the namespace metadata interpretation. Instead of that dubious route
> > [1], address the root problem in the memory-hotplug implementation.
> >
> > [1]: https://lore.kernel.org/r/155000671719.348031.2347363160141119237.stgit@dwillia2-desk3.amr.corp.intel.com
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Cc: Logan Gunthorpe <logang@deltatee.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  mm/sparse.c |  223 ++++++++++++++++++++++++++++++++++++++++-------------------
> >  1 file changed, 150 insertions(+), 73 deletions(-)
> >
> > diff --git a/mm/sparse.c b/mm/sparse.c
> > index 198371e5fc87..419a3620af6e 100644
> > --- a/mm/sparse.c
> > +++ b/mm/sparse.c
> > @@ -83,8 +83,15 @@ static int __meminit sparse_index_init(unsigned long section_nr, int nid)
> >       unsigned long root = SECTION_NR_TO_ROOT(section_nr);
> >       struct mem_section *section;
> >
> > +     /*
> > +      * An existing section is possible in the sub-section hotplug
> > +      * case. First hot-add instantiates, follow-on hot-add reuses
> > +      * the existing section.
> > +      *
> > +      * The mem_hotplug_lock resolves the apparent race below.
> > +      */
> >       if (mem_section[root])
> > -             return -EEXIST;
> > +             return 0;
>
> Just a sidenote: we do not bail out on -EEXIST, so it should be fine if we
> stick with it.
> But if not, I would then clean up sparse_add_section:
>
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -901,13 +901,12 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
>         int ret;
>
>         ret = sparse_index_init(section_nr, nid);
> -       if (ret < 0 && ret != -EEXIST)
> +       if (ret < 0)
>                 return ret;
>
>         memmap = section_activate(nid, start_pfn, nr_pages, altmap);
>         if (IS_ERR(memmap))
>                 return PTR_ERR(memmap);
> -       ret = 0;

Good catch, folded the cleanup.

>
>
> > +
> > +     if (!mask)
> > +             rc = -EINVAL;
> > +     else if (mask & ms->usage->map_active)
>
>         else if (ms->usage->map_active) should be enough?
>
> > +             rc = -EEXIST;
> > +     else
> > +             ms->usage->map_active |= mask;
> > +
> > +     if (rc) {
> > +             if (usage)
> > +                     ms->usage = NULL;
> > +             kfree(usage);
> > +             return ERR_PTR(rc);
> > +     }
> > +
> > +     /*
> > +      * The early init code does not consider partially populated
> > +      * initial sections, it simply assumes that memory will never be
> > +      * referenced.  If we hot-add memory into such a section then we
> > +      * do not need to populate the memmap and can simply reuse what
> > +      * is already there.
> > +      */
>
> This puzzles me a bit.
> I think we cannot have partially populated early sections, can we?

Yes, at boot memory need not be section aligned it has historically
been handled as a un-removable section of memory with holes.

> And how we even come to hot-add memory into those?
>
> Could you please elaborate a bit here?

Those sections are excluded from add_memory_resource() adding more
memory, but arch_add_memory() with sub-section support can fill in the
subsection holes in mem_map.

>
> > +     ms = __pfn_to_section(start_pfn);
> >       section_mark_present(ms);
> > -     sparse_init_one_section(ms, section_nr, memmap, usage);
> > +     sparse_init_one_section(ms, section_nr, memmap, ms->usage);
> >
> > -out:
> > -     if (ret < 0) {
> > -             kfree(usage);
> > -             depopulate_section_memmap(start_pfn, PAGES_PER_SECTION, altmap);
> > -     }
> > +     if (ret < 0)
> > +             section_deactivate(start_pfn, nr_pages, nid, altmap);
>
> Uhm, if my eyes do not trick me, ret is only used for the return value from
> sparse_index_init(), so this is not needed. Can we get rid of it?

Yes, these can go.

Apologies for the delay and missing these comments in the v8 posting.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
