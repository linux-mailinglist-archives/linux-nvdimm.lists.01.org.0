Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F06160CFE
	for <lists+linux-nvdimm@lfdr.de>; Mon, 17 Feb 2020 09:22:05 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 705F010FC3370;
	Mon, 17 Feb 2020 00:25:20 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=tglx@linutronix.de; receiver=<UNKNOWN> 
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EB66C10FC336D
	for <linux-nvdimm@lists.01.org>; Mon, 17 Feb 2020 00:25:16 -0800 (PST)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
	by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
	(Exim 4.80)
	(envelope-from <tglx@linutronix.de>)
	id 1j3bex-0005rx-1D; Mon, 17 Feb 2020 09:21:43 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
	id 616A9100617; Mon, 17 Feb 2020 09:21:42 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Dan Williams <dan.j.williams@intel.com>, linux-nvdimm@lists.01.org
Subject: Re: [PATCH v5 4/6] x86/mm: Introduce CONFIG_NUMA_KEEP_MEMINFO
In-Reply-To: <158188326422.894464.15742054998046628934.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158188324272.894464.5941332130956525504.stgit@dwillia2-desk3.amr.corp.intel.com> <158188326422.894464.15742054998046628934.stgit@dwillia2-desk3.amr.corp.intel.com>
Date: Mon, 17 Feb 2020 09:21:42 +0100
Message-ID: <871rqtr5d5.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Message-ID-Hash: VTD4VEJE7OWLPEEQAMVVPUIZPIAWZCNC
X-Message-ID-Hash: VTD4VEJE7OWLPEEQAMVVPUIZPIAWZCNC
X-MailFrom: tglx@linutronix.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@suse.com>, Ingo Molnar <mingo@kernel.org>, hch@lst.de, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VTD4VEJE7OWLPEEQAMVVPUIZPIAWZCNC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

eviewed-by: Thomas Gleixner <tglx@linutronix.de>
Dan Williams <dan.j.williams@intel.com> writes:

> Currently x86 numa_meminfo is marked __initdata in the
> CONFIG_MEMORY_HOTPLUG=n case. In support of a new facility to allow
> drivers to map reserved memory to a 'target_node'
> (phys_to_target_node()), add support for removing the __initdata
> designation for those users. Both memory hotplug and
> phys_to_target_node() users select CONFIG_NUMA_KEEP_MEMINFO to tell the
> arch to maintain its physical address to NUMA mapping infrastructure
> post init.
>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: <x86@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Reviewed-by: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
