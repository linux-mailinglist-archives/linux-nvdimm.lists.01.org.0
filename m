Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F039C349291
	for <lists+linux-nvdimm@lfdr.de>; Thu, 25 Mar 2021 14:02:51 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A3585100ED4BB;
	Thu, 25 Mar 2021 06:02:49 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.205.24.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D7300100EF271
	for <linux-nvdimm@lists.01.org>; Thu, 25 Mar 2021 06:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1616677366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FwWZJPBaAmN+VY9ozn1oVCEcu1CBKTJa99Q0BFn4OQI=;
	b=Lm/hfgBnHGDLcc/lQOGo+SHEeOmpoha0L2euhWC1xkZ9dI6gsrcYlbX0dB+RG5Bi6oIxsy
	AnmvbGFyPUHZ9JXmNaLVlJTom7DkS5TrgYuHcs9r9RyEayy/P4gyvghCTRro8rM94iMVKg
	atm748Yi/WVfFGibDlgsDgP682qkBTU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515-t0Ss08QpONaeHfc-Em4w5Q-1; Thu, 25 Mar 2021 09:02:43 -0400
X-MC-Unique: t0Ss08QpONaeHfc-Em4w5Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84AEE801817;
	Thu, 25 Mar 2021 13:02:40 +0000 (UTC)
Received: from [10.36.115.72] (ovpn-115-72.ams2.redhat.com [10.36.115.72])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C7EE25D9CA;
	Thu, 25 Mar 2021 13:02:35 +0000 (UTC)
To: Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
 linux-nvdimm@lists.01.org
References: <161604048257.1463742.1374527716381197629.stgit@dwillia2-desk3.amr.corp.intel.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH 0/3] mm, pmem: Force unmap pmem on surprise remove
Message-ID: <22545105-d3f1-23b1-948c-8481af839f21@redhat.com>
Date: Thu, 25 Mar 2021 14:02:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <161604048257.1463742.1374527716381197629.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Message-ID-Hash: QVQVW5WVE6X2IQYA7TO6RP72PQ43N3WA
X-Message-ID-Hash: QVQVW5WVE6X2IQYA7TO6RP72PQ43N3WA
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>, Dave Chinner <david@fromorbit.com>, Matthew Wilcox <willy@infradead.org>, Naoya Horiguchi <naoya.horiguchi@nec.com>, Shiyang Ruan <ruansy.fnst@fujitsu.com>, Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QVQVW5WVE6X2IQYA7TO6RP72PQ43N3WA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 18.03.21 05:08, Dan Williams wrote:
> Summary:
> 
> A dax_dev can be unbound from its driver at any time. Unbind can not
> fail. The driver-core will always trigger ->remove() and the result from
> ->remove() is ignored. After ->remove() the driver-core proceeds to tear
> down context. The filesystem-dax implementation can leave pfns mapped
> after ->remove() if it is triggered while the filesystem is mounted.
> Security and data-integrity is forfeit if the dax_dev is repurposed for
> another security domain (new filesystem or change device modes), or if
> the dax_dev is physically replaced. CXL is a hotplug bus that makes
> dax_dev physical replace a real world prospect.
> 
> All dax_dev pfns must be unmapped at remove. Detect the "remove while
> mounted" case and trigger memory_failure() over the entire dax_dev
> range.
> 
> Details:
> 
> The get_user_pages_fast() path expects all synchronization to be handled
> by the pattern of checking for pte presence, taking a page reference,
> and then validating that the pte was stable over that event. The
> gup-fast path for devmap / DAX pages additionally attempts to take/hold
> a live reference against the hosting pgmap over the page pin. The
> rational for the pgmap reference is to synchronize against a dax-device
> unbind / ->remove() event, but that is unnecessary if pte invalidation
> is guaranteed in the ->remove() path.
> 
> Global dax-device pte invalidation *does* happen when the device is in
> raw "device-dax" mode where there is a single shared inode to unmap at
> remove, but the filesystem-dax path has a large number of actively
> mapped inodes unknown to the driver at ->remove() time. So, that unmap
> does not happen today for filesystem-dax. However, as Jason points out,
> that unmap / invalidation *needs* to happen not only to cleanup
> get_user_pages_fast() semantics, but in a future (see CXL) where dax_dev
> ->remove() is correlated with actual physical removal / replacement the
> implications of allowing a physical pfn to be exchanged without tearing
> down old mappings are severe (security and data-integrity).
> 
> What is not in this patch set is coordination with the dax_kmem driver
> to trigger memory_failure() when the dax_dev is onlined as "System
> RAM". The remove_memory() API was built with the assumption that
> platform firmware negotiates all removal requests and the OS has a
> chance to say "no". This is why dax_kmem today simply leaks
> request_region() to burn that physical address space for any other
> usage until the next reboot on a manual unbind event if the memory can't
> be offlined. However a future to make sure that remove_memory() succeeds
> after memory_failure() of the same range seems a better semantic than
> permanently burning physical address space.

I'd have similar requirements for virtio-mem on forced driver unloading 
(although less of an issue, because in contrast to cxl, it doesn't 
really happen in sane environments). However, I'm afraid there are 
absolutely no guarantees that you can actually offline+rip out memory 
exposed to the buddy, at least in the general case.

I guess it might be possible to some degree if memory was onlined to 
ZONE_MOVABLE (there are still no guarantees, though), however, bets are 
completely off with ZONE_NORMAL. Just imagine the memmap of one dax 
device being allocated from another dax device. You cannot possibly 
invalidate via memory_failure() and rip out the memory without crashing 
the whole system afterwards.

-- 
Thanks,

David / dhildenb
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
