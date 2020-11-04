Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 298EC2A5C08
	for <lists+linux-nvdimm@lfdr.de>; Wed,  4 Nov 2020 02:38:23 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A643016542DED;
	Tue,  3 Nov 2020 17:38:20 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4599016541970
	for <linux-nvdimm@lists.01.org>; Tue,  3 Nov 2020 17:38:18 -0800 (PST)
Received: from X1 (unknown [208.106.6.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 43934223C7;
	Wed,  4 Nov 2020 01:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604453897;
	bh=QyiDZsk9eykgAFwsDR70lNLbTMk7+4qieJ3z3HbDed0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=soYuRujHI95NxVLMA67ECMy9QyCT33nM81wjPdCFPbhjqyfhehGo1geHhmaSyodsI
	 ZaTUoobKYRHJNvsJMN4be+VIxNda6UiEU47HC3gHGdWIlFTMI0rN+3jEWRJpDBAr8E
	 QeiO35qJE/2EKTkUmXg08JoEkFL4SibDLDS1hlNE=
Date: Tue, 3 Nov 2020 17:38:16 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] x86/mm: Fix phys_to_target_node() export
Message-Id: <20201103173816.8f80920621fe08012deacfcc@linux-foundation.org>
In-Reply-To: <CAPcyv4gj9ibFuBY1yt79CdKRgYAftdveXT1Ow4QvyRxri4jBRA@mail.gmail.com>
References: <160402498564.4173389.2743697400148832021.stgit@dwillia2-desk3.amr.corp.intel.com>
	<20201031091012.GA27844@infradead.org>
	<CAPcyv4gj9ibFuBY1yt79CdKRgYAftdveXT1Ow4QvyRxri4jBRA@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Message-ID-Hash: J5ADOWI74TNVORCWDMPFKEBT4RW2NW7D
X-Message-ID-Hash: J5ADOWI74TNVORCWDMPFKEBT4RW2NW7D
X-MailFrom: akpm@linux-foundation.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Christoph Hellwig <hch@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, kernel test robot <lkp@intel.com>, Joao Martins <joao.m.martins@oracle.com>, X86 ML <x86@kernel.org>, Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/J5ADOWI74TNVORCWDMPFKEBT4RW2NW7D/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 2 Nov 2020 15:52:39 -0800 Dan Williams <dan.j.williams@intel.com> wrote:

> The attached patch is going through some kbuild-robot exposure to make
> sure I did not break anything else.

I'll duck this for now - please send it along formally if/when testing
is successful.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
