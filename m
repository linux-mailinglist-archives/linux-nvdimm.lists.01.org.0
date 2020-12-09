Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A45A2D3EE9
	for <lists+linux-nvdimm@lfdr.de>; Wed,  9 Dec 2020 10:39:13 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BC3A8100EC1D7;
	Wed,  9 Dec 2020 01:39:10 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.205.24.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0E0EE100EF24F
	for <linux-nvdimm@lists.01.org>; Wed,  9 Dec 2020 01:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1607506744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=62CVn8KHlXPzOpNMJKaf07SHFbrMhmdZjfzPAXyPBAY=;
	b=P9WzFYZIWLS9132BU5VRpgM9Yhhp+G3tWtZt/4Qy+cLTtZ9yNyLwCf0yd+APHiyT5YB13C
	sq/jLfMf/QdsqbjOq4/SGxuUSzyEojnyU3c42sdsoiLAedPUr5zVHqO+9h97ES+mauyaSf
	0CwBqDqOcpvy1zNIMnHV8ur0fHrEYWQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-RK281QjPOfeFZWLjYFZrug-1; Wed, 09 Dec 2020 04:39:02 -0500
X-MC-Unique: RK281QjPOfeFZWLjYFZrug-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CDB9081CBF5;
	Wed,  9 Dec 2020 09:38:59 +0000 (UTC)
Received: from [10.36.114.167] (ovpn-114-167.ams2.redhat.com [10.36.114.167])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8349A60BF1;
	Wed,  9 Dec 2020 09:38:57 +0000 (UTC)
Subject: Re: [PATCH RFC 0/9] mm, sparse-vmemmap: Introduce compound pagemaps
To: Joao Martins <joao.m.martins@oracle.com>, linux-mm@kvack.org
References: <20201208172901.17384-1-joao.m.martins@oracle.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <3d6923af-2684-cbdc-928c-2d849cc2062b@redhat.com>
Date: Wed, 9 Dec 2020 10:38:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201208172901.17384-1-joao.m.martins@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Message-ID-Hash: BVRCC6BH5IGPNPISE4VZP6MNGUQJMTPC
X-Message-ID-Hash: BVRCC6BH5IGPNPISE4VZP6MNGUQJMTPC
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BVRCC6BH5IGPNPISE4VZP6MNGUQJMTPC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 08.12.20 18:28, Joao Martins wrote:
> Hey,
> 
> This small series, attempts at minimizing 'struct page' overhead by
> pursuing a similar approach as Muchun Song series "Free some vmemmap
> pages of hugetlb page"[0] but applied to devmap/ZONE_DEVICE. 
> 
> [0] https://lore.kernel.org/linux-mm/20201130151838.11208-1-songmuchun@bytedance.com/
> 
> The link above describes it quite nicely, but the idea is to reuse tail
> page vmemmap areas, particular the area which only describes tail pages.
> So a vmemmap page describes 64 struct pages, and the first page for a given
> ZONE_DEVICE vmemmap would contain the head page and 63 tail pages. The second
> vmemmap page would contain only tail pages, and that's what gets reused across
> the rest of the subsection/section. The bigger the page size, the bigger the
> savings (2M hpage -> save 6 vmemmap pages; 1G hpage -> save 4094 vmemmap pages).
> 
> In terms of savings, per 1Tb of memory, the struct page cost would go down
> with compound pagemap:
> 
> * with 2M pages we lose 4G instead of 16G (0.39% instead of 1.5% of total memory)
> * with 1G pages we lose 8MB instead of 16G (0.0007% instead of 1.5% of total memory)
> 

That's the dream :)

> Along the way I've extended it past 'struct page' overhead *trying* to address a
> few performance issues we knew about for pmem, specifically on the
> {pin,get}_user_pages* function family with device-dax vmas which are really
> slow even of the fast variants. THP is great on -fast variants but all except
> hugetlbfs perform rather poorly on non-fast gup.
> 
> So to summarize what the series does:
> 
> Patches 1-5: Much like Muchun series, we reuse tail page areas across a given
> page size (namely @align was referred by remaining memremap/dax code) and
> enabling of memremap to initialize the ZONE_DEVICE pages as compound pages or a
> given @align order. The main difference though, is that contrary to the hugetlbfs
> series, there's no vmemmap for the area, because we are onlining it.

Yeah, I'd argue that this case is a lot easier to handle. When the buddy
is involved, things get more complicated.

-- 
Thanks,

David / dhildenb
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
