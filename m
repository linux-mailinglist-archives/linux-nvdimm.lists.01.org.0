Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A1F312FDA
	for <lists+linux-nvdimm@lfdr.de>; Mon,  8 Feb 2021 11:57:10 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 82EB0100EB339;
	Mon,  8 Feb 2021 02:57:09 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=mhocko@suse.com; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8297C100EB323
	for <linux-nvdimm@lists.01.org>; Mon,  8 Feb 2021 02:57:07 -0800 (PST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1612781826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZIZtK7KGQOpq2x4SzJLMBFITOVmfiRO9HVwMLT9AWfk=;
	b=WpbjzGZc+3/YkHH1uGy0eGbUYo8oCacDxNQEQtRXANwZxHwtylTb3HKk6I403Q7833wHJ8
	aLnM/cCkpwLJswRwURhqmjTvVUu01dIEr0vSyMIJGgoFeM+JOYdLAc7kCdZvfbthq/oS41
	xyqZWWQ3VtQBnKDUYpZPwfTqaSytqRw=
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id E729BAC6E;
	Mon,  8 Feb 2021 10:57:05 +0000 (UTC)
Date: Mon, 8 Feb 2021 11:57:05 +0100
From: Michal Hocko <mhocko@suse.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v17 08/10] PM: hibernate: disable when there are active
 secretmem users
Message-ID: <YCEZAWOv63KYglJZ@dhcp22.suse.cz>
References: <20210208084920.2884-1-rppt@kernel.org>
 <20210208084920.2884-9-rppt@kernel.org>
 <YCEP/bmqm0DsvCYN@dhcp22.suse.cz>
 <38c0cad4-ac55-28e4-81c6-4e0414f0620a@redhat.com>
 <YCEXwUYepeQvEWTf@dhcp22.suse.cz>
 <a488a0bb-def5-0249-99e2-4643787cef69@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a488a0bb-def5-0249-99e2-4643787cef69@redhat.com>
Message-ID-Hash: TLX4FDBWSZVUKDNSGMXVPTR3JLHGAJS4
X-Message-ID-Hash: TLX4FDBWSZVUKDNSGMXVPTR3JLHGAJS4
X-MailFrom: mhocko@suse.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Ander
 sen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>, Palmer Dabbelt <palmerdabbelt@google.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TLX4FDBWSZVUKDNSGMXVPTR3JLHGAJS4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon 08-02-21 11:53:58, David Hildenbrand wrote:
> On 08.02.21 11:51, Michal Hocko wrote:
> > On Mon 08-02-21 11:32:11, David Hildenbrand wrote:
> > > On 08.02.21 11:18, Michal Hocko wrote:
> > > > On Mon 08-02-21 10:49:18, Mike Rapoport wrote:
> > > > > From: Mike Rapoport <rppt@linux.ibm.com>
> > > > > 
> > > > > It is unsafe to allow saving of secretmem areas to the hibernation
> > > > > snapshot as they would be visible after the resume and this essentially
> > > > > will defeat the purpose of secret memory mappings.
> > > > > 
> > > > > Prevent hibernation whenever there are active secret memory users.
> > > > 
> > > > Does this feature need any special handling? As it is effectivelly
> > > > unevictable memory then it should behave the same as other mlock, ramfs
> > > > which should already disable hibernation as those cannot be swapped out,
> > > > no?
> > > > 
> > > 
> > > Why should unevictable memory not go to swap when hibernating? We're merely
> > > dumping all of our system RAM (including any unmovable allocations) to swap
> > > storage and the system is essentially completely halted.
> > > 
> > My understanding is that mlock is never really made visible via swap
> > storage.
> 
> "Using swap storage for hibernation" and "swapping at runtime" are two
> different things. I might be wrong, though.

Well, mlock is certainly used to keep sensitive information, not only to
protect from major/minor faults.
-- 
Michal Hocko
SUSE Labs
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
