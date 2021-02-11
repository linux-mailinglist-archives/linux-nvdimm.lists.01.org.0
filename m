Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEB6319654
	for <lists+linux-nvdimm@lfdr.de>; Fri, 12 Feb 2021 00:09:39 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A12A0100EA2D0;
	Thu, 11 Feb 2021 15:09:36 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1036A100EA2CF
	for <linux-nvdimm@lists.01.org>; Thu, 11 Feb 2021 15:09:34 -0800 (PST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id F14AF64DF3;
	Thu, 11 Feb 2021 23:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1613084973;
	bh=5lHiqnqqzqNi5/OSSDr9bdxtAGi+3a9C3En/9Cfu+Ss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KdQTRQFGFCn97Jxdu/WPirdvPSClIiQe3eCuboHTtWi+7E6/HzcS9qnWDJfg5uDFN
	 ZY5PuEAEMXaKZcGprf7SdyWk9I93Lln3hFbxMp/KrXIzze9mx092L3Jh7i5UxEbimS
	 cejoByXzKhnjLnxouWOf/ewU3WweBYFzmyuAwZ+NBMVNgyCt3ntX2Xw6TB28PoSs4H
	 mwoZV1kJ8Ervt9UJn0zr12hQYhd+uIYZ9COxTA7mUSvHvGQIa7oorM8qITwmhhkYJK
	 xRQGEMhSjFJwWRNKbKOuAa8QLAh9zI5u11sQAct0mWsv9haX/Z+R9q39gWv4lXPETF
	 dH+b9ZCWAtkuQ==
Date: Fri, 12 Feb 2021 01:09:10 +0200
From: Mike Rapoport <rppt@kernel.org>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v17 07/10] mm: introduce memfd_secret system call to
 create "secret" memory areas
Message-ID: <20210211230910.GL242749@kernel.org>
References: <YCEXMgXItY7xMbIS@dhcp22.suse.cz>
 <20210208212605.GX242749@kernel.org>
 <YCJMDBss8Qhha7g9@dhcp22.suse.cz>
 <20210209090938.GP299309@linux.ibm.com>
 <YCKLVzBR62+NtvyF@dhcp22.suse.cz>
 <20210211071319.GF242749@kernel.org>
 <YCTtSrCEvuBug2ap@dhcp22.suse.cz>
 <0d66baec-1898-987b-7eaf-68a015c027ff@redhat.com>
 <20210211112702.GI242749@kernel.org>
 <05082284-bd85-579f-2b3e-9b1af663eb6f@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <05082284-bd85-579f-2b3e-9b1af663eb6f@redhat.com>
Message-ID-Hash: KWE5HILJ7NNQ2DWRMWNJOBC6V2ZOJDFE
X-Message-ID-Hash: KWE5HILJ7NNQ2DWRMWNJOBC6V2ZOJDFE
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Anders
 en <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>, Palmer Dabbelt <palmerdabbelt@google.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KWE5HILJ7NNQ2DWRMWNJOBC6V2ZOJDFE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Feb 11, 2021 at 01:07:10PM +0100, David Hildenbrand wrote:
> On 11.02.21 12:27, Mike Rapoport wrote:
> > On Thu, Feb 11, 2021 at 10:01:32AM +0100, David Hildenbrand wrote:
> 
> So let's talk about the main user-visible differences to other memfd files
> (especially, other purely virtual files like hugetlbfs). With secretmem:
> 
> - File content can only be read/written via memory mappings.
> - File content cannot be swapped out.
> 
> I think there are still valid ways to modify file content using syscalls:
> e.g., fallocate(PUNCH_HOLE). Things like truncate also seems to work just
> fine.
 
These work perfectly with any file, so maybe we should have added
memfd_create as a flag to open(2) back then and now the secretmem file
descriptors?
 
> > > AFAIKS, we would need MFD_SECRET and disallow
> > > MFD_ALLOW_SEALING and MFD_HUGETLB.
> > 
> > So here we start to multiplex.
> 
> Yes. And as Michal said, maybe we can support combinations in the future.

Isn't there a general agreement that syscall multiplexing is not a good
thing?
memfd_create already has flags validation that does not look very nice.
Adding there only MFD_SECRET will make it a bit less nice, but when we'll
grow new functionality into secretmem that will become horrible.
 
-- 
Sincerely yours,
Mike.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
