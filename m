Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46790206B2C
	for <lists+linux-nvdimm@lfdr.de>; Wed, 24 Jun 2020 06:32:48 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8CAC610FC4AD2;
	Tue, 23 Jun 2020 21:32:46 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com; envelope-from=rientjes@google.com; receiver=<UNKNOWN> 
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id AE52810FC38BC
	for <linux-nvdimm@lists.01.org>; Tue, 23 Jun 2020 21:32:43 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id f3so775730pgr.2
        for <linux-nvdimm@lists.01.org>; Tue, 23 Jun 2020 21:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=e0EpgUPvb3oHQJmMLTQgcHeM9n6YCWTkRNUuoek9hfg=;
        b=ed4OK0LOIth9jOXTiae1LeoQbTkRLW3h1DOXDFGhdT+RK8JeF46h3VV+io9JyJ/qWn
         fxlglfyDQjotzQGlmf/inIKOHLFVr70dt/YLCY4wulI/K0qAWpQMi7YwoSm70rRQRwgk
         VccBTh0C7e07735Tz2QuNlq+FWdoCTo0yK5cXV+LUO0y8+sgmrWZsOnwA8d2y0hqSDH3
         6aV+qLghe9fiHfD+ZLhm/v7LO8V/ErgejMdULGdU7/H4vQWsUQjXMf4QpPcg5G4MkTfV
         IDTGnKUwvAMeNveHI16hg8HyQO4HJhnLcc3nZIZsAoMEquhfMRcE7c5gblvXgxiyApZl
         2aYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=e0EpgUPvb3oHQJmMLTQgcHeM9n6YCWTkRNUuoek9hfg=;
        b=jqjsFe23F19yNQ675JU6srNcwiJ5t2t4zOVZ/8CyQslPZK9BYFKvhh8VGrr6vqdilb
         7XwSN4cMYVJ6Rf7iJuyRiNkXo8XPqCP3n+MVAixR9subWK+JFSKb/WoOm9JYncSPF/pF
         sjlP8j/7oTiuATdDP0WSXXuepbR/Ok8rGIgg+lGv0L4rooQqVbMv0IZyoqipC/F8gsxR
         8qzJYARrqRamZTBiQ4WzOWZaW0mVkt25eCY8w34ItN+z7sKj0xer6Pmce+wx9/y96pov
         hoek/MU3vL/t9RQ219UL4sqLroPh7koEmtF/g/g7Lxrn9SvIIejSY5q6gj1Q2dNXSDdV
         +HTQ==
X-Gm-Message-State: AOAM530nhr/mD6BZ5EXsoMZc7tw2n8wLnDJjnOyPdOo02CcwRm6gocm1
	BVPmS5Buj4kU5XD6TIDsnB0qDg==
X-Google-Smtp-Source: ABdhPJwlS3fHaPwPLhKXuHqqHNQLJX8fzM5Xx9ZkK7q6D7wHwgwL3bpHPJ7udhXXKTVoOZqNrpiOig==
X-Received: by 2002:a63:5013:: with SMTP id e19mr19742148pgb.68.1592973162813;
        Tue, 23 Jun 2020 21:32:42 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id y187sm18817777pfb.46.2020.06.23.21.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 21:32:42 -0700 (PDT)
Date: Tue, 23 Jun 2020 21:32:41 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: "Luck, Tony" <tony.luck@intel.com>, Mike Kravetz <mike.kravetz@oracle.com>,
    "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
    Peter Xu <peterx@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [RFC] Make the memory failure blast radius more precise
In-Reply-To: <20200623220412.GA21232@agluck-desk2.amr.corp.intel.com>
Message-ID: <alpine.DEB.2.22.394.2006232114100.97817@chino.kir.corp.google.com>
References: <20200623201745.GG21350@casper.infradead.org> <20200623220412.GA21232@agluck-desk2.amr.corp.intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Message-ID-Hash: NCEUSBIMA7AKF56RYJJ6NV4EVIEGEMVK
X-Message-ID-Hash: NCEUSBIMA7AKF56RYJJ6NV4EVIEGEMVK
X-MailFrom: rientjes@google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Matthew Wilcox <willy@infradead.org>, Borislav Petkov <bp@alien8.de>, Naoya Horiguchi <naoya.horiguchi@nec.com>, linux-edac@vger.kernel.org, linux-mm@kvack.org, linux-nvdimm@lists.01.org, "Darrick J. Wong" <darrick.wong@oracle.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NCEUSBIMA7AKF56RYJJ6NV4EVIEGEMVK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 23 Jun 2020, Luck, Tony wrote:

> > Hardware actually tells us the blast radius of the error, but we ignore
> > it and take out the entire page.  We've had a customer request to know
> > exactly how much of the page is damaged so they can avoid reconstructing
> > an entire 2MB page if only a single cacheline is damaged.
> > 
> > This is only a strawman that I did in an hour or two; I'd appreciate
> > architectural-level feedback.  Should I just convert memory_failure() to
> > always take an address & granularity?  Should I create a struct to pass
> > around (page, phys, granularity) instead of reconstructing the missing
> > pieces in half a dozen functions?  Is this functionality welcome at all,
> > or is the risk of upsetting applications which expect at least a page
> > of granularity too high?
> 
> What is the interface to these applications that want finer granularity?
> 
> Current code does very poorly with hugetlbfs pages ... user loses the
> whole 2 MB or 1GB. That's just silly (though I've been told that it is
> hard to fix because allowing a hugetlbfs page to be broken up at an arbitrary
> time as the result of a mahcine check means that the kernel needs locking
> around a bunch of fas paths that currently assume that a huge page will
> stay being a huge page).
> 

Thanks for bringing this up, Tony.  Mike Kravetz pointed me to this thread 
(thanks Mike!) so let's add him in explicitly as well as Andrea, Peter, 
and David from Red Hat who we've been discussing an idea with that may 
introduce exactly this needed support but for different purposes :)  The 
timing of this thread is _uncanny_.

To improve the performance of userfaultfd for the purposes of post-copy 
live migration we need to reduce the granularity in which pages are 
migrated; we're looking at this from a 1GB gigantic page perspective but 
the same arguments can likely be had for 2MB hugepages as well.  1GB pages 
are too much of a bottleneck and, as you bring up, 1GB is simply too much 
memory to poison :)  We don't have 1GB thp support so the big idea was to 
introduce thp-like DoubleMap support into hugetlbfs for the purposes of 
post-copy live migration and then I had the idea that this could be 
extended to memory failure as well.

(We don't see the lack of 1GB thp here as a deficiency for anything other 
than these two issues, hugetlb provides strong guarantees.)

I don't want to hijack Matthew's thread which is primarily about DAX, but 
did get intrigued by your concerns about hugetlbfs page poisoning.  We can 
fork the thread off here to discuss only the hugetlb application of this 
if it makes sense to you or you'd like to collaborate on it as well.

The DoubleMap support would allow us to map the 1GB gigantic pages with 
the PUD and the PMDs as well (and, further, the 2MB hugepages with the PMD 
and PTEs) so that we can copy fragments into PMDs or PTEs and we don't 
need to migrate the entire gigantic page.  Any access triggers #PF through 
hugetlb_no_page() -> handle_userfault() which would trigger another 
UFFDIO_COPY and map another fragment.

Assume a world where this DoubleMap support already exists for hugetlb 
pages today and all the invariants including page migration are fixed up 
(since a PTE can now map a hugetlb page and a PMD can now map a gigantic 
hugetlb page).  It *seems* like we'd be able to reduce the blast radius 
here too on a hard memory failure: dissolve the gigantic page in place, 
SIGBUS/SIGKILL on the bad PMD or PTE, and avoid poisoning the head of the 
hugetlb page.  We agree that poisoning this large amount of memory is not 
ideal :)

Anyway, this was some brainstorming that I was doing with Mike and the 
others based on the idea of using DoubleMap support for post-copy live 
migration.  If you would be interested or would like to collaborate on 
it, we'd love to talk.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
