Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9C12E9EBE
	for <lists+linux-nvdimm@lfdr.de>; Mon,  4 Jan 2021 21:19:40 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5A229100EC1E8;
	Mon,  4 Jan 2021 12:19:39 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7590F100EC1E6
	for <linux-nvdimm@lists.01.org>; Mon,  4 Jan 2021 12:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YBgRGjn+yLmFC+9fNHoHRFsXeCxEkKsHezqEmQ36bEQ=; b=XIYp5yjtmgky7iNoVOQb+o3wZr
	3L/KpsgoiU4PgUF/2JfxkJRLW1hcLCYXszkagaCvEljXe9Uz+u8+jE4+N39M+0neNh8AXn+EbgqWM
	UAxR+Arf7ji2B/OFG3Uuzpv6oLlzE/WKH4NRTf2C5ZLJ22nsjlTWilnsqIdsGcypiK9aJg4IAg5lM
	1g4r0kbHQm4M2Ktv1xQeCRGIRJ24dRRo5PufxYiZ9vMcYqdiYxSuk/oTaFj4aJIls1KwvNY3iTP+R
	Trby8W4LwayqM2o9OfZDsuFaS3Xmo2k+k2H9fTJbw7qxTzxk44Reo+ivVA4pG6SNp99GU0kgCtR58
	KvCbKeJQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
	id 1kwWHJ-000VKI-Fy; Mon, 04 Jan 2021 20:17:08 +0000
Date: Mon, 4 Jan 2021 20:16:33 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2] fs/dax: include <asm/page.h> to fix build error on ARC
Message-ID: <20210104201633.GE22407@casper.infradead.org>
References: <20210101042914.5313-1-rdunlap@infradead.org>
 <CAPcyv4jAiqyFg_BUHh_bJRG-BqzvOwthykijRapB_8i6VtwTmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4jAiqyFg_BUHh_bJRG-BqzvOwthykijRapB_8i6VtwTmQ@mail.gmail.com>
Message-ID-Hash: JFNW5A73IPQSJDXSVI6QO7APEVHMBB6T
X-Message-ID-Hash: JFNW5A73IPQSJDXSVI6QO7APEVHMBB6T
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Randy Dunlap <rdunlap@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kernel test robot <lkp@intel.com>, Vineet Gupta <vgupta@synopsys.com>, linux-snps-arc@lists.infradead.org, Vineet Gupta <vgupts@synopsys.com>, Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JFNW5A73IPQSJDXSVI6QO7APEVHMBB6T/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jan 04, 2021 at 12:13:02PM -0800, Dan Williams wrote:
> On Thu, Dec 31, 2020 at 8:29 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> > +++ lnx-511-rc1/fs/dax.c
> > @@ -25,6 +25,7 @@
> >  #include <linux/sizes.h>
> >  #include <linux/mmu_notifier.h>
> >  #include <linux/iomap.h>
> > +#include <asm/page.h>
> 
> I would expect this to come from one of the linux/ includes like
> linux/mm.h. asm/ headers are implementation linux/ headers are api.

It does indeed come from linux/mm.h already.  And a number of
other random places, including linux/serial.h.  Our headers are a mess,
but they shouldn't be made worse by adding _this_ include.  So I
second Dan's objection here.

> Once you drop that then the subject of this patch can just be "arc:
> add a copy_user_page() implementation", and handled by the arc
> maintainer (or I can take it with Vineet's ack).
> 
> >  #include <asm/pgalloc.h>
> 
> Yes, this one should have a linux/ api header to front it, but that's
> a cleanup for another day.

Definitely more involved.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
