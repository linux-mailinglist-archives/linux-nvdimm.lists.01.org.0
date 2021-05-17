Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9A338253F
	for <lists+linux-nvdimm@lfdr.de>; Mon, 17 May 2021 09:23:35 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F22C3100EB82E;
	Mon, 17 May 2021 00:23:32 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 23408100EB82C
	for <linux-nvdimm@lists.01.org>; Mon, 17 May 2021 00:23:31 -0700 (PDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E2C3611BF;
	Mon, 17 May 2021 07:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1621236207;
	bh=amReGMStusi8xn7FAECc6Whc3fPD7LuG3b6+xADdY7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tdRnG7f8obysw+K28IshiY9r+18IQ1tTvDIIZzARqpPv8mn+ML38PW74E0CX/ofM1
	 lH6pTkkY5oaht2o74BmWs/L5cRTvCHKxgeuP4jlFuWVFCF97iHrjOxSm63DzM1+DLM
	 1Lt2mIb6RklOXBbNwT8EFBOEFDI0quAKtHVOhSk40zR+fT+bXp9P4dQI/i7dt6KsqW
	 i1EeofYd4+AfTy3Bm/k+ha4JFLM3skrOayJ1PRDU9e6OwKoW/gcpiHeHcQCbsChuuw
	 eqw8dBOD6kfdNYVMzKFpdKGTDDpXVdsVBQ+yiaI5bgEAr6nOfPYGv21bcodQb5kVaQ
	 lUziwbXpWVN1w==
Date: Mon, 17 May 2021 10:23:09 +0300
From: Mike Rapoport <rppt@kernel.org>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v19 5/8] mm: introduce memfd_secret system call to create
 "secret" memory areas
Message-ID: <YKIZ3Zfai00A2O15@kernel.org>
References: <20210513184734.29317-1-rppt@kernel.org>
 <20210513184734.29317-6-rppt@kernel.org>
 <ea1ddcfa-f52d-9a7d-cb7b-8502b38a90da@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ea1ddcfa-f52d-9a7d-cb7b-8502b38a90da@redhat.com>
Message-ID-Hash: C3SHWSECOFPMD27MY7EEP7WG5L4XF4WP
X-Message-ID-Hash: C3SHWSECOFPMD27MY7EEP7WG5L4XF4WP
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Hagen Paul Pfeifer <hagen@jauu.net>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, Kees Cook <keescook@chromium.org>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Mark Rutland <mark.rutland@arm.com>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Palmer Dabbelt <palmerdabbelt@google.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net
 >, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, Yury Norov <yury.norov@gmail.com>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/C3SHWSECOFPMD27MY7EEP7WG5L4XF4WP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, May 14, 2021 at 10:50:55AM +0200, David Hildenbrand wrote:
> On 13.05.21 20:47, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > Removing of the pages from the direct map may cause its fragmentation
> > on architectures that use large pages to map the physical memory
> > which affects the system performance. However, the original Kconfig
> > text for CONFIG_DIRECT_GBPAGES said that gigabyte pages in the direct
> > map "... can improve the kernel's performance a tiny bit ..." (commit
> > 00d1c5e05736 ("x86: add gbpages switches")) and the recent report [1]
> > showed that "... although 1G mappings are a good default choice,
> > there is no compelling evidence that it must be the only choice".
> > Hence, it is sufficient to have secretmem disabled by default with
> > the ability of a system administrator to enable it at boot time.
> 
> Maybe add a link to the Intel performance evaluation.
 
" ... the recent report [1]" and the link below.
 
> > Pages in the secretmem regions are unevictable and unmovable to
> > avoid accidental exposure of the sensitive data via swap or during
> > page migration.
 
...

> > A page that was a part of the secret memory area is cleared when it
> > is freed to ensure the data is not exposed to the next user of that
> > page.
> 
> You could skip that with init_on_free (and eventually also with
> init_on_alloc) set to avoid double clearing.

Right, but for now I'd prefer to keep this explicit in the secretmem
implementation. We may add the check for init_on_free/init_on_alloc later
on.


> > [1]
> > https://lore.kernel.org/linux-mm/213b4567-46ce-f116-9cdf-bbd0c884eb3c@linux.intel.com/
> 

-- 
Sincerely yours,
Mike.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
