Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 128C22A381B
	for <lists+linux-nvdimm@lfdr.de>; Tue,  3 Nov 2020 01:59:49 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D5D581637138B;
	Mon,  2 Nov 2020 16:59:46 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1231::1; helo=merlin.infradead.org; envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN> 
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4F32116329CD1
	for <linux-nvdimm@lists.01.org>; Mon,  2 Nov 2020 16:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=JODZqgf7epPmRUkZJ3AczglKxk8wx5PqqY64iJeRXts=; b=Q4JfR/lHX1plng3aJrFExSJ0ul
	c1cUnjoSTa+dxSLQySbKpEKMwTg1THmEvphmJ7OE9XCQnUVToV4Efofzo1P5fUCFX0eaWztVZIoUA
	H3RJwAZAVu8UXFLLWVWKkhEDyksVcnLdjutqpOTwhb7QrA0cDmbekvz6zw5UtOeFTzcc9NlBs/ruo
	+RX4T4+kfs0DpyRc2eYoLqIqm0ckeyRYs8ovz2ZCUECFffQ3z1R14I+W2+uokWDiM4W8ECuVQ+LSv
	sase/9WU4PPQiggWrvCuwnScMoE5VVhkEilJaE5D6Ow0mbUAg+bgITzX/qW8OoUF7lqvaboQen3Ne
	WovzHE7A==;
Received: from [2601:1c0:6280:3f0::60d5]
	by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kZkfg-0002hy-Sv; Tue, 03 Nov 2020 00:59:37 +0000
Subject: Re: [PATCH] x86/mm: Fix phys_to_target_node() export
To: Dan Williams <dan.j.williams@intel.com>,
 Christoph Hellwig <hch@infradead.org>
References: <160402498564.4173389.2743697400148832021.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20201031091012.GA27844@infradead.org>
 <CAPcyv4gj9ibFuBY1yt79CdKRgYAftdveXT1Ow4QvyRxri4jBRA@mail.gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5b7fbe34-225f-4265-a368-5336ad5a16c1@infradead.org>
Date: Mon, 2 Nov 2020 16:59:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4gj9ibFuBY1yt79CdKRgYAftdveXT1Ow4QvyRxri4jBRA@mail.gmail.com>
Content-Language: en-US
Message-ID-Hash: VBJAES4EUFDD6MQZWDX5FSQRYPQ6CHTT
X-Message-ID-Hash: VBJAES4EUFDD6MQZWDX5FSQRYPQ6CHTT
X-MailFrom: rdunlap@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, kernel test robot <lkp@intel.com>, Joao Martins <joao.m.martins@oracle.com>, X86 ML <x86@kernel.org>, Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VBJAES4EUFDD6MQZWDX5FSQRYPQ6CHTT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 11/2/20 3:52 PM, Dan Williams wrote:
> On Sat, Oct 31, 2020 at 2:10 AM Christoph Hellwig <hch@infradead.org> wrote:
>>
>> On Thu, Oct 29, 2020 at 07:29:45PM -0700, Dan Williams wrote:
>>> The core-mm has a default __weak implementation of phys_to_target_node()
>>> when the architecture does not override it. That symbol is exported
>>> for modules. However, while the export in mm/memory_hotplug.c exported
>>> the symbol in the configuration cases of:
>>
>> Which just means that we should never export weak symbols.  So instead
>> of hacking around this introduce a symbol that indicates that the
>> architecture impements phys_to_target_node, and don't defined it at all
>> in common code for that case.
> 
> So I agree with this, but it made me realize that the way
> memory_add_physaddr_to_nid() was defined as an exported weak symbol is
> similarly broken.
> 
>>> --- a/mm/memory_hotplug.c
>>> +++ b/mm/memory_hotplug.c
>>> @@ -365,9 +365,14 @@ int __weak phys_to_target_node(u64 start)
>>>                       start);
>>>       return 0;
>>>  }
>>> +
>>> +/* If the arch did not export a strong symbol, export the weak one. */
>>> +#ifndef CONFIG_NUMA_KEEP_MEMINFO
>>>  EXPORT_SYMBOL_GPL(phys_to_target_node);
>>>  #endif
>>>
>>> +#endif
>>
>> i.e. move the ifdef to include the actual phys_to_target_node
>> definition, and remove the __weak from it here.
> 
> The trick is finding an arch common way to pick up the presence of the
> phys_to_target_node() override, and it still has the wart of ifdefery
> in C code.
> 
> I went a bit deeper and moved all the fallback routines to
> linux/numa.h and the overrides in all archs that care to
> asm/sparsemem.h. Note that asm/sparsemem.h was not my first choice,
> but it happened to be where powerpc was already defining its
> phys-addr-to-node-id infrastructure, and my first choice header,
> asm/numa.h, is not universally available.
> 
> The attached patch is going through some kbuild-robot exposure to make
> sure I did not break anything else.
> 

Works for me. Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

-- 
~Randy
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
