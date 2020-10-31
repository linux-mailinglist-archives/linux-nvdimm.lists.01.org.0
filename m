Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 055DD2A133A
	for <lists+linux-nvdimm@lfdr.de>; Sat, 31 Oct 2020 04:02:00 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 14CA3160560A5;
	Fri, 30 Oct 2020 20:01:58 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=tglx@linutronix.de; receiver=<UNKNOWN> 
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9FF12160560A4
	for <linux-nvdimm@lists.01.org>; Fri, 30 Oct 2020 20:01:55 -0700 (PDT)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1604113312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I9A/vn8RXV/aSq5gS0Fodurx6CXlO5hNvRAQKisHv0o=;
	b=qNZR6kCdlqf+PdXFp12Nng75v/0tUThW2lFom1ibgJ4oxPN5JQ+Fi+OmvSspWOzRze7h1R
	H/QL5WImX0gjceb10e3jYZQ4yyoACGnzFEBuYszFYclUJTONapBzfGGhS+FF8EZjjIZs77
	CU9axHF3M0RhrLMV4gV5YHTZld4jUFXBf7Lgr3+pqXh9fKdEA8N1Q0MrgsJGZgfPehc9P/
	MsenY4iWio8NkXrNuRMPdFwtarVugwwG7VMm8XXnJ/gw+pdQg9phqejVQBD4W76M+2itWJ
	N4sxG6jGZC8fULRl0AGm/DpQqEuVl9V8hCqrFDl4Tcqtx49LaWDRcIOTE/icKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1604113312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I9A/vn8RXV/aSq5gS0Fodurx6CXlO5hNvRAQKisHv0o=;
	b=Nglj8YmZFYVgU3Is3pm3AloSsv3hLn1TWQfLZjd3j7rd5m2qCHQiXFLvzQxtUDWIaIiqVL
	cbOSGFRJGd+bnpDw==
To: Dan Williams <dan.j.williams@intel.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] x86/mm: Fix phys_to_target_node() export
In-Reply-To: <CAPcyv4iw_ZuHdhrGHUPh+iBYuO7sN_omEGb8RMmOKVzSCpbT0g@mail.gmail.com>
References: <160402498564.4173389.2743697400148832021.stgit@dwillia2-desk3.amr.corp.intel.com> <CAPcyv4iw_ZuHdhrGHUPh+iBYuO7sN_omEGb8RMmOKVzSCpbT0g@mail.gmail.com>
Date: Sat, 31 Oct 2020 04:01:51 +0100
Message-ID: <87blgjksio.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID-Hash: NXMAZ2W4HRZBZB2NN6W7LKC5SZJJMAQK
X-Message-ID-Hash: NXMAZ2W4HRZBZB2NN6W7LKC5SZJJMAQK
X-MailFrom: tglx@linutronix.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Randy Dunlap <rdunlap@infradead.org>, kernel test robot <lkp@intel.com>, Joao Martins <joao.m.martins@oracle.com>, X86 ML <x86@kernel.org>, Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NXMAZ2W4HRZBZB2NN6W7LKC5SZJJMAQK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Oct 30 2020 at 18:54, Dan Williams wrote:
> Thomas, do you want to ack this so Andrew can pick it up, or I can
> take it through as a device-dax update, but either way the diffstat
> warrants x86 + mm acks.

It's butt ugly but I couldn't come up with anything better right
away. So, FWIW:

Acked-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Thomas Gleixner <tglx@linutronix.de>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
