Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 784DE321F1F
	for <lists+linux-nvdimm@lfdr.de>; Mon, 22 Feb 2021 19:27:25 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DFA85100EB842;
	Mon, 22 Feb 2021 10:27:22 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=176.126.240.207; helo=cavan.codon.org.uk; envelope-from=mjg59@codon.org.uk; receiver=<UNKNOWN> 
Received: from cavan.codon.org.uk (cavan.codon.org.uk [176.126.240.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CB2DE100EB831
	for <linux-nvdimm@lists.01.org>; Mon, 22 Feb 2021 10:27:20 -0800 (PST)
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
	id 2000340A21; Mon, 22 Feb 2021 18:27:18 +0000 (UTC)
Date: Mon, 22 Feb 2021 18:27:18 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v17 08/10] PM: hibernate: disable when there are active
 secretmem users
Message-ID: <20210222182718.GA15105@codon.org.uk>
References: <20210208084920.2884-1-rppt@kernel.org>
 <20210208084920.2884-9-rppt@kernel.org>
 <20210222073452.GA30403@codon.org.uk>
 <20210222102359.GE1447004@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210222102359.GE1447004@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: KF5C5BPBMZB4DIFVJN5WPONXUBBPKNQB
X-Message-ID-Hash: KF5C5BPBMZB4DIFVJN5WPONXUBBPKNQB
X-MailFrom: mjg59@codon.org.uk
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleix
 ner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>, Palmer Dabbelt <palmerdabbelt@google.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KF5C5BPBMZB4DIFVJN5WPONXUBBPKNQB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Feb 22, 2021 at 12:23:59PM +0200, Mike Rapoport wrote:
> On Mon, Feb 22, 2021 at 07:34:52AM +0000, Matthew Garrett wrote:
> > On Mon, Feb 08, 2021 at 10:49:18AM +0200, Mike Rapoport wrote:
> > 
> > > It is unsafe to allow saving of secretmem areas to the hibernation
> > > snapshot as they would be visible after the resume and this essentially
> > > will defeat the purpose of secret memory mappings.
> > 
> > Sorry for being a bit late to this - from the point of view of running
> > processes (and even the kernel once resume is complete), hibernation is
> > effectively equivalent to suspend to RAM. Why do they need to be handled
> > differently here?
> 
> Hibernation leaves a copy of the data on the disk which we want to prevent.

Who are you worried about seeing it, and at what points in time?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
