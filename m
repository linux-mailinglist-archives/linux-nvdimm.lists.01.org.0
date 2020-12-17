Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1D12DD58E
	for <lists+linux-nvdimm@lfdr.de>; Thu, 17 Dec 2020 17:58:35 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 597BB100EB829;
	Thu, 17 Dec 2020 08:58:33 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=tglx@linutronix.de; receiver=<UNKNOWN> 
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5F049100ED4A2
	for <linux-nvdimm@lists.01.org>; Thu, 17 Dec 2020 08:58:31 -0800 (PST)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1608224308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BfeG9stxOsSpjRYXj7Js+sXxnOSrg6f7PFi1tBPvTk4=;
	b=gBt8MjRwIBoZoOeRr2iv95diwya5Pn0IUF0cU39dmJIhU7C9g+sbPkGpiPSqGHzNVwKtDS
	Xebun5owJ8k+ANh+8c0GWB+05QGhsw5KAcBBaS6D+JrDVzMI/TKSy6DG+w/+ZCUJmtTY5D
	+i8C5pHMQYcdLgBTjcVfO3mGh8TlhZc8gB9nhauvVIBqeUXg5M+/0ysikjITOcokAeDkJd
	L+YVwS6Fdxdeuz2l35ol/TuD+YD5rlv/Pv0DupbkIoORNb84qEnTPe1nB+J9E3JjQtUabc
	usFUtM5tTrGUzWYXB2IJZs/PvBxPNuAIYQ0XIdXEbKQ/LoKy3j0BoiipJxmPQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1608224308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BfeG9stxOsSpjRYXj7Js+sXxnOSrg6f7PFi1tBPvTk4=;
	b=dn3W9hQ1peESFmJ2swDmnwnBERH9a1KMBLetWpglvwv9bYVzv/pp+RbTDpNLyrNb0+nCvp
	vsP9GutiQJM3cYDg==
To: ira.weiny@intel.com, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH V3.1] entry: Pass irqentry_state_t by reference
In-Reply-To: <20201124060956.1405768-1-ira.weiny@intel.com>
References: <20201106232908.364581-6-ira.weiny@intel.com> <20201124060956.1405768-1-ira.weiny@intel.com>
Date: Thu, 17 Dec 2020 17:58:28 +0100
Message-ID: <87v9d0qsi3.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID-Hash: AJRLYOMS4MOTT3V5DJTG5CAARU7ZTRQ2
X-Message-ID-Hash: AJRLYOMS4MOTT3V5DJTG5CAARU7ZTRQ2
X-MailFrom: tglx@linutronix.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: x86@kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/AJRLYOMS4MOTT3V5DJTG5CAARU7ZTRQ2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Nov 23 2020 at 22:09, ira weiny wrote:
> From: Ira Weiny <ira.weiny@intel.com>
>
> Currently struct irqentry_state_t only contains a single bool value
> which makes passing it by value is reasonable.  However, future patches
> add information to this struct.  This includes the PKRS thread state,
> included in this series, as well as information to store kmap reference
> tracking and PKS global state outside this series. In total, we
> anticipate 2 new 32 bit fields and an integer field to be added to the
> struct beyond the existing bool value.

Well yes, but why can't you provide at least in the comment section
below the '---' a pointer to the latest version of this reference muck
and PKS global state if you can't explain at least the concept of the
two things here?

It's one thing that you anticipate something but a different thing
whether it's the right thing to do.

Thanks,

        tglx
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
