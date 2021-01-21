Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9F32FF7D4
	for <lists+linux-nvdimm@lfdr.de>; Thu, 21 Jan 2021 23:18:34 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 98CE4100F2263;
	Thu, 21 Jan 2021 14:18:32 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DE006100F2262
	for <linux-nvdimm@lists.01.org>; Thu, 21 Jan 2021 14:18:29 -0800 (PST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0758221E5;
	Thu, 21 Jan 2021 22:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1611267509;
	bh=C4dNckswBVNDyf2CcklXwX5nrVZ+eQe+hIEyF3+YQjk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=wclvfHCCnk3OQn3T9dNFgIqWJA2vvE7RYSj7NeWYJEKVz1L0iiylb1mOqI2b9AvuI
	 K1JzZ0X26tTsjYx4KuOOb2TTAsAkOewOabuejMeC/A1Q8o0XKeQzHcJW4SRX29gzfx
	 qcSKSeI4H0IyI5So7BuOgFoGnIj4CN15OjvLZIJs=
Date: Thu, 21 Jan 2021 14:18:24 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v16 00/11] mm: introduce memfd_secret system call to
 create "secret" memory areas
Message-Id: <20210121141824.787013e7f39d168a5e945183@linux-foundation.org>
In-Reply-To: <20210121122723.3446-1-rppt@kernel.org>
References: <20210121122723.3446-1-rppt@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Message-ID-Hash: 2HZWUG6T5MVILTI2FIP47CRL26EHTFQU
X-Message-ID-Hash: 2HZWUG6T5MVILTI2FIP47CRL26EHTFQU
X-MailFrom: akpm@linux-foundation.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <wil
 l@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2HZWUG6T5MVILTI2FIP47CRL26EHTFQU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 21 Jan 2021 14:27:12 +0200 Mike Rapoport <rppt@kernel.org> wrote:

> @Andrew, this is based on v5.11-rc4-mmots-2021-01-19-13-54 with secretmem
> patches dropped from there, I can rebase whatever way you prefer.

Thanks.  I merged this version.

Silently, to avoid spraying out all those emails again ;)
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
