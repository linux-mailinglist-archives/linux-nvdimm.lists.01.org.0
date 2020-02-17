Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14048160D1E
	for <lists+linux-nvdimm@lfdr.de>; Mon, 17 Feb 2020 09:23:17 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 982E810FC3373;
	Mon, 17 Feb 2020 00:26:32 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=tglx@linutronix.de; receiver=<UNKNOWN> 
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3E4E010FC3370
	for <linux-nvdimm@lists.01.org>; Mon, 17 Feb 2020 00:26:22 -0800 (PST)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
	by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
	(Exim 4.80)
	(envelope-from <tglx@linutronix.de>)
	id 1j3bg9-0005ux-16; Mon, 17 Feb 2020 09:22:57 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
	id 91A8C100617; Mon, 17 Feb 2020 09:22:56 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Dan Williams <dan.j.williams@intel.com>, linux-nvdimm@lists.01.org
Subject: Re: [PATCH v5 5/6] x86/NUMA: Provide a range-to-target_node lookup facility
In-Reply-To: <158188326978.894464.217282995221175417.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158188324272.894464.5941332130956525504.stgit@dwillia2-desk3.amr.corp.intel.com> <158188326978.894464.217282995221175417.stgit@dwillia2-desk3.amr.corp.intel.com>
Date: Mon, 17 Feb 2020 09:22:56 +0100
Message-ID: <87y2t1pqqn.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Message-ID-Hash: BN7T3FJIVLKLRONYYW4OTYNGGUNOMKYJ
X-Message-ID-Hash: BN7T3FJIVLKLRONYYW4OTYNGGUNOMKYJ
X-MailFrom: tglx@linutronix.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@suse.com>, kbuild test robot <lkp@intel.com>, Ingo Molnar <mingo@kernel.org>, hch@lst.de, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BN7T3FJIVLKLRONYYW4OTYNGGUNOMKYJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dan Williams <dan.j.williams@intel.com> writes:

> The DEV_DAX_KMEM facility is a generic mechanism to allow device-dax
> instances, fronting performance-differentiated-memory like pmem, to be
> added to the System RAM pool. The NUMA node for that hot-added memory is
> derived from the device-dax instance's 'target_node' attribute.
>
> Recall that the 'target_node' is the ACPI-PXM-to-node translation for
> memory when it comes online whereas the 'numa_node' attribute of the
> device represents the closest online cpu node.
>
> Presently useful target_node information from the ACPI SRAT is discarded
> with the expectation that "Reserved" memory will never be onlined. Now,
> DEV_DAX_KMEM violates that assumption, there is a need to retain the
> translation. Move, rather than discard, numa_memblk data to a secondary
> array that memory_add_physaddr_to_target_node() may consider at a later
> point in time.
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
> Reported-by: kbuild test robot <lkp@intel.com>
> Reviewed-by: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
