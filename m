Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BEA2A3241
	for <lists+linux-nvdimm@lfdr.de>; Mon,  2 Nov 2020 18:51:32 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 748BD1630E0A3;
	Mon,  2 Nov 2020 09:51:30 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.205.24.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1B3181630E0A1
	for <linux-nvdimm@lists.01.org>; Mon,  2 Nov 2020 09:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1604339486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lp/prYQuMgVXccCGCiV61cLz4v5q5/mm6tHCPraHIqM=;
	b=EKQezKoEaQPVX0E/k1X4C/PLH+ukdpxJSN79mCzwzIu+B7Qv7oLCnGtx9+Sip+GlK1bsQJ
	CAf2b8g9yEqtQduC91gEuPv8Nzmr3RHL6XE2kbyRYhxXK+84na4K4NZJcF9DdLXj5yAeEV
	oA7Qf/09Hr525GSyHeWOYiePRs9Ql0w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-JugxVAtvMxar3jfSZTXWbg-1; Mon, 02 Nov 2020 12:51:22 -0500
X-MC-Unique: JugxVAtvMxar3jfSZTXWbg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1873F879512;
	Mon,  2 Nov 2020 17:51:18 +0000 (UTC)
Received: from [10.36.113.163] (ovpn-113-163.ams2.redhat.com [10.36.113.163])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EA9C15B4A9;
	Mon,  2 Nov 2020 17:51:10 +0000 (UTC)
Subject: Re: [PATCH v6 0/6] mm: introduce memfd_secret system call to create
 "secret" memory areas
To: Mike Rapoport <rppt@kernel.org>
References: <20200924132904.1391-1-rppt@kernel.org>
 <9c38ac3b-c677-6a87-ce82-ec53b69eaf71@redhat.com>
 <20201102174308.GF4879@kernel.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <d4cb2c87-4744-3929-cedd-2be78625a741@redhat.com>
Date: Mon, 2 Nov 2020 18:51:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201102174308.GF4879@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Message-ID-Hash: WZKCL5O65JVAPULYC5DV2C3FP6NJ67Z6
X-Message-ID-Hash: WZKCL5O65JVAPULYC5DV2C3FP6NJ67Z6
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <shuah@kernel.org>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, lin
 ux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WZKCL5O65JVAPULYC5DV2C3FP6NJ67Z6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

>> Assume you have a system with quite some ZONE_MOVABLE memory (esp. in
>> virtualized environments), eating up a significant amount of !ZONE_MOVABLE
>> memory dynamically at runtime can lead to non-obvious issues. It looks like
>> you have plenty of free memory, but the kernel might still OOM when trying
>> to do kernel allocations e.g., for pagetables. With CMA we at least know
>> what we're dealing with - it behaves like ZONE_MOVABLE except for the owner
>> that can place unmovable pages there. We can use it to compute statically
>> the amount of ZONE_MOVABLE memory we can have in the system without doing
>> harm to the system.
> 
> Why would you say that secretmem allocates from !ZONE_MOVABLE?
> If we put boot time reservations aside, the memory allocation for
> secretmem follows the same rules as the memory allocations for any file
> descriptor. That means we allocate memory with GFP_HIGHUSER_MOVABLE.

Oh, okay - I missed that! I had the impression that pages are unmovable 
and allocating from ZONE_MOVABLE would be a violation of that?

> After the allocation the memory indeed becomes unmovable but it's not
> like we are eating memory from other zones here.

... and here you have your problem. That's a no-no. We only allow it in 
very special cases where it can't be avoided - e.g., vfio having to pin 
guest memory when passing through memory to VMs.

Hotplug memory, online it to ZONE_MOVABLE. Allocate secretmem. Try to 
unplug the memory again -> endless loop in offline_pages().

Or have a CMA area that gets used with GFP_HIGHUSER_MOVABLE. Allocate 
secretmem. The owner of the area tries to allocate memory - always 
fails. Purpose of CMA destroyed.

> 
>> Ideally, we would want to support page migration/compaction and allow for
>> allocation from ZONE_MOVABLE as well. Would involve temporarily mapping,
>> copying, unmapping. Sounds feasible, but not sure which roadblocks we would
>> find on the way.
> 
> We can support migration/compaction with temporary mapping. The first
> roadblock I've hit there was that migration allocates 4K destination
> page and if we use it in secret map we are back to scrambling the direct
> map into 4K pieces. It still sounds feasible but not as trivial :)

That sounds like the proper way for me to do it then.

> 
> But again, there is nothing in the current form of secretmem that
> prevents allocation from ZONE_MOVABLE.

Oh, there is something: That the pages are not movable.

-- 
Thanks,

David / dhildenb
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
