Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FFE2D2ED1
	for <lists+linux-nvdimm@lfdr.de>; Tue,  8 Dec 2020 16:56:02 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9CC32100EBB96;
	Tue,  8 Dec 2020 07:56:00 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=tglx@linutronix.de; receiver=<UNKNOWN> 
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3FB9D100EBB8C
	for <linux-nvdimm@lists.01.org>; Tue,  8 Dec 2020 07:55:58 -0800 (PST)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1607442954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zLoKOU+kSW7kZX0dODC+sT6g6ygfkbwnnbOdUP+fpIo=;
	b=YNEqf/mqLSmjBmP5ZGf5eHu12lDeWGEzyauSFZAHPkhNVHZ1/AlNAqqBPKV7Wk4RaFHIGJ
	xw+JhkXoG1lzOSOOV44QRn+kYn/uRbW0SwbEHU9i24YAkRr5r38Q6CP2rpn56gigMEdWL1
	HMMQPjUWoDQhvMK1Ejpzf6kjbKeHvGDAt2nulDNCRwCN6R+eVKoK9GDHsV/EWGPBTYQ95o
	FJaY6t3dBgA0WtPuhtS8j4M/sxcSKM3xflf4o0uEViYQ3ccAFTNoP07V4Uw9VOg5+bnb13
	m33F8u0g5ENeP//5nmPwIFr2XPcSO7wjFthT0v2C1FB67BUBOjzvq0Pl6JEYvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1607442954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zLoKOU+kSW7kZX0dODC+sT6g6ygfkbwnnbOdUP+fpIo=;
	b=5eK4E9Ikvqh6D2TZGskNvX7QoOS3LoBgXize7jGZM3c/9qut1GtVzf/vcoIv5MUQ/DOWqH
	HrwKMSeV0laYDOAQ==
To: Ira Weiny <ira.weiny@intel.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH V3 00/10] PKS: Add Protection Keys Supervisor (PKS) support V3
In-Reply-To: <20201207221431.GL1563847@iweiny-DESK2.sc.intel.com>
References: <20201106232908.364581-1-ira.weiny@intel.com> <20201207221431.GL1563847@iweiny-DESK2.sc.intel.com>
Date: Tue, 08 Dec 2020 16:55:54 +0100
Message-ID: <87v9dc2sxh.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID-Hash: 5GPDO6ZJAKDNERGFCLRHBFUGTQJNL3MO
X-Message-ID-Hash: 5GPDO6ZJAKDNERGFCLRHBFUGTQJNL3MO
X-MailFrom: tglx@linutronix.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: x86@kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5GPDO6ZJAKDNERGFCLRHBFUGTQJNL3MO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Ira,

On Mon, Dec 07 2020 at 14:14, Ira Weiny wrote:
> Is there any chance of this landing before the kmap stuff gets sorted out?

I have marked this as needs an update because the change log of 5/10
sucks. https://lore.kernel.org/r/87lff1xcmv.fsf@nanos.tec.linutronix.de

> It would be nice to have this in 5.11 to build off of.

It would be nice if people follow up on review request :)

Thanks,

        tglx
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
