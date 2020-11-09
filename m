Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F7D2AB52C
	for <lists+linux-nvdimm@lfdr.de>; Mon,  9 Nov 2020 11:42:17 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 47AD71657B565;
	Mon,  9 Nov 2020 02:42:15 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=80.241.56.152; helo=mout-p-102.mailbox.org; envelope-from=hagen@jauu.net; receiver=<UNKNOWN> 
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A021716576B30
	for <linux-nvdimm@lists.01.org>; Mon,  9 Nov 2020 02:42:12 -0800 (PST)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4CV6xs6XHyzQkm5;
	Mon,  9 Nov 2020 11:42:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
	by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
	with ESMTP id GrIZVsje57hw; Mon,  9 Nov 2020 11:42:04 +0100 (CET)
Date: Mon, 9 Nov 2020 11:41:59 +0100 (CET)
From: Hagen Paul Pfeifer <hagen@jauu.net>
To: Mike Rapoport <rppt@kernel.org>
Message-ID: <651318720.14321.1604918519928@office.mailbox.org>
In-Reply-To: <20201104170247.GT4879@kernel.org>
References: <20200924132904.1391-1-rppt@kernel.org>
 <20201101110935.GA4105325@laniakea> <20201102154028.GD4879@kernel.org>
 <1547601988.128687.1604411534845@office.mailbox.org>
 <20201103163002.GK4879@kernel.org>
 <1988407921.138656.1604489953944@office.mailbox.org>
 <20201104170247.GT4879@kernel.org>
Subject: Re: [PATCH v6 0/6] mm: introduce memfd_secret system call to create
 "secret" memory areas
MIME-Version: 1.0
X-Priority: 3
Importance: Normal
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -3.01 / 15.00 / 15.00
X-Rspamd-Queue-Id: 2C76B177D
X-Rspamd-UID: 6438b0
Message-ID-Hash: O7K3EQKGSMBLPYILGQTJLSGSPGXIDGG6
X-Message-ID-Hash: O7K3EQKGSMBLPYILGQTJLSGSPGXIDGG6
X-MailFrom: hagen@jauu.net
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <shuah@kernel.org>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kerne
 l.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/O7K3EQKGSMBLPYILGQTJLSGSPGXIDGG6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> On 11/04/2020 6:02 PM Mike Rapoport <rppt@kernel.org> wrote:
> 
> Yes, this will work. The processes that share the memfd_secret file
> descriptor will have access to the same memory pages, pretty much like
> with shared memory.

Perfect!

Acked-by: Hagen Paul Pfeifer <hagen@jauu.net>

Thank you for the effort Mike, if zeroize feature will also included it will
be great! The memset-all-pages after use is just overkill, a dedicated flag for
memfd_secret (or mmap) would be superior.

Hagen
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
