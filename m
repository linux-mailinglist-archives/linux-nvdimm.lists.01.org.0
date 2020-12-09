Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 960BD2D4C66
	for <lists+linux-nvdimm@lfdr.de>; Wed,  9 Dec 2020 22:03:43 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C11F1100EBB90;
	Wed,  9 Dec 2020 13:03:41 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=203.18.50.4; helo=nat-hk.nvidia.com; envelope-from=jgg@nvidia.com; receiver=<UNKNOWN> 
Received: from nat-hk.nvidia.com (nat-hk.nvidia.com [203.18.50.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8BB4E100ED4AF
	for <linux-nvdimm@lists.01.org>; Wed,  9 Dec 2020 13:03:39 -0800 (PST)
Received: from HKMAIL101.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
	id <B5fd13baa0000>; Thu, 10 Dec 2020 05:03:38 +0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 9 Dec
 2020 21:03:36 +0000
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.53) by
 HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 9 Dec 2020 21:03:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OLm9VXhUW89ADvA5fQ+8igjqj/tklKVTPNFIGQFOCNWwkZ6lqwlwIq3Gm5oQDXevZoGZHmXHh/phIpGyiHPoO9VQ6aqT+SI+JkumAO98aiZVR65rn+53MBtMPS8kFrMY636/tKvSFjXLFjQxTiYTeSEA8BiPAsqf24m2I7XfwGr2v3lKRmzEmTGJ7Bnh/EkkPZT0Ta7f3ICCrp/+BOTXLHbdwUxtZuiO80bZ0qHy0hnQEEsWS2lPGnvnrFey7Rzeyp8mNRKP0sAXj948GmG2UUVRYCH3JQogLLEd+oOVyUnbXfTtEekUDdABvD7jwyioxK9lh0gBMr5UU2Tu22AV/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rc+CwgZOH6EelmjNGA5qY8iOWzJ9DtPiB7oBS9+BNIA=;
 b=DxgmS2Jsmcc4oKfdPiiIDS/OqiZQvYqmbOVHafSbMpMz1W6r455WhJ6bUkaBVVD6GhyK7ntLTvaGaJH4MsLI5qvtFowuTCKt29zLncqqyjfWoXYid528VU2cI4OZ1m5Lnv4Ih1uWhs3wWCmz3QYoRamAs7HgMjTb5kQ900HZorgBMrTsfM4cE1H6JIv21b59+kXBBG8k9IO97FnYvvOSkYBw0nfJ22+usMS+na+yjEwaMDccMx90cKoMG9IjD4YuCGaWfw3PVRou8jC2uKnlxyTeWh5lORsi4kDd0fodx0GdgqFhfrV5xmqxqDI4SnZwyF4w+Chb59moSuQ3q898sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2859.namprd12.prod.outlook.com (2603:10b6:5:15d::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Wed, 9 Dec
 2020 21:03:34 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433%3]) with mapi id 15.20.3632.023; Wed, 9 Dec 2020
 21:03:34 +0000
Date: Wed, 9 Dec 2020 17:03:32 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH] mm/up: combine put_compound_head() and unpin_user_page()
Message-ID: <20201209210332.GW552508@nvidia.com>
References: <0-v1-6730d4ee0d32+40e6-gup_combine_put_jgg@nvidia.com>
 <16128311-9874-dcd4-c641-c68b34c9d634@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <16128311-9874-dcd4-c641-c68b34c9d634@nvidia.com>
X-ClientProxiedBy: MN2PR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:208:d4::28) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR04CA0015.namprd04.prod.outlook.com (2603:10b6:208:d4::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Wed, 9 Dec 2020 21:03:33 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from <jgg@nvidia.com>)	id 1kn6cW-008OWG-I0; Wed, 09 Dec 2020 17:03:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
	t=1607547818; bh=rc+CwgZOH6EelmjNGA5qY8iOWzJ9DtPiB7oBS9+BNIA=;
	h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
	 From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType;
	b=kzj2+6uRcy2sBdLLJaleOerBK3GXNY+vdNfOyeuUJPQUcKUZcoQzkXx094oINA5C9
	 uIFqfzTackkchIrArCGnPt6VhRy6lUF3xB+jMuQdudgJ9bq45rVEZ8tLFspYGBF0JA
	 1qiTnmrPGNSFE/svnawgzvn5Y+ZwF433lYFENnWCI7kI7Iki4BuvZoORHysMGhXrG+
	 APQtHlZDiXOoi/BM/nBm1xnR40s6ShqR92KXswDrcHR95Eng0as6gjwQpgbp3+DWmL
	 Mfjb1ngjSlgu6lN+xoWvfbe4EUTEB53EeSseWvDKIYI72uz0Rcaq+iqsdjTHTYcQKN
	 QavPHg+LQMfwQ==
Message-ID-Hash: KMFKLL3U4J64MOOJIFWAOK7SWVLYBMJG
X-Message-ID-Hash: KMFKLL3U4J64MOOJIFWAOK7SWVLYBMJG
X-MailFrom: jgg@nvidia.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Joao Martins <joao.m.martins@oracle.com>, linux-mm <linux-mm@kvack.org>, Jonathan Corbet <corbet@lwn.net>, Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, linux-nvdimm@lists.01.org, Michal Hocko <mhocko@suse.com>, Mike Kravetz <mike.kravetz@oracle.com>, Shuah Khan <shuah@kernel.org>, Muchun Song <songmuchun@bytedance.com>, Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KMFKLL3U4J64MOOJIFWAOK7SWVLYBMJG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: 7bit

On Wed, Dec 09, 2020 at 12:57:38PM -0800, John Hubbard wrote:
> > diff --git a/mm/gup.c b/mm/gup.c
> > index 98eb8e6d2609c3..7b33b7d4b324d7 100644
> > +++ b/mm/gup.c
> > @@ -123,6 +123,28 @@ static __maybe_unused struct page *try_grab_compound_head(struct page *page,
> >   	return NULL;
> >   }
> > +static void put_compound_head(struct page *page, int refs, unsigned int flags)
> > +{
> 
> It might be nice to rename "page" to "head", here.
> 
> While reading this I toyed with the idea of having this at the top:
> 
> 	VM_BUG_ON_PAGE(compound_head(page) != page, page);
> 
> ...but it's overkill in a static function with pretty clear call sites. So I
> think it's just right as-is.

Matt's folio patches would take are of this, when that is available
all this becomes a lot better.

Thanks,
Jason
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
