Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B7F29A647
	for <lists+linux-nvdimm@lfdr.de>; Tue, 27 Oct 2020 09:12:49 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E301B161C8E4C;
	Tue, 27 Oct 2020 01:12:47 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.205.24.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A7DC4161C8E49
	for <linux-nvdimm@lists.01.org>; Tue, 27 Oct 2020 01:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1603786363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NAcngyuptikvYGGpjHccIA10XCuP57p7z320i7MuxeE=;
	b=Cp1perTca7ew4Y15f97Qo81wQNADEPhZ6yXBDF3VvkfvdqAHKFpPKtIy8S6v2QyW0lx83F
	CFgeHJVpctAuEsaKDo9uw6F2j+3jrsoMcYdMCalgWEra+pqpDFH6rvb14DAAu6xl7P0uHo
	BzGGZlpcEiBUb2DtvRxgA/zaqMOsD7c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-Q8AvrUgQOMaVTr9oXfijqA-1; Tue, 27 Oct 2020 04:12:38 -0400
X-MC-Unique: Q8AvrUgQOMaVTr9oXfijqA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1338664085;
	Tue, 27 Oct 2020 08:12:33 +0000 (UTC)
Received: from [10.36.113.185] (ovpn-113-185.ams2.redhat.com [10.36.113.185])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AB67E5B4B3;
	Tue, 27 Oct 2020 08:12:24 +0000 (UTC)
Subject: Re: [PATCH v7 3/7] set_memory: allow set_direct_map_*_noflush() for
 multiple pages
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "rppt@kernel.org" <rppt@kernel.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>
References: <20201026083752.13267-1-rppt@kernel.org>
 <20201026083752.13267-4-rppt@kernel.org>
 <e754ae3873e02e398e58091d586fe57e105803db.camel@intel.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <9202c4c1-9f1f-175f-0a85-fc8c30bc5e3b@redhat.com>
Date: Tue, 27 Oct 2020 09:12:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <e754ae3873e02e398e58091d586fe57e105803db.camel@intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Message-ID-Hash: WPKCAXRGNKJ4PXABAG2BNFH2TUATMFRZ
X-Message-ID-Hash: WPKCAXRGNKJ4PXABAG2BNFH2TUATMFRZ
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "tycho@tycho.ws" <tycho@tycho.ws>, "cl@linux.com" <cl@linux.com>, "hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org" <peterz@infradead.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "will@kernel.org" <will@kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "kirill@shutemov.name" <kirill@shutemov.name>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "rppt@linux.ibm.com" <rppt@linux.ibm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>, "willy@infradead.org" <willy@infradead.org>, "luto@kernel.org" <luto@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "shuah@kernel.org" <shuah@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "x86@kernel.org" <x86@kernel.
 org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "Reshetova, Elena" <elena.reshetova@intel.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>, "mingo@redhat.com" <mingo@redhat.com>, "mtk.manpages@gmail.com" <mtk.manpages@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "jejb@linux.ibm.com" <jejb@linux.ibm.com>, "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WPKCAXRGNKJ4PXABAG2BNFH2TUATMFRZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 26.10.20 20:01, Edgecombe, Rick P wrote:
> On Mon, 2020-10-26 at 10:37 +0200, Mike Rapoport wrote:
>> +++ b/arch/x86/mm/pat/set_memory.c
>> @@ -2184,14 +2184,14 @@ static int __set_pages_np(struct page *page,
>> int numpages)
>>         return __change_page_attr_set_clr(&cpa, 0);
>>  }
>>  
>> -int set_direct_map_invalid_noflush(struct page *page)
>> +int set_direct_map_invalid_noflush(struct page *page, int numpages)
>>  {
>> -       return __set_pages_np(page, 1);
>> +       return __set_pages_np(page, numpages);
>>  }
>>  
>> -int set_direct_map_default_noflush(struct page *page)
>> +int set_direct_map_default_noflush(struct page *page, int numpages)
>>  {
>> -       return __set_pages_p(page, 1);
>> +       return __set_pages_p(page, numpages);
>>  }
> 
> Somewhat related to your other series, this could result in large NP
> pages and trip up hibernate.
> 

It feels somewhat desirable to disable hibernation once secretmem is
enabled, right? Otherwise you'll be writing out your secrets to swap,
where they will remain even after booting up again ...

Skipping secretmem pages when hibernating is the wrong approach I guess ...

-- 
Thanks,

David / dhildenb
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
