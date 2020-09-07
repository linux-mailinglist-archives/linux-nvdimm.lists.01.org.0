Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CED425F361
	for <lists+linux-nvdimm@lfdr.de>; Mon,  7 Sep 2020 08:48:05 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6005C13E57D4C;
	Sun,  6 Sep 2020 23:48:03 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=<UNKNOWN> 
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7C29213E57D4B
	for <linux-nvdimm@lists.01.org>; Sun,  6 Sep 2020 23:48:01 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5A1BB6736F; Mon,  7 Sep 2020 08:47:58 +0200 (CEST)
Date: Mon, 7 Sep 2020 08:47:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [PATCH 2/2] xfs: don't update mtime on COW faults
Message-ID: <20200907064758.GA19384@lst.de>
References: <alpine.LRH.2.02.2009031328040.6929@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2009041200570.27312@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2009050805250.12419@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2009050812060.12419@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2009050812060.12419@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Message-ID-Hash: 6UJJP2EABAHHCPHY4PHWZOVD45VAZWB5
X-Message-ID-Hash: 6UJJP2EABAHHCPHY4PHWZOVD45VAZWB5
X-MailFrom: hch@lst.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Linus Torvalds <torvalds@linux-foundation.org>, Jan Kara <jack@suse.cz>, "Darrick J. Wong" <darrick.wong@oracle.com>, Dave Chinner <dchinner@redhat.com>, Jann Horn <jannh@google.com>, Christoph Hellwig <hch@lst.de>, Oleg Nesterov <oleg@redhat.com>, Kirill Shutemov <kirill@shutemov.name>, Theodore Ts'o <tytso@mit.edu>, Andrea Arcangeli <aarcange@redhat.com>, Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6UJJP2EABAHHCPHY4PHWZOVD45VAZWB5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> +static bool
> +xfs_is_write_fault(
> +	struct vm_fault		*vmf)
> +{
> +	return vmf->flags & FAULT_FLAG_WRITE && vmf->vma->vm_flags & VM_SHARED;
> +}

This function does not look xfs specific at all.  Why isn't it it in
fs.h?  While we're at it the name sounds rather generic, and there are
no good comments.

Maybe we just need to split FAULT_FLAG_WRITE into two and check those
instead of such crazy workarounds?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
