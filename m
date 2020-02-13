Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 948F315BD9A
	for <lists+linux-nvdimm@lfdr.de>; Thu, 13 Feb 2020 12:22:36 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C643210FC33E5;
	Thu, 13 Feb 2020 03:25:51 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=tglx@linutronix.de; receiver=<UNKNOWN> 
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 823601007B195
	for <linux-nvdimm@lists.01.org>; Thu, 13 Feb 2020 03:25:49 -0800 (PST)
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
	by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
	(Exim 4.80)
	(envelope-from <tglx@linutronix.de>)
	id 1j2CZc-0007zB-6b; Thu, 13 Feb 2020 12:22:24 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
	id CEDC31013A6; Thu, 13 Feb 2020 12:22:23 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Dan Williams <dan.j.williams@intel.com>, mingo@redhat.com
Subject: Re: [PATCH v4 4/6] x86/mm: Introduce CONFIG_KEEP_NUMA
In-Reply-To: <157966229575.2508551.1892426244277171485.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157966227494.2508551.7206194169374588977.stgit@dwillia2-desk3.amr.corp.intel.com> <157966229575.2508551.1892426244277171485.stgit@dwillia2-desk3.amr.corp.intel.com>
Date: Thu, 13 Feb 2020 12:22:23 +0100
Message-ID: <877e0q3f68.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID-Hash: YSNMSI75NJPHAUV2HHJFKPHHE4Z2RXKW
X-Message-ID-Hash: YSNMSI75NJPHAUV2HHJFKPHHE4Z2RXKW
X-MailFrom: tglx@linutronix.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@suse.com>, hch@lst.de, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YSNMSI75NJPHAUV2HHJFKPHHE4Z2RXKW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dan Williams <dan.j.williams@intel.com> writes:
> +#ifdef CONFIG_KEEP_NUMA
> +#define __initdata_numa
> +#else
> +#define __initdata_numa __initdata
> +#endif

TBH, I find this conditional annotation mightingly confusing.

__initdata_numa still suggest that this is __initdata, just a different
section and some extra rules or whatever.

Something like __initdata_or_keepnuma (sorry I could not come up with
something prettier, but you get the idea.

Thanks,

        tglx
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
