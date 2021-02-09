Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C5631539D
	for <lists+linux-nvdimm@lfdr.de>; Tue,  9 Feb 2021 17:17:47 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8F124100EC1CD;
	Tue,  9 Feb 2021 08:17:45 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.205.24.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EFFB7100ED482
	for <linux-nvdimm@lists.01.org>; Tue,  9 Feb 2021 08:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1612887461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rPEBUfuoE8xnXkHqh37MN3V58bCQtUE2J2aM+0+7Hhg=;
	b=Pr7mRmETPQosgzduOBZc+/626psQYjl0ekY7qCel9ZlnlzLxRONRXfhG36KG8KlwTfFo3H
	cs3ebL7AW0OfawTtiRks7QXgIEihZ/kSWQyBux/JY2Jj1neHRhgXCj9Yp7Z6HFjlpuIYHn
	3R/fqKjLQ0XpwTe64RP4HG10qbHtV44=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-uL8BkgqBNoSU9TSinWcnBQ-1; Tue, 09 Feb 2021 11:17:37 -0500
X-MC-Unique: uL8BkgqBNoSU9TSinWcnBQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9332C801979;
	Tue,  9 Feb 2021 16:17:31 +0000 (UTC)
Received: from [10.36.113.141] (ovpn-113-141.ams2.redhat.com [10.36.113.141])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D16AE60BD9;
	Tue,  9 Feb 2021 16:17:23 +0000 (UTC)
To: Michal Hocko <mhocko@suse.com>
References: <20210208211326.GV242749@kernel.org>
 <1F6A73CF-158A-4261-AA6C-1F5C77F4F326@redhat.com>
 <YCJO8zLq8YkXGy8B@dhcp22.suse.cz>
 <662b5871-b461-0896-697f-5e903c23d7b9@redhat.com>
 <YCJbmR11ikrWKaU8@dhcp22.suse.cz>
 <c1e5e7b6-3360-ddc4-2ff5-0e79515ee23a@redhat.com>
 <YCKNMqu8/g0OofqU@dhcp22.suse.cz>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH v17 00/10] mm: introduce memfd_secret system call to
 create "secret" memory areas
Message-ID: <8cbfe2c3-cfc6-72e0-bab1-852f80e20684@redhat.com>
Date: Tue, 9 Feb 2021 17:17:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <YCKNMqu8/g0OofqU@dhcp22.suse.cz>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Message-ID-Hash: OYYOBB22YIS2TYBSJ6CWPWS5N4OYMI2I
X-Message-ID-Hash: OYYOBB22YIS2TYBSJ6CWPWS5N4OYMI2I
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Ander
 sen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OYYOBB22YIS2TYBSJ6CWPWS5N4OYMI2I/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 09.02.21 14:25, Michal Hocko wrote:
> On Tue 09-02-21 11:23:35, David Hildenbrand wrote:
> [...]
>> I am constantly trying to fight for making more stuff MOVABLE instead of
>> going into the other direction (e.g., because it's easier to implement,
>> which feels like the wrong direction).
>>
>> Maybe I am the only person that really cares about ZONE_MOVABLE these days
>> :) I can't stop such new stuff from popping up, so at least I want it to be
>> documented.
> 
> MOVABLE zone is certainly an important thing to keep working. And there
> is still quite a lot of work on the way. But as I've said this is more
> of a outlier than a norm. On the other hand movable zone is kinda hard
> requirement for a lot of application and it is to be expected that
> many features will be less than 100% compatible.  Some usecases even
> impossible. That's why I am arguing that we should have a central
> document where the movable zone is documented with all the potential
> problems we have encountered over time and explicitly state which
> features are fully/partially incompatible.
> 

I'll send a mail during the next weeks to gather current restrictions to 
document them (and include my brain dump). We might see more excessive 
use of ZONE_MOVABLE in the future and as history told us, of CMA as 
well. We really should start documenting/caring.

@Mike, it would be sufficient for me if one of your patches at least 
mention the situation in the description like

"Please note that secretmem currently behaves much more like long-term 
GUP instead of mlocked memory; secretmem is unmovable memory directly 
consumed/controlled by user space. secretmem cannot be placed onto 
ZONE_MOVABLE/CMA.

As long as there is no excessive use of secretmem (e.g., maximum of 16 
MiB for selected processes) in combination with ZONE_MOVABLE/CMA, this 
is barely a real issue. However, it is something to keep in mind when a 
significant amount of system RAM might be used for secretmem. In the 
future, we might support migration of secretmem and make it look much 
more like mlocked memory instead."

Just a suggestion.

-- 
Thanks,

David / dhildenb
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
