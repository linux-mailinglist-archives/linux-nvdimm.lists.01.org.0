Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCEF2A700B
	for <lists+linux-nvdimm@lfdr.de>; Wed,  4 Nov 2020 23:00:12 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BCD6E1609061A;
	Wed,  4 Nov 2020 14:00:10 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=tglx@linutronix.de; receiver=<UNKNOWN> 
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D4A86100A01CC
	for <linux-nvdimm@lists.01.org>; Wed,  4 Nov 2020 14:00:08 -0800 (PST)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1604527204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AcDsYZoZ0HQ8m/eP7LfmBFx38dKfFr6Bky2Op7UAmTc=;
	b=uWGK10QusV8XBgAEcXVFwB1s7DNqNR5bL2JxVVUikjP6JCw35Az+lH5kDWr/WVmnsV5f1a
	v9VKhuFzImQ6xYFX7YxIzcIJ8YdpvepoHsQWKeEDjnDCubBPSFXYO8t/8LEmfdY1e0a1LQ
	zW4GmgphvtE89rP0MbRj0SVvzfkZIg3CNxaDvYoK0I/s21xPkV1Yp9dLyQ5pB8PaIUff08
	VcFY0hmUO0WpT6iFhQYDoHl8KvFDJbuIcKAgCcldgqvZIvkM8szgbdWQ3TGu/eRovgBYXP
	cx196hdriOCOBkZ0zIsChUhB5+Elt6carE/r29w1GPSqqLChVCIne7K15cElzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1604527204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AcDsYZoZ0HQ8m/eP7LfmBFx38dKfFr6Bky2Op7UAmTc=;
	b=4RHQiyW6VNGm/O/DAJIaIeOw+XnqzvzEWcSqFGUfKYoL99s98K8xSO9iHJpE1NVxJhZwIu
	pTGKWcex2mU6TyAg==
To: Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH V2 00/10] PKS: Add Protection Keys Supervisor (PKS) support
In-Reply-To: <20201104174643.GC1531489@iweiny-DESK2.sc.intel.com>
References: <20201102205320.1458656-1-ira.weiny@intel.com> <871rhb8h73.fsf@nanos.tec.linutronix.de> <20201104174643.GC1531489@iweiny-DESK2.sc.intel.com>
Date: Wed, 04 Nov 2020 23:00:04 +0100
Message-ID: <87k0v0lr4r.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID-Hash: Q5XEVWGHETGJEUCGREWNSWWNSGM2GFK7
X-Message-ID-Hash: Q5XEVWGHETGJEUCGREWNSWWNSGM2GFK7
X-MailFrom: tglx@linutronix.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/Q5XEVWGHETGJEUCGREWNSWWNSGM2GFK7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Nov 04 2020 at 09:46, Ira Weiny wrote:
> On Tue, Nov 03, 2020 at 12:36:16AM +0100, Thomas Gleixner wrote:
>> This is the wrong ordering, really.
>> 
>>      x86/entry: Move nmi entry/exit into common code
>> 
>> is a general cleanup and has absolutely nothing to do with PKRS.So this
>> wants to go first.
>
> Sorry, yes this should be a pre-patch.

I picked it out of the series and applied it to tip core/entry as I have
other stuff coming up in that area. 

Thanks,

        tglx
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
