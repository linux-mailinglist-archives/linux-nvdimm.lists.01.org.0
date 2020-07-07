Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE40217AD8
	for <lists+linux-nvdimm@lfdr.de>; Wed,  8 Jul 2020 00:06:11 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 28E4E1108E90C;
	Tue,  7 Jul 2020 15:06:10 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::641; helo=mail-ej1-x641.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8FD241108E90C
	for <linux-nvdimm@lists.01.org>; Tue,  7 Jul 2020 15:06:04 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id y10so48307097eje.1
        for <linux-nvdimm@lists.01.org>; Tue, 07 Jul 2020 15:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9ZNdEvOeP3WuasriJp99yNmKAqGYs/GDNRQigz82k5M=;
        b=H+n+9TP7Ync3pQ943fEua/W14EUsU6cicDP7/YLJ/PRvM+mZjYM8zcWL39+gexyw2V
         FYSk06t7fNJmZ7TAJ4Np01W5P1ft/pW/2VJ86staRo4F0UxvW1RVoJsVKMje5ZQPFrrS
         DFbfikXXkva+7/BFNQeoi9OPJ24mrF56i1SSrkTTH0SEekL/cUi8xID9xXwTRNSZ7YCX
         zn/UKP8JGJegSSE1H2tUhQI9FIZFmp4TLPJmWGQ4U8tZr1i6dSOqD5P6owjw9XJVKd7T
         jlPTIIXDpImb2q/1BlQID8aF78voE5pAskTFgCkqeFf+tOMh+B2lAG0WbP88eif7jpLo
         Ra7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9ZNdEvOeP3WuasriJp99yNmKAqGYs/GDNRQigz82k5M=;
        b=lw5JlIAlohBJWy9dbAr3qXa4GENKM8VA5y+0SyNmChgJeJmMUgBbR5zdmcWzXwk/Xs
         iMkx5EGSvOSea8Hc7+RWMxmIzV2JUOww+l+MfXo01Wxx60ykIK5PA7PdPUNDAZJ7gUdU
         bYwBVHDNAo2szayGtMiKqXHZ2sD4hzIquxwsbrre/PSpB/vsJyKKEgottFKEolHJ+jE6
         iFHPOMVPT/NotugHh/hCjTLLWkxLonj+3yngos12RltE7bnp1JLCcJRfJPfaddVeuEA4
         MTqSXYFi2KwsRTVsozkahHqYRPE+t4xuPWnmz+7gVChdRihiojCSfAkDX5MCZf5Hi6LG
         klig==
X-Gm-Message-State: AOAM532ZseMC398DHomoPB42BrDsaNdJzClR5WXQdMvalJme8YZf1JbG
	oHOZuQ3FutpiLDPm+RbErZrR/z+ffyNmoTk8queeew==
X-Google-Smtp-Source: ABdhPJzxamlNKlD2fbS8kUI/eRgH4V8jHgv25Sc3W50tBjzP0xq+Ps6l4+gy8ejY3ioNAlrVUymfpv+0QpgeJdPW3+I=
X-Received: by 2002:a17:906:1a54:: with SMTP id j20mr48420370ejf.455.1594159562129;
 Tue, 07 Jul 2020 15:06:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200707055917.143653-1-justin.he@arm.com> <20200707055917.143653-2-justin.he@arm.com>
 <20200707115454.GN5913@dhcp22.suse.cz> <20200707121302.GB9411@linux.ibm.com>
 <474f93e7-c709-1a13-5418-29f1777f614c@redhat.com> <20200707180043.GA386073@linux.ibm.com>
In-Reply-To: <20200707180043.GA386073@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 7 Jul 2020 15:05:48 -0700
Message-ID: <CAPcyv4iB-vP8U4pH_3jptfODbiNqJZXoTmA6+7EHoddk9jBgEQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] arm64/numa: export memory_add_physaddr_to_nid as EXPORT_SYMBOL_GPL
To: Mike Rapoport <rppt@linux.ibm.com>
Message-ID-Hash: VGPMGG5S7RDB7C2I77CJRKH2OBA4BXJF
X-Message-ID-Hash: VGPMGG5S7RDB7C2I77CJRKH2OBA4BXJF
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@kernel.org>, Jia He <justin.he@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, Chuhong Yuan <hslester96@gmail.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Kaly Xin <Kaly.Xin@arm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VGPMGG5S7RDB7C2I77CJRKH2OBA4BXJF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jul 7, 2020 at 11:01 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Tue, Jul 07, 2020 at 02:26:08PM +0200, David Hildenbrand wrote:
> > On 07.07.20 14:13, Mike Rapoport wrote:
> > > On Tue, Jul 07, 2020 at 01:54:54PM +0200, Michal Hocko wrote:
> > >> On Tue 07-07-20 13:59:15, Jia He wrote:
> > >>> This exports memory_add_physaddr_to_nid() for module driver to use.
> > >>>
> > >>> memory_add_physaddr_to_nid() is a fallback option to get the nid in case
> > >>> NUMA_NO_NID is detected.
> > >>>
> > >>> Suggested-by: David Hildenbrand <david@redhat.com>
> > >>> Signed-off-by: Jia He <justin.he@arm.com>
> > >>> ---
> > >>>  arch/arm64/mm/numa.c | 5 +++--
> > >>>  1 file changed, 3 insertions(+), 2 deletions(-)
> > >>>
> > >>> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
> > >>> index aafcee3e3f7e..7eeb31740248 100644
> > >>> --- a/arch/arm64/mm/numa.c
> > >>> +++ b/arch/arm64/mm/numa.c
> > >>> @@ -464,10 +464,11 @@ void __init arm64_numa_init(void)
> > >>>
> > >>>  /*
> > >>>   * We hope that we will be hotplugging memory on nodes we already know about,
> > >>> - * such that acpi_get_node() succeeds and we never fall back to this...
> > >>> + * such that acpi_get_node() succeeds. But when SRAT is not present, the node
> > >>> + * id may be probed as NUMA_NO_NODE by acpi, Here provide a fallback option.
> > >>>   */
> > >>>  int memory_add_physaddr_to_nid(u64 addr)
> > >>>  {
> > >>> - pr_warn("Unknown node for memory at 0x%llx, assuming node 0\n", addr);
> > >>>   return 0;
> > >>>  }
> > >>> +EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
> > >>
> > >> Does it make sense to export a noop function? Wouldn't make more sense
> > >> to simply make it static inline somewhere in a header? I haven't checked
> > >> whether there is an easy way to do that sanely bu this just hit my eyes.
> > >
> > > We'll need to either add a CONFIG_ option or arch specific callback to
> > > make both non-empty (x86, powerpc, ia64) and empty (arm64, sh)
> > > implementations coexist ...
> >
> > Note: I have a similar dummy (return 0) patch for s390x lying around here.
>
> Then we'll call it a tie - 3:3 ;-)

So I'd be happy to jump on the train of people wanting to export the
ARM stub for this (and add a new ARM stub for phys_to_target_node()),
but Will did have a plausibly better idea that I have been meaning to
circle back to:

http://lore.kernel.org/r/20200325111039.GA32109@willie-the-truck

...i.e. iterate over node data to do the lookup. This would seem to
work generically for multiple archs unless I am missing something?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
