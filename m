Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 825043141C1
	for <lists+linux-nvdimm@lfdr.de>; Mon,  8 Feb 2021 22:29:12 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C3D10100EAB64;
	Mon,  8 Feb 2021 13:29:10 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 48A22100EAB52
	for <linux-nvdimm@lists.01.org>; Mon,  8 Feb 2021 13:29:08 -0800 (PST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id A648464E6F;
	Mon,  8 Feb 2021 21:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1612819747;
	bh=BHP7iz8fCkGAAZDbGkYOw5wU43VUzE8VWkEzgL/I5DY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qL100s6mgIPyUjqubn6qZY/kMCsj1KEQZdirnkXADWmg0iVj7hfwIQ3IyHN4+oznZ
	 sKVq1m3+0ySh0eOSN1oIzlM8FbtudrJ3CE2DwvdNGhMPCh3lBCQg2N+kNymfamdpqT
	 XCPvnHR85Ke8iqXZ+XZTaKdCsMDq3TH8SWa1ajgh8qTJqRGpTRsgpXnc3gRC7gshD4
	 AXtH79cnaN9/ayJxdS78B84cPXS5Rtc2XoOXe9toc6RfKcnPk7iQVK9JPIdZqSYlwY
	 nUdImrFVP5JU69KSlGnPav89Q/NWipnWsKDgUR1IQOb4hc851nIVO3OzJ5l3fxoOYv
	 1GdeKPuy4OdKA==
Date: Mon, 8 Feb 2021 23:28:51 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v17 08/10] PM: hibernate: disable when there are active
 secretmem users
Message-ID: <20210208212851.GY242749@kernel.org>
References: <20210208084920.2884-1-rppt@kernel.org>
 <20210208084920.2884-9-rppt@kernel.org>
 <YCEP/bmqm0DsvCYN@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YCEP/bmqm0DsvCYN@dhcp22.suse.cz>
Message-ID-Hash: E33AUQKHL4JH2KRTDD5W77CKRDIXMPTR
X-Message-ID-Hash: E33AUQKHL4JH2KRTDD5W77CKRDIXMPTR
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho 
 Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>, Palmer Dabbelt <palmerdabbelt@google.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/E33AUQKHL4JH2KRTDD5W77CKRDIXMPTR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Feb 08, 2021 at 11:18:37AM +0100, Michal Hocko wrote:
> On Mon 08-02-21 10:49:18, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > It is unsafe to allow saving of secretmem areas to the hibernation
> > snapshot as they would be visible after the resume and this essentially
> > will defeat the purpose of secret memory mappings.
> > 
> > Prevent hibernation whenever there are active secret memory users.
> 
> Does this feature need any special handling? As it is effectivelly
> unevictable memory then it should behave the same as other mlock, ramfs
> which should already disable hibernation as those cannot be swapped out,
> no?

As David already said, hibernation does not care about mlocked memory, so
this feature requires a special handling.

-- 
Sincerely yours,
Mike.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
