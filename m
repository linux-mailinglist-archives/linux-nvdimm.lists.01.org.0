Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F3230F23A
	for <lists+linux-nvdimm@lfdr.de>; Thu,  4 Feb 2021 12:34:53 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DB97A100F227A;
	Thu,  4 Feb 2021 03:34:51 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 75846100EB358
	for <linux-nvdimm@lists.01.org>; Thu,  4 Feb 2021 03:34:49 -0800 (PST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B41964F45;
	Thu,  4 Feb 2021 11:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1612438488;
	bh=kdvaYUzyR0twFNgrfjDXxc4xk/nIUc95siq77AcMxUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sy9fx25cRRyQxUg4PQiuwRqTEHX658JxHyGPHq/88My/x1kvTH4DAJ2aISoI2aXkQ
	 7q4ImT49/hSnXgZZe5nIte5an8yCdFl3/nKBSmL1KtXUQmhK86d+bWvAKpFB/hCPJ+
	 vHFmENUyT6t71Pv7oR0jOWL5QdCiNYnsM7hkVvYdNA83FthQ8MT6l5HSIaqDtEq017
	 v3Uf42+f0Hl/atXgvQESI8GiyyIE+mqMxGUZE9ZuSWQ78rGF9JCQdy6unJPKAA/OZt
	 AfPnD+C9cBVf98rjrYDltnlBiJ+vDveF6Nvs2anXspx7fDGAP1j2/zrNQYpSDiRu3a
	 P3N5VPANbVUIA==
Date: Thu, 4 Feb 2021 13:34:32 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v16 06/11] mm: introduce memfd_secret system call to
 create "secret" memory areas
Message-ID: <20210204113432.GS242749@kernel.org>
References: <20210121122723.3446-1-rppt@kernel.org>
 <20210121122723.3446-7-rppt@kernel.org>
 <YBqT/nwFpfP2EyeJ@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YBqT/nwFpfP2EyeJ@dhcp22.suse.cz>
Message-ID-Hash: 5YHN3M37R3SGKIYXM7U4TINMXENGGAZU
X-Message-ID-Hash: 5YHN3M37R3SGKIYXM7U4TINMXENGGAZU
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho 
 Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>, Palmer Dabbelt <palmerdabbelt@google.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5YHN3M37R3SGKIYXM7U4TINMXENGGAZU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Feb 03, 2021 at 01:15:58PM +0100, Michal Hocko wrote:
> On Thu 21-01-21 14:27:18, Mike Rapoport wrote:
> > +static struct file *secretmem_file_create(unsigned long flags)
> > +{
> > +	struct file *file = ERR_PTR(-ENOMEM);
> > +	struct secretmem_ctx *ctx;
> > +	struct inode *inode;
> > +
> > +	inode = alloc_anon_inode(secretmem_mnt->mnt_sb);
> > +	if (IS_ERR(inode))
> > +		return ERR_CAST(inode);
> > +
> > +	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
> > +	if (!ctx)
> > +		goto err_free_inode;
> > +
> > +	file = alloc_file_pseudo(inode, secretmem_mnt, "secretmem",
> > +				 O_RDWR, &secretmem_fops);
> > +	if (IS_ERR(file))
> > +		goto err_free_ctx;
> > +
> > +	mapping_set_unevictable(inode->i_mapping);
> 
> Btw. you need also mapping_set_gfp_mask(mapping, GFP_HIGHUSER) because
> the default is GFP_HIGHUSER_MOVABLE and you do not support migration so
> no pages from movable zones should be allowed.

Ok.

-- 
Sincerely yours,
Mike.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
