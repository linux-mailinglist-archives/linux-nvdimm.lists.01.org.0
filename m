Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2442C31501B
	for <lists+linux-nvdimm@lfdr.de>; Tue,  9 Feb 2021 14:25:13 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5D052100EAB5F;
	Tue,  9 Feb 2021 05:25:11 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=mhocko@suse.com; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A9348100EC1C4
	for <linux-nvdimm@lists.01.org>; Tue,  9 Feb 2021 05:25:08 -0800 (PST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1612877107; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZVdQYAWpX2uS4c8GuGsp90KbxvIcZCLSEozx0GHShkA=;
	b=AMu2gqbj/4bFKubqIvA00x5aKR/RM0bxKuI5rFq/VIF9xzAE5jv4eYLmgTbusqtjFAY5Df
	Aox1zELPhI/1rzb/LrFIULNqnHdWSAlWT1TNgH3OziiDEXT769CiOawfnAmhijx6/V4k/9
	8MT4wMa2DixXuIxBTpeQxrZHRPB3LL4=
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id 0E7E2AD6A;
	Tue,  9 Feb 2021 13:25:07 +0000 (UTC)
Date: Tue, 9 Feb 2021 14:25:06 +0100
From: Michal Hocko <mhocko@suse.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v17 00/10] mm: introduce memfd_secret system call to
 create "secret" memory areas
Message-ID: <YCKNMqu8/g0OofqU@dhcp22.suse.cz>
References: <20210208211326.GV242749@kernel.org>
 <1F6A73CF-158A-4261-AA6C-1F5C77F4F326@redhat.com>
 <YCJO8zLq8YkXGy8B@dhcp22.suse.cz>
 <662b5871-b461-0896-697f-5e903c23d7b9@redhat.com>
 <YCJbmR11ikrWKaU8@dhcp22.suse.cz>
 <c1e5e7b6-3360-ddc4-2ff5-0e79515ee23a@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c1e5e7b6-3360-ddc4-2ff5-0e79515ee23a@redhat.com>
Message-ID-Hash: 33I7JHFAM6VRPDT3TJGCRWZ6SCFVX3IZ
X-Message-ID-Hash: 33I7JHFAM6VRPDT3TJGCRWZ6SCFVX3IZ
X-MailFrom: mhocko@suse.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Ander
 sen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/33I7JHFAM6VRPDT3TJGCRWZ6SCFVX3IZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue 09-02-21 11:23:35, David Hildenbrand wrote:
[...]
> I am constantly trying to fight for making more stuff MOVABLE instead of
> going into the other direction (e.g., because it's easier to implement,
> which feels like the wrong direction).
> 
> Maybe I am the only person that really cares about ZONE_MOVABLE these days
> :) I can't stop such new stuff from popping up, so at least I want it to be
> documented.

MOVABLE zone is certainly an important thing to keep working. And there
is still quite a lot of work on the way. But as I've said this is more
of a outlier than a norm. On the other hand movable zone is kinda hard
requirement for a lot of application and it is to be expected that
many features will be less than 100% compatible.  Some usecases even
impossible. That's why I am arguing that we should have a central
document where the movable zone is documented with all the potential
problems we have encountered over time and explicitly state which
features are fully/partially incompatible.

-- 
Michal Hocko
SUSE Labs
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
