Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCDD2EA458
	for <lists+linux-nvdimm@lfdr.de>; Tue,  5 Jan 2021 05:18:14 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 35F19100EBBB1;
	Mon,  4 Jan 2021 20:18:13 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2002:c35c:fd02::1; helo=zeniv.linux.org.uk; envelope-from=viro@ftp.linux.org.uk; receiver=<UNKNOWN> 
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 77E60100EBBAF
	for <linux-nvdimm@lists.01.org>; Mon,  4 Jan 2021 20:18:09 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kwdms-006y0f-FZ; Tue, 05 Jan 2021 04:17:38 +0000
Date: Tue, 5 Jan 2021 04:17:38 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2] fs/dax: include <asm/page.h> to fix build error on ARC
Message-ID: <20210105041738.GS3579531@ZenIV.linux.org.uk>
References: <20210101042914.5313-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210101042914.5313-1-rdunlap@infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
Message-ID-Hash: TSDBSDNNMMMC5KEA2IF7Z5SKZZRAODUW
X-Message-ID-Hash: TSDBSDNNMMMC5KEA2IF7Z5SKZZRAODUW
X-MailFrom: viro@ftp.linux.org.uk
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, Vineet Gupta <vgupta@synopsys.com>, linux-snps-arc@lists.infradead.org, Vineet Gupta <vgupts@synopsys.com>, Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TSDBSDNNMMMC5KEA2IF7Z5SKZZRAODUW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Dec 31, 2020 at 08:29:14PM -0800, Randy Dunlap wrote:
> fs/dax.c uses copy_user_page() but ARC does not provide that interface,
> resulting in a build error.
> 
> Provide copy_user_page() in <asm/page.h> (beside copy_page()) and
> add <asm/page.h> to fs/dax.c to fix the build error.
> 
> ../fs/dax.c: In function 'copy_cow_page_dax':
> ../fs/dax.c:702:2: error: implicit declaration of function 'copy_user_page'; did you mean 'copy_to_user_page'? [-Werror=implicit-function-declaration]

Could somebody explain what the force-cast is doing in there?
I mean, the call is
        copy_user_page(vto, (void __force *)kaddr, vaddr, to);
kaddr is a local variable there, declared as void *; AFAICS, that
had been pure cargo-cult since
commit 7a9eb20666317794d0279843fbd091af93907780
Author: Dan Williams <dan.j.williams@intel.com>
Date:   Fri Jun 3 18:06:47 2016 -0700

    pmem: kill __pmem address space

I mean, it's been more than 4 years, time to bury that body...
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
