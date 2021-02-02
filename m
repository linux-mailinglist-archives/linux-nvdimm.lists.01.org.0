Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E91A30C17B
	for <lists+linux-nvdimm@lfdr.de>; Tue,  2 Feb 2021 15:26:45 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8CA7F100EBBD0;
	Tue,  2 Feb 2021 06:26:43 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=63.128.21.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [63.128.21.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C7D0E100EC1EC
	for <linux-nvdimm@lists.01.org>; Tue,  2 Feb 2021 06:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1612275999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nMLPtcZH7/KmKVMJT+5y5+OgkauOXmQicBP35w+Dz6g=;
	b=I7aU+zsv6zSKxTiPHj0p/BzaVTpmnTpvWd6pSQKd/VKmE3bh1b6Fs9Wyx2owDvMpW/UvJS
	2G4zBnvvHCTpXBfG+nx1SAZvAh6KuNXEtUzA5TYzCxAwGFM5oCH2pgh+wOLLHmBYJSYKw9
	RIsfLeJo/fPh8p0iM+jtFgkziyVNk2w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-PZHz8y69O96LGoGg7-J73Q-1; Tue, 02 Feb 2021 09:26:35 -0500
X-MC-Unique: PZHz8y69O96LGoGg7-J73Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34CFE9CDA3;
	Tue,  2 Feb 2021 14:26:30 +0000 (UTC)
Received: from [10.36.114.148] (ovpn-114-148.ams2.redhat.com [10.36.114.148])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C876A6EF45;
	Tue,  2 Feb 2021 14:26:21 +0000 (UTC)
Subject: Re: [PATCH v16 07/11] secretmem: use PMD-size pages to amortize
 direct map fragmentation
To: Michal Hocko <mhocko@suse.com>
References: <20210128092259.GB242749@kernel.org>
 <YBK1kqL7JA7NePBQ@dhcp22.suse.cz>
 <73738cda43236b5ac2714e228af362b67a712f5d.camel@linux.ibm.com>
 <YBPF8ETGBHUzxaZR@dhcp22.suse.cz>
 <6de6b9f9c2d28eecc494e7db6ffbedc262317e11.camel@linux.ibm.com>
 <YBkcyQsky2scjEcP@dhcp22.suse.cz> <20210202124857.GN242749@kernel.org>
 <6653288a-dd02-f9de-ef6a-e8d567d71d53@redhat.com>
 <YBlUXdwV93xMIff6@dhcp22.suse.cz>
 <211f0214-1868-a5be-9428-7acfc3b73993@redhat.com>
 <YBlgCl8MQuuII22w@dhcp22.suse.cz>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <d4fe580a-ef0e-e13f-9ee4-16fb8b6d65dd@redhat.com>
Date: Tue, 2 Feb 2021 15:26:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <YBlgCl8MQuuII22w@dhcp22.suse.cz>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Message-ID-Hash: Y2TX3CE3FH5X4GRFPXXY4GBKQUIA4GHS
X-Message-ID-Hash: Y2TX3CE3FH5X4GRFPXXY4GBKQUIA4GHS
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Mike Rapoport <rppt@kernel.org>, James Bottomley <jejb@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Ander
 sen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>, Palmer Dabbelt <palmerdabbelt@google.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/Y2TX3CE3FH5X4GRFPXXY4GBKQUIA4GHS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 02.02.21 15:22, Michal Hocko wrote:
> On Tue 02-02-21 15:12:21, David Hildenbrand wrote:
> [...]
>> I think secretmem behaves much more like longterm GUP right now
>> ("unmigratable", "lifetime controlled by user space", "cannot go on
>> CMA/ZONE_MOVABLE"). I'd either want to reasonably well control/limit it or
>> make it behave more like mlocked pages.
> 
> I thought I have already asked but I must have forgotten. Is there any
> actual reason why the memory is not movable? Timing attacks?

I think the reason is simple: no direct map, no copying of memory.

As I mentioned, we would have to temporarily map in order to copy. 
Mapping it somewhere else (like kmap), outside of the direct map might 
reduce possible attacks.

-- 
Thanks,

David / dhildenb
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
