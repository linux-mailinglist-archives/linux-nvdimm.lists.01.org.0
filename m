Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 818CD31CE1B
	for <lists+linux-nvdimm@lfdr.de>; Tue, 16 Feb 2021 17:34:43 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9A35E100ED48C;
	Tue, 16 Feb 2021 08:34:41 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id ABD89100EF271
	for <linux-nvdimm@lists.01.org>; Tue, 16 Feb 2021 08:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1613493277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KysYIYMpQ7qMwmL/JUOCOKvLfXo3jE4QCyxH618MYzE=;
	b=e43NaJ3W9UXO4sdNLmKOYLzyJ+ONZw7APOvThUMT3DJ0SSSKU/iaMn0MeDWXavyzmQ0ttA
	+xWCR55Uw84kW8AbzE1Y/zovlw42p08ExXO8N01q9IyRlgFdiXytO83xudqCTv/JzJ5CNN
	QFY+GyJxNEq3Kw5sCPAwTAz/44j2c6E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-p1-EOjkyMC-fthVSXfK3rw-1; Tue, 16 Feb 2021 11:34:33 -0500
X-MC-Unique: p1-EOjkyMC-fthVSXfK3rw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B1051E561;
	Tue, 16 Feb 2021 16:34:28 +0000 (UTC)
Received: from [10.36.114.70] (ovpn-114-70.ams2.redhat.com [10.36.114.70])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BF8E31970A;
	Tue, 16 Feb 2021 16:34:18 +0000 (UTC)
Subject: Re: [PATCH v17 07/10] mm: introduce memfd_secret system call to
 create "secret" memory areas
To: jejb@linux.ibm.com, Michal Hocko <mhocko@suse.com>
References: <20210214091954.GM242749@kernel.org>
 <052DACE9-986B-424C-AF8E-D6A4277DE635@redhat.com>
 <244f86cba227fa49ca30cd595c4e5538fe2f7c2b.camel@linux.ibm.com>
 <YCo7TqUnBdgJGkwN@dhcp22.suse.cz>
 <be1d821d3f0aec24ad13ca7126b4359822212eb0.camel@linux.ibm.com>
 <YCrJjYmr7A2nO6lA@dhcp22.suse.cz>
 <12c3890b233c8ec8e3967352001a7b72a8e0bfd0.camel@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <dfd7db5c-a8c7-0676-59f8-70aa6bcaabe7@redhat.com>
Date: Tue, 16 Feb 2021 17:34:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <12c3890b233c8ec8e3967352001a7b72a8e0bfd0.camel@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Message-ID-Hash: WTMPZTQQI676NGYMR5F37DHYWJ256J36
X-Message-ID-Hash: WTMPZTQQI676NGYMR5F37DHYWJ256J36
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Mike Rapoport <rppt@kernel.org>, Mike Rapoport <rppt@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <wil
 l@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>, Palmer Dabbelt <palmerdabbelt@google.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WTMPZTQQI676NGYMR5F37DHYWJ256J36/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 16.02.21 17:25, James Bottomley wrote:
> On Mon, 2021-02-15 at 20:20 +0100, Michal Hocko wrote:
> [...]
>>>>    What kind of flags are we talking about and why would that be a
>>>> problem with memfd_create interface? Could you be more specific
>>>> please?
>>>
>>> You mean what were the ioctl flags in the patch series linked
>>> above? They were SECRETMEM_EXCLUSIVE and SECRETMEM_UNCACHED in
>>> patch 3/5.
>>
>> OK I see. How many potential modes are we talking about? A few or
>> potentially many?
>   
> Well I initially thought there were two (uncached or not) until you
> came up with the migratable or non-migratable, which affects the
> security properties.  But now there's also potential for hardware
> backing, like mktme,  described by flags as well.  I suppose you could
> also use RDT to restrict which cache the data goes into: say L1 but not
> L2 on to lessen the impact of fully uncached (although the big thrust
> of uncached was to blunt hyperthread side channels).  So there is
> potential for quite a large expansion even though I'd be willing to bet
> that a lot of the modes people have thought about turn out not to be
> very effective in the field.

Thanks for the insight. I remember that even the "uncached" parts was 
effectively nacked by x86 maintainers (I might be wrong). For the other 
parts, the question is what we actually want to let user space configure.

Being able to specify "Very secure" "maximum secure" "average secure" 
all doesn't really make sense to me. The discussion regarding 
migratability only really popped up because this is a user-visible thing 
and not being able to migrate can be a real problem (fragmentation, 
ZONE_MOVABLE, ...).

-- 
Thanks,

David / dhildenb
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
