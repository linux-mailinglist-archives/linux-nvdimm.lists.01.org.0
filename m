Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BD1235021
	for <lists+linux-nvdimm@lfdr.de>; Sat,  1 Aug 2020 05:51:27 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E472C129610F2;
	Fri, 31 Jul 2020 20:51:25 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 36076129610F2
	for <linux-nvdimm@lists.01.org>; Fri, 31 Jul 2020 20:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=D0ZAEeULLhO0dRSJEKdMB4o06gOWrXsNB6Gpl1foU8s=; b=pQTyMwSyTafkhb+jmPKcsik00L
	3yiCd+U6Dsxcu/6ZwkRbRshAcdqWfIKRKl7V92jF1sKArZQrBcQftbTUoZyeV19ifYFQ1vtvgvhVS
	65t1agBt63lSovRXk/ENK5dil2ddKJq3fA5MFWRwtpRdpmklsW8CoN6lSLJnyydg3O5UZXxshVSc9
	NXyJI5tzTsbS5RFXKI4vzwStTz+nVDQ1eE0K4ffhg5HxcDI3q3hxfN9zpE6bOWoavDyKQmlWxGpB2
	3fRjrdzxtEQYXXbQLgzGCFFJZOs/8GQPFm17WxmCqZpAbE7YZlchM/5Z8godf4cjZ6PMLCWzAsc1B
	2U9qZGRA==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
	by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k1iYC-00057S-O2; Sat, 01 Aug 2020 03:51:14 +0000
Subject: Re: [PATCH v3 02/23] x86/numa: Add 'nohmat' option
To: Dan Williams <dan.j.williams@intel.com>, akpm@linux-foundation.org
References: <159625229779.3040297.11363509688097221416.stgit@dwillia2-desk3.amr.corp.intel.com>
 <159625231266.3040297.2759117253481288037.stgit@dwillia2-desk3.amr.corp.intel.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <545078f8-d6d3-5db7-02f6-648218513752@infradead.org>
Date: Fri, 31 Jul 2020 20:51:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <159625231266.3040297.2759117253481288037.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Language: en-US
Message-ID-Hash: QYVVLDHB6OB6MVVXYZK27Z7TUKE5OUFS
X-Message-ID-Hash: QYVVLDHB6OB6MVVXYZK27Z7TUKE5OUFS
X-MailFrom: rdunlap@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: x86@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, ard.biesheuvel@linaro.org, linux-mm@kvack.org, linux-nvdimm@lists.01.org, joao.m.martins@oracle.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QYVVLDHB6OB6MVVXYZK27Z7TUKE5OUFS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 7/31/20 8:25 PM, Dan Williams wrote:
> Disable parsing of the HMAT for debug, to workaround broken platform
> instances, or cases where it is otherwise not wanted.
> 
> ---
>  arch/x86/mm/numa.c       |    2 ++
>  drivers/acpi/numa/hmat.c |    8 +++++++-
>  include/acpi/acpi_numa.h |    8 ++++++++
>  3 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> index 87c52822cc44..f3805bbaa784 100644
> --- a/arch/x86/mm/numa.c
> +++ b/arch/x86/mm/numa.c
> @@ -41,6 +41,8 @@ static __init int numa_setup(char *opt)
>  		return numa_emu_cmdline(opt + 5);
>  	if (!strncmp(opt, "noacpi", 6))
>  		disable_srat();
> +	if (!strncmp(opt, "nohmat", 6))
> +		disable_hmat();

Hopefully that will be documented in
Documentation/x86/x86_64/boot-options.rst.

>  	return 0;
>  }
>  early_param("numa", numa_setup);

thanks.
-- 
~Randy
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
