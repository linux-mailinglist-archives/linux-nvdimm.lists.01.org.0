Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4312A2711
	for <lists+linux-nvdimm@lfdr.de>; Mon,  2 Nov 2020 10:31:31 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 76D0216201ADE;
	Mon,  2 Nov 2020 01:31:29 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.205.24.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2A5B616201AD7
	for <linux-nvdimm@lists.01.org>; Mon,  2 Nov 2020 01:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1604309486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o+m0mtfbnYwB+7o3eCQVGYITMN3Bzgb+rUtRGnSkpQU=;
	b=QO86cJeEOyLDcuyFZkIcnjGZuo+wx8I8wv6dBZjpKlbJFcd45l5F7pdGPPkDxEzH0bMbYm
	JcG/9J+nyh8ChPurTq8IQz5OJU6pMisH5zz2DC5yyHhBlhsbUu6cqonopXZZoVqyiVW5w1
	E+rt7tczLzoVVMvDV6LopYGaBldtjaw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-xXcE_EO7NHiRYqvQ1uKZrQ-1; Mon, 02 Nov 2020 04:31:21 -0500
X-MC-Unique: xXcE_EO7NHiRYqvQ1uKZrQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C795107AFD3;
	Mon,  2 Nov 2020 09:31:17 +0000 (UTC)
Received: from [10.36.113.163] (ovpn-113-163.ams2.redhat.com [10.36.113.163])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 752BE6EF5A;
	Mon,  2 Nov 2020 09:31:10 +0000 (UTC)
Subject: Re: [PATCH v6 0/6] mm: introduce memfd_secret system call to create
 "secret" memory areas
From: David Hildenbrand <david@redhat.com>
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
References: <20200924132904.1391-1-rppt@kernel.org>
 <9c38ac3b-c677-6a87-ce82-ec53b69eaf71@redhat.com>
Organization: Red Hat GmbH
Message-ID: <0f095c22-4a3a-3213-a853-c1c859c357e2@redhat.com>
Date: Mon, 2 Nov 2020 10:31:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <9c38ac3b-c677-6a87-ce82-ec53b69eaf71@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Message-ID-Hash: 6Q4C4AD2DUIBELSBMPS7Q23O5NGU3UJP
X-Message-ID-Hash: 6Q4C4AD2DUIBELSBMPS7Q23O5NGU3UJP
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <shuah@kernel.org>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fs
 devel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6Q4C4AD2DUIBELSBMPS7Q23O5NGU3UJP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 02.11.20 10:11, David Hildenbrand wrote:
> On 24.09.20 15:28, Mike Rapoport wrote:
>> From: Mike Rapoport <rppt@linux.ibm.com>
>>
>> Hi,
>>
>> This is an implementation of "secret" mappings backed by a file descriptor.
>> I've dropped the boot time reservation patch for now as it is not strictly
>> required for the basic usage and can be easily added later either with or
>> without CMA.
> 
> Hi Mike,
> 
> I'd like to stress again that I'd prefer *any* secretmem allocations
> going via CMA as long as these pages are unmovable. The user can
> allocate a non-significant amount of unmovable allocations only fenced

lol, "non-neglectable" or "significant". Guess I need another coffee :)


-- 
Thanks,

David / dhildenb
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
