Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7827D2A4153
	for <lists+linux-nvdimm@lfdr.de>; Tue,  3 Nov 2020 11:12:16 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D303016522D91;
	Tue,  3 Nov 2020 02:12:14 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=63.128.21.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [63.128.21.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 79130164FEE46
	for <linux-nvdimm@lists.01.org>; Tue,  3 Nov 2020 02:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1604398329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OyipNVQSi+6EWMMakyEP0aw5V3oxIqNV8RP/zduqoUw=;
	b=GNa/9Cygvl4mUZcGn7V7OtWZ6w8d4PuD4m+FHGDrOVFBMKqurcOe9YTmT0AQ+yZNSJjHk3
	Vra/tNN+2dbcnohmTsjObAJiPL40+W45ireLES3gNXRyBu5KSfPCWAdaigxIEP5m5hQSWO
	lmbviLNsQlNizkBtTFZ/0RqbcYir2mY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-LbFmUSJyMSGOd-g7tICDgg-1; Tue, 03 Nov 2020 05:12:05 -0500
X-MC-Unique: LbFmUSJyMSGOd-g7tICDgg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B23E186840C;
	Tue,  3 Nov 2020 10:12:00 +0000 (UTC)
Received: from [10.36.115.7] (ovpn-115-7.ams2.redhat.com [10.36.115.7])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 771815D9CC;
	Tue,  3 Nov 2020 10:11:52 +0000 (UTC)
Subject: Re: [PATCH v6 0/6] mm: introduce memfd_secret system call to create
 "secret" memory areas
To: Mike Rapoport <rppt@kernel.org>
References: <20200924132904.1391-1-rppt@kernel.org>
 <9c38ac3b-c677-6a87-ce82-ec53b69eaf71@redhat.com>
 <20201102174308.GF4879@kernel.org>
 <d4cb2c87-4744-3929-cedd-2be78625a741@redhat.com>
 <20201103095247.GH4879@kernel.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <5709dadf-81c6-5b40-93d4-fbef94d5aad8@redhat.com>
Date: Tue, 3 Nov 2020 11:11:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201103095247.GH4879@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Message-ID-Hash: SSTADCO67O5U77OECFWV4JRM3776HZAS
X-Message-ID-Hash: SSTADCO67O5U77OECFWV4JRM3776HZAS
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <shuah@kernel.org>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, lin
 ux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SSTADCO67O5U77OECFWV4JRM3776HZAS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 03.11.20 10:52, Mike Rapoport wrote:
> On Mon, Nov 02, 2020 at 06:51:09PM +0100, David Hildenbrand wrote:
>>>> Assume you have a system with quite some ZONE_MOVABLE memory (esp. in
>>>> virtualized environments), eating up a significant amount of !ZONE_MOVABLE
>>>> memory dynamically at runtime can lead to non-obvious issues. It looks like
>>>> you have plenty of free memory, but the kernel might still OOM when trying
>>>> to do kernel allocations e.g., for pagetables. With CMA we at least know
>>>> what we're dealing with - it behaves like ZONE_MOVABLE except for the owner
>>>> that can place unmovable pages there. We can use it to compute statically
>>>> the amount of ZONE_MOVABLE memory we can have in the system without doing
>>>> harm to the system.
>>>
>>> Why would you say that secretmem allocates from !ZONE_MOVABLE?
>>> If we put boot time reservations aside, the memory allocation for
>>> secretmem follows the same rules as the memory allocations for any file
>>> descriptor. That means we allocate memory with GFP_HIGHUSER_MOVABLE.
>>
>> Oh, okay - I missed that! I had the impression that pages are unmovable and
>> allocating from ZONE_MOVABLE would be a violation of that?
>>
>>> After the allocation the memory indeed becomes unmovable but it's not
>>> like we are eating memory from other zones here.
>>
>> ... and here you have your problem. That's a no-no. We only allow it in very
>> special cases where it can't be avoided - e.g., vfio having to pin guest
>> memory when passing through memory to VMs.
>>
>> Hotplug memory, online it to ZONE_MOVABLE. Allocate secretmem. Try to unplug
>> the memory again -> endless loop in offline_pages().
>>
>> Or have a CMA area that gets used with GFP_HIGHUSER_MOVABLE. Allocate
>> secretmem. The owner of the area tries to allocate memory - always fails.
>> Purpose of CMA destroyed.
>>
>>>
>>>> Ideally, we would want to support page migration/compaction and allow for
>>>> allocation from ZONE_MOVABLE as well. Would involve temporarily mapping,
>>>> copying, unmapping. Sounds feasible, but not sure which roadblocks we would
>>>> find on the way.
>>>
>>> We can support migration/compaction with temporary mapping. The first
>>> roadblock I've hit there was that migration allocates 4K destination
>>> page and if we use it in secret map we are back to scrambling the direct
>>> map into 4K pieces. It still sounds feasible but not as trivial :)
>>
>> That sounds like the proper way for me to do it then.
>   
> Although migration of secretmem pages sounds feasible now, there maybe
> other issues I didn't see because I'm not very familiar with
> migration/compaction code.

Migration of PMDs might also be feasible -  and it would be even 
cleaner. But I agree that that might require more work and starting with 
something simpler (!movable) is the right way to move forward.

-- 
Thanks,

David / dhildenb
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
