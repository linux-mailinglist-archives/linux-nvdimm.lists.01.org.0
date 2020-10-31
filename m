Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 228902A1484
	for <lists+linux-nvdimm@lfdr.de>; Sat, 31 Oct 2020 10:10:31 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5F47F163B1EF2;
	Sat, 31 Oct 2020 02:10:29 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=batv+e1c4655336593cdcfc57+6278+infradead.org+hch@casper.srs.infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A437E163B1EF0
	for <linux-nvdimm@lists.01.org>; Sat, 31 Oct 2020 02:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oPEIdviMxitzL+S1gMzK4Ov2/vXRQ0CoB5foU9ASBJI=; b=TsLV0qIeRD7+WPLBsTtpeiXcC2
	jrIyXcEejkSHMIGI8nJCJRTopjHXb750mavvwffuq+2acbkDNzOI3LciYC4Qra2/TjS0NGEyFdhP6
	+c4dSHl9ustxjNP4YxcmIqjODenVNwRdm49PsHLFyR8aqEGXLecNXlp93mjsfEI5yBuAF956QGHkT
	unDaIKhDayBEeANzWX6J0Gr5RCsZAGb6d7DVWcMTT2mvh1rsSp/sQ84Mu61CVM1xfp5lFu2A2pvIU
	BvMp1haBWtYUkXDVB9BAha59F+IfIg0TEjPTzxsrsaAd3rViQpuznsu7bIlpb2XcC1nW86wxTE8Qv
	DJ1Vaz4A==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kYmto-0007Vn-Jp; Sat, 31 Oct 2020 09:10:12 +0000
Date: Sat, 31 Oct 2020 09:10:12 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] x86/mm: Fix phys_to_target_node() export
Message-ID: <20201031091012.GA27844@infradead.org>
References: <160402498564.4173389.2743697400148832021.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <160402498564.4173389.2743697400148832021.stgit@dwillia2-desk3.amr.corp.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: J6I3RGVFATCQXXLVAUEQUM65EFNQVPPZ
X-Message-ID-Hash: J6I3RGVFATCQXXLVAUEQUM65EFNQVPPZ
X-MailFrom: BATV+e1c4655336593cdcfc57+6278+infradead.org+hch@casper.srs.infradead.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: akpm@linux-foundation.org, Randy Dunlap <rdunlap@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, kernel test robot <lkp@intel.com>, Joao Martins <joao.m.martins@oracle.com>, x86@kernel.org, linux-mm@kvack.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/J6I3RGVFATCQXXLVAUEQUM65EFNQVPPZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Oct 29, 2020 at 07:29:45PM -0700, Dan Williams wrote:
> The core-mm has a default __weak implementation of phys_to_target_node()
> when the architecture does not override it. That symbol is exported
> for modules. However, while the export in mm/memory_hotplug.c exported
> the symbol in the configuration cases of:

Which just means that we should never export weak symbols.  So instead
of hacking around this introduce a symbol that indicates that the
architecture impements phys_to_target_node, and don't defined it at all
in common code for that case.

> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -365,9 +365,14 @@ int __weak phys_to_target_node(u64 start)
>  			start);
>  	return 0;
>  }
> +
> +/* If the arch did not export a strong symbol, export the weak one. */
> +#ifndef CONFIG_NUMA_KEEP_MEMINFO
>  EXPORT_SYMBOL_GPL(phys_to_target_node);
>  #endif
>  
> +#endif

i.e. move the ifdef to include the actual phys_to_target_node
definition, and remove the __weak from it here.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
