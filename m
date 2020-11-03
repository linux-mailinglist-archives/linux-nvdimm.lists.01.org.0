Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FBF2A427C
	for <lists+linux-nvdimm@lfdr.de>; Tue,  3 Nov 2020 11:39:36 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 081F016544F92;
	Tue,  3 Nov 2020 02:39:34 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=tglx@linutronix.de; receiver=<UNKNOWN> 
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C3C5316544F91
	for <linux-nvdimm@lists.01.org>; Tue,  3 Nov 2020 02:39:31 -0800 (PST)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1604399966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=77FSFVw1wEgpqHD3g7fXJa5TjMy2ujnsWNKfTk4sE7Y=;
	b=y4ByPkZ0wX/QgFwS2SYrqvUfhi+sCS77ny5e6/zRNEfl+fQimC7oeuTV1T+6IbEAQgUJnE
	JJG65h6l4nL2XeDm+oJoE8RjGqhYAXoIHdcA21+wm/h0q3kQQqqcpC/WHmHUevU8Y6yvmt
	82VyaA7Km9Eqq/rkNEQGCV3isUQyprzg8wlmkFkasSKxI59fqnwgswjcHKHbSQvJtU0KD4
	E9GDY+SjTXiCgyOrhO6AfVef1UsBYvVgyd43T6o/DE9N++h+wlWpmgtg1OMhOqtXX63XIr
	pth5P7uXacHlZyXNEM7PEFIntD3Wv2/QbQVCMf8JMyfzSUIDMBQuuKgmCy4w8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1604399966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=77FSFVw1wEgpqHD3g7fXJa5TjMy2ujnsWNKfTk4sE7Y=;
	b=/YfxklNfi/VzDvGCu+aBfmlOC/O157U8w8e1tcpXRL68Wi+xM7kS6eZbwcO2BVw5bB1upO
	sj326S83253ogAAg==
To: Dan Williams <dan.j.williams@intel.com>, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] x86/mm: Fix phys_to_target_node() export
In-Reply-To: <CAPcyv4gj9ibFuBY1yt79CdKRgYAftdveXT1Ow4QvyRxri4jBRA@mail.gmail.com>
References: <160402498564.4173389.2743697400148832021.stgit@dwillia2-desk3.amr.corp.intel.com> <20201031091012.GA27844@infradead.org> <CAPcyv4gj9ibFuBY1yt79CdKRgYAftdveXT1Ow4QvyRxri4jBRA@mail.gmail.com>
Date: Tue, 03 Nov 2020 11:39:26 +0100
Message-ID: <87h7q67mht.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID-Hash: EEOKYDLLSHBFISNHFUNRQPUXK754IU2Z
X-Message-ID-Hash: EEOKYDLLSHBFISNHFUNRQPUXK754IU2Z
X-MailFrom: tglx@linutronix.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, kernel test robot <lkp@intel.com>, Joao Martins <joao.m.martins@oracle.com>, X86 ML <x86@kernel.org>, Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EEOKYDLLSHBFISNHFUNRQPUXK754IU2Z/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Nov 02 2020 at 15:52, Dan Williams wrote:
> On Sat, Oct 31, 2020 at 2:10 AM Christoph Hellwig <hch@infradead.org> wrote:
> The dependency on NUMA_KEEP_MEMINFO for DEV_DAX_HMEM_DEVICES is invalid
> now that the symbol is properly exported / stubbed in all combinations
> of CONFIG_NUMA_KEEP_MEMINFO and CONFIG_MEMORY_HOTPLUG.
>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: Thomas Gleixner <tglx@linutronix.de>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Christoph Hellwig <hch@infradead.org>
> Fixes: a035b6bf863e ("mm/memory_hotplug: introduce default phys_to_target_node() implementation")
> Cc: Joao Martins <joao.m.martins@oracle.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: x86@kernel.org
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Tested-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
