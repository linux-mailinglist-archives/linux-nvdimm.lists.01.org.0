Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE2E374854
	for <lists+linux-nvdimm@lfdr.de>; Wed,  5 May 2021 21:00:00 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6511D100EB334;
	Wed,  5 May 2021 11:59:58 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id AA88B100EB332
	for <linux-nvdimm@lists.01.org>; Wed,  5 May 2021 11:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7Ts3m9Dmu8TbFp1Zou/lAmdxBv7vUaszRSdZtygGL3s=; b=eKuCCZ+YLLh/IfsiA2w2TJnrVq
	OgsO6w/D0Fq0g3dHXII9KGzSc/qTA7NBXv38JF7QEOyGbRPI+lQzcqZ/aYb1SJdMtttFxdlIc3UQ/
	gsmOyS+xv0AUj0u8nQICpJLKl56GUf2FrWTZOM83hUHEaRUlaciSIebpnb1qCyo4mDgKcSsFsux3z
	GpYO6JkYOwrZCA4dlgPSWLWUiu+cO4qfsDeNbKDkLDDBtW5y5BKAsBa/6OCccyEKi+VnNszzSVzSv
	zt9omkCl03D90I/M5UK6bjixbmbSfSvHuxKrCa402BYQq/BIo+9XdgPVWy1RoH0ejumnnoRoDgRUG
	r6n6Og3w==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
	id 1leMjW-000nXf-H1; Wed, 05 May 2021 18:59:01 +0000
Date: Wed, 5 May 2021 19:58:54 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v1 04/11] mm/memremap: add ZONE_DEVICE support for
 compound pages
Message-ID: <20210505185854.GI1847222@casper.infradead.org>
References: <20210325230938.30752-1-joao.m.martins@oracle.com>
 <20210325230938.30752-5-joao.m.martins@oracle.com>
 <CAPcyv4gs_rHL7FPqyQEb3yT4jrv8Wo_xA2ojKsppoBfmDocq8A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4gs_rHL7FPqyQEb3yT4jrv8Wo_xA2ojKsppoBfmDocq8A@mail.gmail.com>
Message-ID-Hash: FB7ZDOUBE5QKMJQCWXB2VO5EQWSX2VXL
X-Message-ID-Hash: FB7ZDOUBE5QKMJQCWXB2VO5EQWSX2VXL
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Joao Martins <joao.m.martins@oracle.com>, Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Jason Gunthorpe <jgg@ziepe.ca>, Jane Chu <jane.chu@oracle.com>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FB7ZDOUBE5QKMJQCWXB2VO5EQWSX2VXL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, May 05, 2021 at 11:44:29AM -0700, Dan Williams wrote:
> > @@ -6285,6 +6285,8 @@ void __ref memmap_init_zone_device(struct zone *zone,
> >         unsigned long pfn, end_pfn = start_pfn + nr_pages;
> >         struct pglist_data *pgdat = zone->zone_pgdat;
> >         struct vmem_altmap *altmap = pgmap_altmap(pgmap);
> > +       unsigned int pfn_align = pgmap_pfn_align(pgmap);
> > +       unsigned int order_align = order_base_2(pfn_align);
> >         unsigned long zone_idx = zone_idx(zone);
> >         unsigned long start = jiffies;
> >         int nid = pgdat->node_id;
> > @@ -6302,10 +6304,30 @@ void __ref memmap_init_zone_device(struct zone *zone,
> >                 nr_pages = end_pfn - start_pfn;
> >         }
> >
> > -       for (pfn = start_pfn; pfn < end_pfn; pfn++) {
> > +       for (pfn = start_pfn; pfn < end_pfn; pfn += pfn_align) {
> 
> pfn_align is in bytes and pfn is in pages... is there a "pfn_align >>=
> PAGE_SHIFT" I missed somewhere?

If something is measured in bytes, I like to use size_t (if it's
in memory) and loff_t (if it's on storage).  The compiler doesn't do
anything useful to warn you, but it's a nice indication to humans about
what's going on.  And it removes the temptation to do 'pfn_align >>=
PAGE_SHIFT' and suddenly take pfn_align from being measured in bytes to
being measured in pages.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
