Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5D430C8A6
	for <lists+linux-nvdimm@lfdr.de>; Tue,  2 Feb 2021 18:58:26 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C4245100EAB41;
	Tue,  2 Feb 2021 09:58:24 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=batv+78410b086ab5a19d433c+6372+infradead.org+hch@casper.srs.infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9EAC1100EF264
	for <linux-nvdimm@lists.01.org>; Tue,  2 Feb 2021 09:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9dHe8X0M/3eLG6K/H+w57u8zHZx7qqyeZnRzALWt0zg=; b=U+HdSP7RG9UeTUyPuXewIWOgyb
	GTkbvsY8pAvpyiHEPUiLTa3r6y9nOvaqQmOiXfp+Xr2xM0ynU1/P2QNKpnzWwZhI+bnxLTvjVrXJz
	0UvQ6jwxOtAhkolAgCADzjbRJxPCxqRzsoIIoYz/milJdo7OhiV+3PHdIcCrAv0ZP9UOCtrsoPKqA
	ISI+1n1DVCsJNp5rJVz0XeyiNyRZyJQVLJTQG8jFp3MlmMyCdABN9Fr/HB3nmQ5KP3RsYYjMY8uxI
	ATzRpmieLurk15Eq4ATo8ly5fnE2P02l/3nXV7ec/Ss81zLBrCpjEii22JIsbJ7U/luDtX43EU9/Z
	S1GB44DA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
	id 1l6zwA-00FYjQ-Bn; Tue, 02 Feb 2021 17:58:02 +0000
Date: Tue, 2 Feb 2021 17:58:02 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 01/14] cxl/mem: Introduce a driver for CXL-2.0-Type-3
 endpoints
Message-ID: <20210202175802.GA3708021@infradead.org>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-2-ben.widawsky@intel.com>
 <20210201173411.GD197521@fedora>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210201173411.GD197521@fedora>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: JELSDCRDXN573R4X3BJLOYLYMHLV5AIQ
X-Message-ID-Hash: JELSDCRDXN573R4X3BJLOYLYMHLV5AIQ
X-MailFrom: BATV+78410b086ab5a19d433c+6372+infradead.org+hch@casper.srs.infradead.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JELSDCRDXN573R4X3BJLOYLYMHLV5AIQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Feb 01, 2021 at 12:34:11PM -0500, Konrad Rzeszutek Wilk wrote:
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> 
> Can those two comments have the same type? As in either
> stay with // or do /*.

No.  // is only intended for the SPDX comments specifically so that
they stand out.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
