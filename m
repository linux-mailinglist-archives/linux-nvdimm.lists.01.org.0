Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2531368A
	for <lists+linux-nvdimm@lfdr.de>; Sat,  4 May 2019 02:22:38 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BF9122125044D;
	Fri,  3 May 2019 17:22:36 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::344; helo=mail-ot1-x344.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 3193821250446
 for <linux-nvdimm@lists.01.org>; Fri,  3 May 2019 17:22:34 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id d10so1745581otp.11
 for <linux-nvdimm@lists.01.org>; Fri, 03 May 2019 17:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=P2GLzP+mIPWDKsZ2J8CpfXaoOt0+K7Q0KkqhqHG4CQc=;
 b=vCaTJVpfuYZulF2lvGYTlcwKbV4bHIuldvUdxOqs+uH+ZWUG8MHCqU5LYRU4Ii5WsS
 PDEi1Bnr5u7uVLSxwEHBcH9FcPgYoz9Zrqra3zoo3B3CV5rf1+xPBXBNtymFu8jTtI2b
 4t2wu2eKaV7ho3Zf63LxX2I8ETXX16rERV2zGWVqTQO/gyE/IpH1gehvfpn1PuaZ9XQ2
 nmeLDeeeVTfbVR8/sYJ645rjgSmbfdxHU+oB6gDOf5ZuLEJW+SGhXPmQQNsK5GI6X0Ln
 ByAdVXtAjKqekszhk+thuc6BqPOtKacnBhw35lG5RNxfap33IOANS8l1kbF1doUDWmMd
 3bmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=P2GLzP+mIPWDKsZ2J8CpfXaoOt0+K7Q0KkqhqHG4CQc=;
 b=IjbI5X3xC3n/zusLfvCuaHmQulZG8hKLYi7kqLx0BnY0SvANJo/AUAP4pBhByUs3ix
 mjVBs0S+9vVk9zfLmVQJHvQiUv8cLCBkh4OUZOlKvGQDmVt2FLnXVWRC/90qHEC8GLWd
 K2pKcP5QAUuAR8Yd7euSyY9x9khKFG7LwCzMLXrYB/E2ZxmgtWpyrndlyGBD5rY+GQR4
 NBWe6Q2Zmwkfktj+2wbyoAB58LobwHOHLr37ryWlY+7MfCJ3o1VWz19P7xhX9oimVTbv
 DmT4t5tllvJKO7dG0yYX+s4eb8lpl76wQ7IS5tzHOHxEOWxkK3CqMHfRMlJO7gHj7bfh
 KnUw==
X-Gm-Message-State: APjAAAWmvZagbCDsscBwSpUmhUMfdvjWz0bsMOWGrsTsv8hTTwNkbFj7
 WSClIMXsLcaeNh5/aRW19Tv4jG3mFOutXkNkMr9yiw==
X-Google-Smtp-Source: APXvYqxdVipoa5z31EifFG5ifrC68H+QnObLfr0ceemkguKFFrj+suFsJQfhR6Tx4LZgszvoXiMNhHCc5XuKsKhoJxk=
X-Received: by 2002:a9d:5cc1:: with SMTP id r1mr6880612oti.229.1556929354326; 
 Fri, 03 May 2019 17:22:34 -0700 (PDT)
MIME-Version: 1.0
References: <155552633539.2015392.2477781120122237934.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155552634075.2015392.3371070426600230054.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190501232517.crbmgcuk7u4gvujr@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
 <CAPcyv4hxy86gWN3ncTQmHi8DT31k8YzsweMfGHgCh=sORMQQcg@mail.gmail.com>
In-Reply-To: <CAPcyv4hxy86gWN3ncTQmHi8DT31k8YzsweMfGHgCh=sORMQQcg@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 3 May 2019 17:22:23 -0700
Message-ID: <CAPcyv4hAh-Joe3Pt0r5CPSaWpZ4YoNF2jNDcvbMF2fsQm7Hetg@mail.gmail.com>
Subject: Re: [PATCH v6 01/12] mm/sparsemem: Introduce struct mem_section_usage
To: Pavel Tatashin <pasha.tatashin@soleen.com>
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
 David Hildenbrand <david@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux MM <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, May 1, 2019 at 11:07 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Wed, May 1, 2019 at 4:25 PM Pavel Tatashin <pasha.tatashin@soleen.com> wrote:
> >
> > On 19-04-17 11:39:00, Dan Williams wrote:
> > > Towards enabling memory hotplug to track partial population of a
> > > section, introduce 'struct mem_section_usage'.
> > >
> > > A pointer to a 'struct mem_section_usage' instance replaces the existing
> > > pointer to a 'pageblock_flags' bitmap. Effectively it adds one more
> > > 'unsigned long' beyond the 'pageblock_flags' (usemap) allocation to
> > > house a new 'map_active' bitmap.  The new bitmap enables the memory
> > > hot{plug,remove} implementation to act on incremental sub-divisions of a
> > > section.
> > >
> > > The primary motivation for this functionality is to support platforms
> > > that mix "System RAM" and "Persistent Memory" within a single section,
> > > or multiple PMEM ranges with different mapping lifetimes within a single
> > > section. The section restriction for hotplug has caused an ongoing saga
> > > of hacks and bugs for devm_memremap_pages() users.
> > >
> > > Beyond the fixups to teach existing paths how to retrieve the 'usemap'
> > > from a section, and updates to usemap allocation path, there are no
> > > expected behavior changes.
> > >
> > > Cc: Michal Hocko <mhocko@suse.com>
> > > Cc: Vlastimil Babka <vbabka@suse.cz>
> > > Cc: Logan Gunthorpe <logang@deltatee.com>
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > ---
> > >  include/linux/mmzone.h |   23 ++++++++++++--
> > >  mm/memory_hotplug.c    |   18 ++++++-----
> > >  mm/page_alloc.c        |    2 +
> > >  mm/sparse.c            |   81 ++++++++++++++++++++++++------------------------
> > >  4 files changed, 71 insertions(+), 53 deletions(-)
> > >
> > > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > > index 70394cabaf4e..f0bbd85dc19a 100644
> > > --- a/include/linux/mmzone.h
> > > +++ b/include/linux/mmzone.h
> > > @@ -1160,6 +1160,19 @@ static inline unsigned long section_nr_to_pfn(unsigned long sec)
> > >  #define SECTION_ALIGN_UP(pfn)        (((pfn) + PAGES_PER_SECTION - 1) & PAGE_SECTION_MASK)
> > >  #define SECTION_ALIGN_DOWN(pfn)      ((pfn) & PAGE_SECTION_MASK)
> > >
> > > +#define SECTION_ACTIVE_SIZE ((1UL << SECTION_SIZE_BITS) / BITS_PER_LONG)
> > > +#define SECTION_ACTIVE_MASK (~(SECTION_ACTIVE_SIZE - 1))
> > > +
> > > +struct mem_section_usage {
> > > +     /*
> > > +      * SECTION_ACTIVE_SIZE portions of the section that are populated in
> > > +      * the memmap
> > > +      */
> > > +     unsigned long map_active;
> >
> > I think this should be proportional to section_size / subsection_size.
> > For example, on intel section size = 128M, and subsection is 2M, so
> > 64bits work nicely. But, on arm64 section size if 1G, so subsection is
> > 16M.
> >
> > On the other hand 16M is already much better than what we have: with 1G
> > section size and 2M pmem alignment we guaranteed to loose 1022M. And
> > with 16M subsection it is only 14M.
>
> I'm ok with it being 16M for now unless it causes a problem in
> practice, i.e. something like the minimum hardware mapping alignment
> for physical memory being less than 16M.

On second thought, arbitrary differences across architectures is a bit
sad. The most common nvdimm namespace alignment granularity is
PMD_SIZE, so perhaps the default sub-section size should try to match
that default.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
