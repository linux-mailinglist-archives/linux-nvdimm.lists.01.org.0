Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7225D30F235
	for <lists+linux-nvdimm@lfdr.de>; Thu,  4 Feb 2021 12:32:07 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 858AD100EBB9D;
	Thu,  4 Feb 2021 03:32:05 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8C9C4100EBB68
	for <linux-nvdimm@lists.01.org>; Thu,  4 Feb 2021 03:32:03 -0800 (PST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id B8D5A64F43;
	Thu,  4 Feb 2021 11:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1612438323;
	bh=2YjywL5SDoEOedQJhLkpDYn35JOZkPUsSSTuGmTvbGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kfyPb2gRQK0VJ0bG96IqzhK4wj3EQuLqLz846zpApxcBwm6WX5CtQsTqXRtAiettV
	 Besll6N47ziUztkxZ9uvbAsAManAgkDNtO1dfWhHGfCVtc763gwDqZuV/PJHM4amXe
	 NzZHR6+dZdeHxPTLxYHYjwbMQNb3w6QbyNiepEAxlD0e9d57gxLWScwoHeMOz0zzxT
	 Vme4kodJtOqIlDuUlby8EOucFxgZASr9qI2lvWzc7i6T1yxSrrhOjO19hjpFL65gQr
	 YqgO9vVlRT1CTjfaXTK0DGlZqxa/k2Qn7Vs36jPxV0PXtDTyFjDcxi+38fcdf2VRVr
	 ganUhejqO/Vig==
Date: Thu, 4 Feb 2021 13:31:45 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v16 07/11] secretmem: use PMD-size pages to amortize
 direct map fragmentation
Message-ID: <20210204113145.GR242749@kernel.org>
References: <6653288a-dd02-f9de-ef6a-e8d567d71d53@redhat.com>
 <YBlUXdwV93xMIff6@dhcp22.suse.cz>
 <211f0214-1868-a5be-9428-7acfc3b73993@redhat.com>
 <YBlgCl8MQuuII22w@dhcp22.suse.cz>
 <d4fe580a-ef0e-e13f-9ee4-16fb8b6d65dd@redhat.com>
 <YBlicIupOyPF9f3D@dhcp22.suse.cz>
 <95625b83-f7e2-b27a-2b99-d231338047fb@redhat.com>
 <20210202181546.GO242749@kernel.org>
 <f26a17366194880d58e67d10cb5d7d7fdf2f3c19.camel@linux.ibm.com>
 <YBqSejZ3XbUKFudR@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YBqSejZ3XbUKFudR@dhcp22.suse.cz>
Message-ID-Hash: LPMFK72C3FQ5GGUEK6XQAXQF3ZB3ZXCN
X-Message-ID-Hash: LPMFK72C3FQ5GGUEK6XQAXQF3ZB3ZXCN
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: James Bottomley <jejb@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho 
 Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>, Palmer Dabbelt <palmerdabbelt@google.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LPMFK72C3FQ5GGUEK6XQAXQF3ZB3ZXCN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Feb 03, 2021 at 01:09:30PM +0100, Michal Hocko wrote:
> On Tue 02-02-21 10:55:40, James Bottomley wrote:
> > On Tue, 2021-02-02 at 20:15 +0200, Mike Rapoport wrote:
> > > On Tue, Feb 02, 2021 at 03:34:29PM +0100, David Hildenbrand wrote:
> > > > On 02.02.21 15:32, Michal Hocko wrote:
> > 
> > Well the safest security statement is that we never expose the data to
> > the kernel because it's a very clean security statement and easy to
> > enforce. It's also the easiest threat model to analyse.   Once we do
> > start exposing the secret to the kernel it alters the threat profile
> > and the analysis and obviously potentially provides the ROP gadget to
> > an attacker to do the same. Instinct tells me that the loss of
> > security doesn't really make up for the ability to swap or migrate but
> > if there were a case for doing the latter, it would have to be a
> > security policy of the user (i.e. a user should be able to decide their
> > data is too sensitive to expose to the kernel).
> 
> The security/threat model should be documented in the changelog as
> well. I am not a security expert but I would tend to agree that not
> allowing even temporal mapping for data copying (in the kernel) is the
> most robust approach. Whether that is generally necessary for users I do
> not know.
> 
> From the API POV I think it makes sense to have two
> modes. NEVER_MAP_IN_KERNEL which would imply no migrateability, no
> copy_{from,to}_user, no gup or any other way for the kernel to access
> content of the memory. Maybe even zero the content on the last unmap to
> never allow any data leak. ALLOW_TEMPORARY would unmap the page from
> the direct mapping but it would still allow temporary mappings for
> data copying inside the kernel (thus allow CoW, copy*user, migration).
> Which one should be default and which an opt-in I do not know. A less
> restrictive mode to be default and the more restrictive an opt-in via
> flags makes a lot of sense to me though.

The default is already NEVER_MAP_IN_KERNEL, so there is no explicit flag
for this. ALLOW_TEMPORARY should be opt-in, IMHO, and we can add it on top
later on.

-- 
Sincerely yours,
Mike.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
