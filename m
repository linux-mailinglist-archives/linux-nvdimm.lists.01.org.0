Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 932F125E92D
	for <lists+linux-nvdimm@lfdr.de>; Sat,  5 Sep 2020 19:02:51 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AFBE013A23178;
	Sat,  5 Sep 2020 10:02:49 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.81; helo=us-smtp-delivery-1.mimecast.com; envelope-from=mpatocka@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com [207.211.31.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DF1F113A23177
	for <linux-nvdimm@lists.01.org>; Sat,  5 Sep 2020 10:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1599325365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jrXp43UxbWFyBSLI3uXeg+PIZNLujoOQ/yHnaU88Gfw=;
	b=Mr413aFnjcnlnG6U/R+WOH8GjVslbYY8dLJnT8BTZxV8c/Azw0qoIleFhPBYTCbBiyiuJs
	LfLvwRQiY2ZLp5Ud3ovovlFYhbC0srkR+Wo7mZp06SApb9CKNKFsTuxuKMJK1bbWwT2eAs
	fF9vEIq/IYfm1MJzsIeXHHR/oBe5zkA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-EhxP2uzbO_iBzQpKl6t-Pw-1; Sat, 05 Sep 2020 13:02:41 -0400
X-MC-Unique: EhxP2uzbO_iBzQpKl6t-Pw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1D17801ABE;
	Sat,  5 Sep 2020 17:02:38 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 98BD95C1D0;
	Sat,  5 Sep 2020 17:02:35 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
	by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 085H2YdB002995;
	Sat, 5 Sep 2020 13:02:34 -0400
Received: from localhost (mpatocka@localhost)
	by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 085H2XWB002991;
	Sat, 5 Sep 2020 13:02:33 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date: Sat, 5 Sep 2020 13:02:33 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH 2/2] xfs: don't update mtime on COW faults
In-Reply-To: <20200905153652.GA7955@magnolia>
Message-ID: <alpine.LRH.2.02.2009051229180.542@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2009031328040.6929@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2009041200570.27312@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2009050805250.12419@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009050812060.12419@file01.intranet.prod.int.rdu2.redhat.com> <20200905153652.GA7955@magnolia>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Message-ID-Hash: 2IWKILW6IQ7PWTLA7XVSQ5FYN7OWTFJ7
X-Message-ID-Hash: 2IWKILW6IQ7PWTLA7XVSQ5FYN7OWTFJ7
X-MailFrom: mpatocka@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Linus Torvalds <torvalds@linux-foundation.org>, Jan Kara <jack@suse.cz>, Dave Chinner <dchinner@redhat.com>, Jann Horn <jannh@google.com>, Christoph Hellwig <hch@lst.de>, Oleg Nesterov <oleg@redhat.com>, Kirill Shutemov <kirill@shutemov.name>, Theodore Ts'o <tytso@mit.edu>, Andrea Arcangeli <aarcange@redhat.com>, Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2IWKILW6IQ7PWTLA7XVSQ5FYN7OWTFJ7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Sat, 5 Sep 2020, Darrick J. Wong wrote:

> On Sat, Sep 05, 2020 at 08:13:02AM -0400, Mikulas Patocka wrote:
> > When running in a dax mode, if the user maps a page with MAP_PRIVATE and
> > PROT_WRITE, the xfs filesystem would incorrectly update ctime and mtime
> > when the user hits a COW fault.
> > 
> > This breaks building of the Linux kernel.
> > How to reproduce:
> > 1. extract the Linux kernel tree on dax-mounted xfs filesystem
> > 2. run make clean
> > 3. run make -j12
> > 4. run make -j12
> > - at step 4, make would incorrectly rebuild the whole kernel (although it
> >   was already built in step 3).
> > 
> > The reason for the breakage is that almost all object files depend on
> > objtool. When we run objtool, it takes COW page fault on its .data
> > section, and these faults will incorrectly update the timestamp of the
> > objtool binary. The updated timestamp causes make to rebuild the whole
> > tree.
> > 
> > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> > Cc: stable@vger.kernel.org
> > 
> > ---
> >  fs/xfs/xfs_file.c |   11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> > 
> > Index: linux-2.6/fs/xfs/xfs_file.c
> > ===================================================================
> > --- linux-2.6.orig/fs/xfs/xfs_file.c	2020-09-05 10:01:42.000000000 +0200
> > +++ linux-2.6/fs/xfs/xfs_file.c	2020-09-05 13:59:12.000000000 +0200
> > @@ -1223,6 +1223,13 @@ __xfs_filemap_fault(
> >  	return ret;
> >  }
> >  
> > +static bool
> > +xfs_is_write_fault(
> 
> Call this xfs_is_shared_dax_write_fault, and throw in the IS_DAX() test?
> 
> You might as well make it a static inline.

Yes, it is possible. I'll send a second version.

> > +	struct vm_fault		*vmf)
> > +{
> > +	return vmf->flags & FAULT_FLAG_WRITE && vmf->vma->vm_flags & VM_SHARED;
> 
> Also, is "shortcutting the normal fault path" the reason for ext2 and
> xfs both being broken?
> 
> /me puzzles over why write_fault is always true for page_mkwrite and
> pfn_mkwrite, but not for fault and huge_fault...
> 
> Also: Can you please turn this (checking for timestamp update behavior
> wrt shared and private mapping write faults) into an fstest so we don't
> mess this up again?

I've written this program that tests it - you can integrate it into your 
testsuite.

Mikulas


#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/stat.h>

#define FILE_NAME	"test.txt"

static struct stat st1, st2;

int main(void)
{
	int h, r;
	char *map;
	unlink(FILE_NAME);
	h = creat(FILE_NAME, 0600);
	if (h == -1) perror("creat"), exit(1);
	r = write(h, "x", 1);
	if (r != 1) perror("write"), exit(1);
	if (close(h)) perror("close"), exit(1);
	h = open(FILE_NAME, O_RDWR);
	if (h == -1) perror("open"), exit(1);

	map = mmap(NULL, 4096, PROT_READ | PROT_WRITE, MAP_PRIVATE, h, 0);
	if (map == MAP_FAILED) perror("mmap"), exit(1);
	if (fstat(h, &st1)) perror("fstat"), exit(1);
	sleep(2);
	*map = 'y';
	if (fstat(h, &st2)) perror("fstat"), exit(1);
	if (memcmp(&st1, &st2, sizeof(struct stat))) fprintf(stderr, "BUG: COW fault changed time!\n"), exit(1);
	if (munmap(map, 4096)) perror("munmap"), exit(1);

	map = mmap(NULL, 4096, PROT_READ | PROT_WRITE, MAP_SHARED, h, 0);
	if (map == MAP_FAILED) perror("mmap"), exit(1);
	if (fstat(h, &st1)) perror("fstat"), exit(1);
	sleep(2);
	*map = 'z';
	if (fstat(h, &st2)) perror("fstat"), exit(1);
	if (st1.st_mtime == st2.st_mtime) fprintf(stderr, "BUG: Shared fault did not change mtime!\n"), exit(1);
	if (st1.st_ctime == st2.st_ctime) fprintf(stderr, "BUG: Shared fault did not change ctime!\n"), exit(1);
	if (munmap(map, 4096)) perror("munmap"), exit(1);

	if (close(h)) perror("close"), exit(1);
	if (unlink(FILE_NAME)) perror("unlink"), exit(1);
	return 0;
}
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
