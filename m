Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F9530C220
	for <lists+linux-nvdimm@lfdr.de>; Tue,  2 Feb 2021 15:42:55 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D7B5D100EA2B3;
	Tue,  2 Feb 2021 06:42:53 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.205.24.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 71905100F2276
	for <linux-nvdimm@lists.01.org>; Tue,  2 Feb 2021 06:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1612276969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p9WVcjtJGSRM6w7F2m39UE8iZCliMcHMPGNuV986qrI=;
	b=hQ3Tso4xUNA6BcbnqEQ3Qn2KNig6XhdHi73BnogWswFN4F3MYGYd8hXtpnt/vVRxVqEtZ4
	2TuBBZrI4gMd3ZfA2xz23WMP8NCN4ZrQztaLcfRxZ20SeUb1uDSgTDUxDD6VrFWiXU+q1y
	GuMr1JWZdwW0sT74o++/1MnRLo2DHGA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-8AQi4yF_NHCuVEWiuakmOQ-1; Tue, 02 Feb 2021 09:42:42 -0500
X-MC-Unique: 8AQi4yF_NHCuVEWiuakmOQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46BB9184DBED;
	Tue,  2 Feb 2021 14:42:36 +0000 (UTC)
Received: from [10.36.114.148] (ovpn-114-148.ams2.redhat.com [10.36.114.148])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 36D6560916;
	Tue,  2 Feb 2021 14:42:28 +0000 (UTC)
To: Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>
References: <20210121122723.3446-1-rppt@kernel.org>
 <20210121122723.3446-8-rppt@kernel.org> <20210126114657.GL827@dhcp22.suse.cz>
 <303f348d-e494-e386-d1f5-14505b5da254@redhat.com>
 <20210126120823.GM827@dhcp22.suse.cz> <20210128092259.GB242749@kernel.org>
 <YBK1kqL7JA7NePBQ@dhcp22.suse.cz> <20210129072128.GD242749@kernel.org>
 <YBPMg/C5Sb78gFEB@dhcp22.suse.cz>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH v16 07/11] secretmem: use PMD-size pages to amortize
 direct map fragmentation
Message-ID: <f1f65516-e222-6543-aeae-9a1dc9920de8@redhat.com>
Date: Tue, 2 Feb 2021 15:42:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <YBPMg/C5Sb78gFEB@dhcp22.suse.cz>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Message-ID-Hash: ESDXWNL3IVAKXZBRQKLL2KTFE6DO2I62
X-Message-ID-Hash: ESDXWNL3IVAKXZBRQKLL2KTFE6DO2I62
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon
  <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>, Palmer Dabbelt <palmerdabbelt@google.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ESDXWNL3IVAKXZBRQKLL2KTFE6DO2I62/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 29.01.21 09:51, Michal Hocko wrote:
> On Fri 29-01-21 09:21:28, Mike Rapoport wrote:
>> On Thu, Jan 28, 2021 at 02:01:06PM +0100, Michal Hocko wrote:
>>> On Thu 28-01-21 11:22:59, Mike Rapoport wrote:
>>>
>>>> And hugetlb pools may be also depleted by anybody by calling
>>>> mmap(MAP_HUGETLB) and there is no any limiting knob for this, while
>>>> secretmem has RLIMIT_MEMLOCK.
>>>
>>> Yes it can fail. But it would fail at the mmap time when the reservation
>>> fails. Not during the #PF time which can be at any time.
>>
>> It may fail at $PF time as well:
>>
>> hugetlb_fault()
>>          hugeltb_no_page()
>>                  ...
>>                  alloc_huge_page()
>>                          alloc_gigantic_page()
>>                                  cma_alloc()
>>                                          -ENOMEM;
> 
> I would have to double check. From what I remember cma allocator is an
> optimization to increase chances to allocate hugetlb pages when
> overcommiting because pages should be normally pre-allocated in the pool
> and reserved during mmap time. But even if a hugetlb page is not pre
> allocated then this will get propagated as SIGBUS unless that has
> changed.

It's an optimization to allocate gigantic pages dynamically later (so 
not using memblock during boot). Not just for overcommit, but for any 
kind of allocation.

The actual allocation from cma should happen when setting nr_pages:

nr_hugepages_store_common()->set_max_huge_pages()->alloc_pool_huge_page()...->alloc_gigantic_page()

The path described above seems to be trying to overcommit gigantic 
pages, something that can be expected to SIGBUS. Reservations are 
handled via the pre-allocated pool.

-- 
Thanks,

David / dhildenb
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
