Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D8221CA86
	for <lists+linux-nvdimm@lfdr.de>; Sun, 12 Jul 2020 18:59:51 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C8B471159133A;
	Sun, 12 Jul 2020 09:59:49 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5838D1159132B
	for <linux-nvdimm@lists.01.org>; Sun, 12 Jul 2020 09:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=hX/qK6z4n4CL1AKJ1RSUJle5mcIh3uNxPJ30TrVC8t8=; b=wL78Wp6PagFZFP78YDF0n5Iq2U
	cXoVGoNqXQE7zkKirLb++lczoHV7wxqEPK2RQvpkx8o6MdrHhBzCgKWwY43YKgZ3JnnNtsrn9FBXp
	fOAnfqn4KpKOFuEJ2T4ZB0pLSXvWUcLAf8TgrOxkn8luxMBPa3dN4L0nhMdPZmxtBE90hgw57oaF5
	0vvWsUuoe04Gz+0LJbFRNfJKTfnzb7+Qcg+WKGnKNpytyiw2AXEx7rgeE1mLZzP4Z+ZoUez9RrTG9
	W9+R0VSeF/S02OaUHcI3Ln+O+jeyKW0QOuJsrFyZ3tFZ804Y/v4WsWbtYcsWzQjkxiS+leLv+HO8f
	uhdHc0Nw==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
	by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jufJi-00017q-VJ; Sun, 12 Jul 2020 16:59:07 +0000
Subject: Re: [PATCH v2 02/22] x86/numa: Add 'nohmat' option
To: Dan Williams <dan.j.williams@intel.com>, linux-nvdimm@lists.01.org
References: <159457116473.754248.7879464730875147365.stgit@dwillia2-desk3.amr.corp.intel.com>
 <159457117650.754248.15655699240005524226.stgit@dwillia2-desk3.amr.corp.intel.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a869a6be-530f-573d-71dd-6a5b1a7ee939@infradead.org>
Date: Sun, 12 Jul 2020 09:58:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <159457117650.754248.15655699240005524226.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Language: en-US
Message-ID-Hash: N5LWZELL3JIM4TMHD7L46HQWFYCKFZJR
X-Message-ID-Hash: N5LWZELL3JIM4TMHD7L46HQWFYCKFZJR
X-MailFrom: rdunlap@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: x86@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, ard.biesheuvel@linaro.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, hch@lst.de, joao.m.martins@oracle.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/N5LWZELL3JIM4TMHD7L46HQWFYCKFZJR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 7/12/20 9:26 AM, Dan Williams wrote:
> Disable parsing of the HMAT for debug, to workaround broken platform
> instances, or cases where it is otherwise not wanted.
> 
> Cc: x86@kernel.org
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  arch/x86/mm/numa.c       |    2 ++
>  drivers/acpi/numa/hmat.c |    8 +++++++-
>  include/acpi/acpi_numa.h |    8 ++++++++
>  3 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> index ee24646dc44e..44fdf06d497e 100644
> --- a/arch/x86/mm/numa.c
> +++ b/arch/x86/mm/numa.c
> @@ -41,6 +41,8 @@ static __init int numa_setup(char *opt)
>  		return numa_emu_cmdline(opt + 5);
>  	if (!strncmp(opt, "noacpi", 6))
>  		disable_srat();
> +	if (!strncmp(opt, "nohmat", 6))
> +		disable_hmat();
>  	return 0;
>  }
>  early_param("numa", numa_setup);

Please add that to
Documentation/x86/x86_64/boot-options.rst.

thanks.
-- 
~Randy
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
