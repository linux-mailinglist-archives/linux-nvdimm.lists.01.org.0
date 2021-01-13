Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 469F12F54AC
	for <lists+linux-nvdimm@lfdr.de>; Wed, 13 Jan 2021 22:52:29 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 67EFC100F2243;
	Wed, 13 Jan 2021 13:52:27 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 29A18100F2242
	for <linux-nvdimm@lists.01.org>; Wed, 13 Jan 2021 13:52:25 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id p22so3552932edu.11
        for <linux-nvdimm@lists.01.org>; Wed, 13 Jan 2021 13:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tkCEm6n1O2YDsdNDXJh8BIEgy3kecFF0HQkrvLtX2UM=;
        b=SRVHAUkpjdzGINze2D0SPtwgt3b82Lz/3p99J6k6sZtsuYKAjn5691k8Rp8b7FUCS9
         6Rl0wbuf5DR1iOh0Bu8H2VEZHjnIko2IpIeXpeyK7UoEOQcvVEg5ATgpU7ILN8FvrLOJ
         tU3S5Kbj9+NbosbQygaXJCjPhAON9p+WjNYl7vNEwbEZCP9WYe8jbt/lceuyN/JtZNF5
         +lFs1SUeHRZFbP1fqinWUwwE0BMOo8UJwXrlPxyWIiOOAWjRy+q03pNsCcP6kNzLLcBO
         RuItbDUV2Wl4/PPqfv0rryUy9n2oc//db/8GySCvN+q/K5oHMfeMYIBqGtgHAkGv+XnY
         d9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tkCEm6n1O2YDsdNDXJh8BIEgy3kecFF0HQkrvLtX2UM=;
        b=gBAba0eFkdoTLUwo19/KOeYzrzh8pCg0qBHaObhuvLmBUbo5WBOdXqRgRINYzSW3qC
         c512muzdpdnf4AWyymd9HtM3yuTeE8BnVgHHmH//Lvvpe6TxErkXe0w1ysKr7VWbkXBg
         AW8DvFMJyBX1WF30UhwnErTI4KJN95Vk8jD4/v6wm5UhaGOW77BPLScorB2zLQpgX+y+
         r2TWRWxq90R3BpfaZ7t2SpshReNHQqmewwe+/IAXj7UuvkjcNXpWwfSGWUI5c0NEyi0e
         XFAGvC+4MYs0F6sqtFg9h1mdU+h8yq+LrNR4+95D5KnERuFUSYiiwPbSqU2uY6C0jJLp
         CG9Q==
X-Gm-Message-State: AOAM530Vna89vuNoknx/GfJzTjZ9cPe03SLr8XcMeldNp0VI49N4Zpof
	30h3OxDE2yy4NKxWW21+Aqry1WFMZBhmwAGXp6sbjA==
X-Google-Smtp-Source: ABdhPJzSD6+Rzk4Z+duLWEpDKBIxKbqxC88SAUZRbhvaMudyDSDTALy3KwUquixL/d2ZtGuR3ksAPlHMa75yFMUJrmM=
X-Received: by 2002:aa7:c3cd:: with SMTP id l13mr3362518edr.97.1610574743900;
 Wed, 13 Jan 2021 13:52:23 -0800 (PST)
MIME-Version: 1.0
References: <161052331545.1805594.2356512831689786960.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161052332755.1805594.9846390935351758277.stgit@dwillia2-desk3.amr.corp.intel.com>
 <230efa36-9192-fe52-b8b6-16b2feafb70b@redhat.com>
In-Reply-To: <230efa36-9192-fe52-b8b6-16b2feafb70b@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 13 Jan 2021 13:52:14 -0800
Message-ID: <CAPcyv4i4yGjsMf2SyixLicDjzRGes97vaSa+mF4=Y9Uagk_0jg@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] mm: Teach pfn_to_online_page() to consider
 subsection validity
To: David Hildenbrand <david@redhat.com>
Message-ID-Hash: Y2TUYZPHB4OEKZX3BDS6OGWEQ23EUTQE
X-Message-ID-Hash: Y2TUYZPHB4OEKZX3BDS6OGWEQ23EUTQE
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux MM <linux-mm@kvack.org>, Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@suse.com>, Oscar Salvador <osalvador@suse.de>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/Y2TUYZPHB4OEKZX3BDS6OGWEQ23EUTQE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jan 13, 2021 at 12:29 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 13.01.21 08:35, Dan Williams wrote:
> > pfn_section_valid() determines pfn validity on subsection granularity
> > where pfn_valid() may be limited to coarse section granularity.
> > Explicitly validate subsections after pfn_valid() succeeds.
> >
> > Fixes: b13bc35193d9 ("mm/hotplug: invalid PFNs from pfn_to_online_page()")
> > Cc: Qian Cai <cai@lca.pw>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: Oscar Salvador <osalvador@suse.de>
> > Reported-by: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  mm/memory_hotplug.c |   24 ++++++++++++++++++++----
> >  1 file changed, 20 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> > index 55a69d4396e7..9f37f8a68da4 100644
> > --- a/mm/memory_hotplug.c
> > +++ b/mm/memory_hotplug.c
> > @@ -308,11 +308,27 @@ static int check_hotplug_memory_addressable(unsigned long pfn,
> >  struct page *pfn_to_online_page(unsigned long pfn)
> >  {
> >       unsigned long nr = pfn_to_section_nr(pfn);
> > +     struct mem_section *ms;
> > +
> > +     if (nr >= NR_MEM_SECTIONS)
> > +             return NULL;
> > +
> > +     ms = __nr_to_section(nr);
> > +     if (!online_section(ms))
> > +             return NULL;
> > +
> > +     /*
> > +      * Save some code text when online_section() +
> > +      * pfn_section_valid() are sufficient.
> > +      */
> > +     if (IS_ENABLED(CONFIG_HAVE_ARCH_PFN_VALID))
> > +             if (!pfn_valid(pfn))
> > +                     return NULL;
>
> Nit:
>
> if (IS_ENABLED(CONFIG_HAVE_ARCH_PFN_VALID) &&
>     !pfn_valid(pfn))
>

Ok... I'll do a final resend "To: akpm" after the kbuild robot
finishes chewing on this series.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
