Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB682DEABB
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Dec 2020 22:06:32 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 08697100EB347;
	Fri, 18 Dec 2020 13:06:31 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=tglx@linutronix.de; receiver=<UNKNOWN> 
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5BA5E100EB346
	for <linux-nvdimm@lists.01.org>; Fri, 18 Dec 2020 13:06:28 -0800 (PST)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1608325586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5KbSIN55suX89YOBcIXDM5LxH+O6LLG2triQiwJQEiw=;
	b=lxq0Z0/2O14CTwirAq+bb6fuW6UqCM6iqC8qzHXHLrZfy+sDRGOF/0How3eiSpYti5hyy1
	PPjKqCf3MKtrf7IQYaOFjyuXT4RetV9r+fcaYWFfkisBByb0n0d6/Oz8hpeuclU2liQ+zF
	b9UZig1XjIDtkpFQUGed0hJ9FSlPU8zI3iu4ngwn8ZXccAFZTXAmD+IAi9lNZOjDIv05V6
	0hdumIZXflEtEFfoAyzhRw6zWRPLAlhR2F6ZwRzJTud4+jkuGbq92iptCpTRZzgpYytBBv
	+1bhFOhdCmZjOEKl9Odfaojy3oH3jv/xMNUCbWSAye7FSC970xo3MgIOPjbxaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1608325586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5KbSIN55suX89YOBcIXDM5LxH+O6LLG2triQiwJQEiw=;
	b=BngWZDtOpkOjDlsMazPLISfJ/Wv/jD0wklYW3MtSj1b941oW4rqP5E8tjXsT4f09a0QbS1
	JhvFAp2tpTn1qMBA==
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH V3 04/10] x86/pks: Preserve the PKRS MSR on context switch
In-Reply-To: <CAPcyv4h2MvybBi==3uzAjGeW0R7azHYSKwmvzMXq9eM8NzMLEg@mail.gmail.com>
References: <20201106232908.364581-1-ira.weiny@intel.com> <20201106232908.364581-5-ira.weiny@intel.com> <871rfoscz4.fsf@nanos.tec.linutronix.de> <87mtycqcjf.fsf@nanos.tec.linutronix.de> <878s9vqkrk.fsf@nanos.tec.linutronix.de> <CAPcyv4h2MvybBi==3uzAjGeW0R7azHYSKwmvzMXq9eM8NzMLEg@mail.gmail.com>
Date: Fri, 18 Dec 2020 22:06:24 +0100
Message-ID: <875z4yrfhr.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID-Hash: MZBOUXQ7Y6XLSREZFGSHTUVT64L7L22W
X-Message-ID-Hash: MZBOUXQ7Y6XLSREZFGSHTUVT64L7L22W
X-MailFrom: tglx@linutronix.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, Fenghua Yu <fenghua.yu@intel.com>, X86 ML <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux MM <linux-mm@kvack.org>, linux-kselftest@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MZBOUXQ7Y6XLSREZFGSHTUVT64L7L22W/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Dec 18 2020 at 11:20, Dan Williams wrote:
> On Fri, Dec 18, 2020 at 5:58 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> [..]
>>   5) The DAX case which you made "work" with dev_access_enable() and
>>      dev_access_disable(), i.e. with yet another lazy approach of
>>      avoiding to change a handful of usage sites.
>>
>>      The use cases are strictly context local which means the global
>>      magic is not used at all. Why does it exist in the first place?
>>
>>      Aside of that this global thing would never work at all because the
>>      refcounting is per thread and not global.
>>
>>      So that DAX use case is just a matter of:
>>
>>         grant/revoke_access(DEV_PKS_KEY, READ/WRITE)
>>
>>      which is effective for the current execution context and really
>>      wants to be a distinct READ/WRITE protection and not the magic
>>      global thing which just has on/off. All usage sites know whether
>>      they want to read or write.
>
> I was tracking and nodding until this point. Yes, kill the global /
> kmap() support, but if grant/revoke_access is not integrated behind
> kmap_{local,atomic}() then it's not a "handful" of sites that need to
> be instrumented it's 100s. Are you suggesting that "relaxed" mode
> enforcement is a way to distribute the work of teaching driver writers
> that they need to incorporate explicit grant/revoke-read/write in
> addition to kmap? The entire reason PTE_DEVMAP exists was to allow
> get_user_pages() for PMEM and not require every downstream-GUP code
> path to specifically consider whether it was talking to PMEM or RAM
> pages, and certainly not whether they were reading or writing to it.

kmap_local() is fine. That can work automatically because it's strict
local to the context which does the mapping.

kmap() is dubious because it's a 'global' mapping as dictated per
HIGHMEM. So doing the RELAXED mode for kmap() is sensible I think to
identify cases where the mapped address is really handed to a different
execution context. We want to see those cases and analyse whether this
can't be solved in a different way. That's why I suggested to do a
warning in that case.

Also vs. the DAX use case I really meant the code in fs/dax and
drivers/dax/ itself which is handling this via dax_read_[un]lock.

Does that make more sense?

Thanks,

        tglx

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
