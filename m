Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B52022A3EFF
	for <lists+linux-nvdimm@lfdr.de>; Tue,  3 Nov 2020 09:34:15 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A61031651664C;
	Tue,  3 Nov 2020 00:34:13 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=batv+2c0476b3751e5f265520+6281+infradead.org+hch@casper.srs.infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B64D01651664A
	for <linux-nvdimm@lists.01.org>; Tue,  3 Nov 2020 00:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+lPuxqpeloSWVGo/+9/EHnScl176Bmh9RNkYIWq7sbQ=; b=spT/S/D9dQnl68Nn2jMdBht/SX
	Z7z66rBzYrsxfOJj2FBFROStElnxM9uDF/akCpghsXCl90ta9KRB5svOW1aUieia6epcmG9wqu2pW
	rmoD1vE3ktvU/uIynL9VsJtq+5mFns3KEW/eJ8OTbukbXo78l4RZ63Lohwuj98kgD9aeYCU7C631Q
	4MvUrzQUJj0gyhnBc86S1mT0rpOQfE/IycGgKyNXUWicXgFDT1XMZQT8a8luhIiSzxVUJlxwp6zMG
	TKsamHAcrZSgMHfHRIefaApx+MywZUmX2qIKhXPM1Wrw4bOXrKsMPOOVgxA0ZS2pJ7JkWSMLxYCpJ
	U2uPDJxg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kZrlD-0002U3-ST; Tue, 03 Nov 2020 08:33:48 +0000
Date: Tue, 3 Nov 2020 08:33:47 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] x86/mm: Fix phys_to_target_node() export
Message-ID: <20201103083347.GA9092@infradead.org>
References: <160402498564.4173389.2743697400148832021.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20201031091012.GA27844@infradead.org>
 <CAPcyv4gj9ibFuBY1yt79CdKRgYAftdveXT1Ow4QvyRxri4jBRA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4gj9ibFuBY1yt79CdKRgYAftdveXT1Ow4QvyRxri4jBRA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: GVYDHFDDO5M7DQKHEBIRL6MDGX2C2EPL
X-Message-ID-Hash: GVYDHFDDO5M7DQKHEBIRL6MDGX2C2EPL
X-MailFrom: BATV+2c0476b3751e5f265520+6281+infradead.org+hch@casper.srs.infradead.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, kernel test robot <lkp@intel.com>, Joao Martins <joao.m.martins@oracle.com>, X86 ML <x86@kernel.org>, Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GVYDHFDDO5M7DQKHEBIRL6MDGX2C2EPL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This version looks sensible to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
