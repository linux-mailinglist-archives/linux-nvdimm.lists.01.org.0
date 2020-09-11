Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0D9266491
	for <lists+linux-nvdimm@lfdr.de>; Fri, 11 Sep 2020 18:41:59 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D9750144CE398;
	Fri, 11 Sep 2020 09:41:56 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.61; helo=us-smtp-delivery-1.mimecast.com; envelope-from=mpatocka@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com [205.139.110.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6C1BC144B8F84
	for <linux-nvdimm@lists.01.org>; Fri, 11 Sep 2020 09:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1599842513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dCCYRHJfCs9q7+pn8+1DMUQvWPREwMeHDgZW4MhyNFI=;
	b=V/IC86mnOLGlZwU5kMU/3SREBfQH0Ok33F44lUx69ygF/A1Qwjm6Pdimu33R7BfMoruORI
	Y9/LcT65T+pqDwXRKWDHSe/AZaLalcS5UF7RXpVI3f+K1WstKZ0kXp3MmUB8YQ6YYHJ3LI
	i5E2vIF7dxJdWWtd91wUX227TeNRhH0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-ioDUguKaNDO_8rEqEDUcWA-1; Fri, 11 Sep 2020 12:41:51 -0400
X-MC-Unique: ioDUguKaNDO_8rEqEDUcWA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0AB601084CA4;
	Fri, 11 Sep 2020 16:41:48 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 68F247B7D2;
	Fri, 11 Sep 2020 16:41:28 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
	by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 08BGfRwA030406;
	Fri, 11 Sep 2020 12:41:27 -0400
Received: from localhost (mpatocka@localhost)
	by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 08BGfQ8M030402;
	Fri, 11 Sep 2020 12:41:26 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date: Fri, 11 Sep 2020 12:41:26 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH 2/2] xfs: don't update mtime on COW faults
In-Reply-To: <20200910060626.GA7964@magnolia>
Message-ID: <alpine.LRH.2.02.2009111232210.29958@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2009031328040.6929@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2009041200570.27312@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2009050805250.12419@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009050812060.12419@file01.intranet.prod.int.rdu2.redhat.com> <20200905153652.GA7955@magnolia> <alpine.LRH.2.02.2009051229180.542@file01.intranet.prod.int.rdu2.redhat.com> <20200910060626.GA7964@magnolia>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Message-ID-Hash: ODEY2JWWFVLEII3KDPIUV7YWPCWUIXCU
X-Message-ID-Hash: ODEY2JWWFVLEII3KDPIUV7YWPCWUIXCU
X-MailFrom: mpatocka@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Linus Torvalds <torvalds@linux-foundation.org>, Jan Kara <jack@suse.cz>, Dave Chinner <dchinner@redhat.com>, Jann Horn <jannh@google.com>, Christoph Hellwig <hch@lst.de>, Oleg Nesterov <oleg@redhat.com>, Kirill Shutemov <kirill@shutemov.name>, Theodore Ts'o <tytso@mit.edu>, Andrea Arcangeli <aarcange@redhat.com>, Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, Eric Sandeen <sandeen@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ODEY2JWWFVLEII3KDPIUV7YWPCWUIXCU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Wed, 9 Sep 2020, Darrick J. Wong wrote:

> On Sat, Sep 05, 2020 at 01:02:33PM -0400, Mikulas Patocka wrote:
> > > > 
> > 
> > I've written this program that tests it - you can integrate it into your 
> > testsuite.
> 
> I don't get it.  You're a filesystem maintainer too, which means you're
> a regular contributor.  Do you:
> 
> (a) not use fstests?  If you don't, I really hope you use something else
> to QA hpfs.

I don't use xfstests on HPFS. I was testing it just by using it. Now I use 
it just a little, but I don't modify it much.

> (b) really think that it's my problem to integrate and submit your
> regression tests for you?
> 
> and (c) what do you want me to do with a piece of code that has no 
> signoff tag, no copyright, and no license?  This is your patch, and 
> therefore your responsibility to develop enough of an appropriate 
> regression test in a proper form that the rest of us can easily 
> determine we have the rights to contribute to it.


If you want a full patch (I copied the script from test 313), I send it 
here.

Mikulas


From: Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH] check ctime and mtime vs mmap

Check ctime and mtime are not updated on COW faults
and that they are updated on shared faults

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 src/Makefile          |    3 +-
 src/mmap-timestamp.c  |   53 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/609     |   40 +++++++++++++++++++++++++++++++++++++
 tests/generic/609.out |    2 +
 tests/generic/group   |    1 
 5 files changed, 98 insertions(+), 1 deletion(-)

Index: xfstests-dev/src/Makefile
===================================================================
--- xfstests-dev.orig/src/Makefile	2020-09-06 12:38:40.000000000 +0200
+++ xfstests-dev/src/Makefile	2020-09-11 17:39:04.000000000 +0200
@@ -17,7 +17,8 @@ TARGETS = dirstress fill fill2 getpagesi
 	t_mmap_cow_race t_mmap_fallocate fsync-err t_mmap_write_ro \
 	t_ext4_dax_journal_corruption t_ext4_dax_inline_corruption \
 	t_ofd_locks t_mmap_collision mmap-write-concurrent \
-	t_get_file_time t_create_short_dirs t_create_long_dirs
+	t_get_file_time t_create_short_dirs t_create_long_dirs \
+	mmap-timestamp
 
 LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
Index: xfstests-dev/src/mmap-timestamp.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ xfstests-dev/src/mmap-timestamp.c	2020-09-11 18:21:40.000000000 +0200
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2020 Red Hat, Inc. All Rights reserved.
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
+
+#define FILE_NAME	argv[1]
+
+static struct stat st1, st2;
+
+int main(int argc, char *argv[])
+{
+	int h, r;
+	char *map;
+	unlink(FILE_NAME);
+	h = creat(FILE_NAME, 0600);
+	if (h == -1) perror("creat"), exit(1);
+	r = write(h, "x", 1);
+	if (r != 1) perror("write"), exit(1);
+	if (close(h)) perror("close"), exit(1);
+	h = open(FILE_NAME, O_RDWR);
+	if (h == -1) perror("open"), exit(1);
+
+	map = mmap(NULL, 4096, PROT_READ | PROT_WRITE, MAP_PRIVATE, h, 0);
+	if (map == MAP_FAILED) perror("mmap"), exit(1);
+	if (fstat(h, &st1)) perror("fstat"), exit(1);
+	sleep(2);
+	*map = 'y';
+	if (fstat(h, &st2)) perror("fstat"), exit(1);
+	if (st1.st_mtime != st2.st_mtime) fprintf(stderr, "BUG: COW fault changed mtime!\n"), exit(1);
+	if (st1.st_ctime != st2.st_ctime) fprintf(stderr, "BUG: COW fault changed ctime!\n"), exit(1);
+	if (munmap(map, 4096)) perror("munmap"), exit(1);
+
+	map = mmap(NULL, 4096, PROT_READ | PROT_WRITE, MAP_SHARED, h, 0);
+	if (map == MAP_FAILED) perror("mmap"), exit(1);
+	if (fstat(h, &st1)) perror("fstat"), exit(1);
+	sleep(2);
+	*map = 'z';
+	if (msync(map, 4096, MS_SYNC)) perror("msync"), exit(1);
+	if (fstat(h, &st2)) perror("fstat"), exit(1);
+	if (st1.st_mtime == st2.st_mtime) fprintf(stderr, "BUG: Shared fault did not change mtime!\n"), exit(1);
+	if (st1.st_ctime == st2.st_ctime) fprintf(stderr, "BUG: Shared fault did not change ctime!\n"), exit(1);
+	if (munmap(map, 4096)) perror("munmap"), exit(1);
+
+	if (close(h)) perror("close"), exit(1);
+	if (unlink(FILE_NAME)) perror("unlink"), exit(1);
+	return 0;
+}
Index: xfstests-dev/tests/generic/609
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ xfstests-dev/tests/generic/609	2020-09-11 18:30:30.000000000 +0200
@@ -0,0 +1,40 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2020 Red Hat, Inc. All Rights Reserved.
+#
+# FS QA Test No. 609
+#
+# Check ctime and mtime are not updated on COW faults
+# and that they are updated on shared faults
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+    cd /
+    rm -f $testfile
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_test
+
+testfile=$TEST_DIR/testfile.$seq
+
+echo "Silence is golden"
+
+$here/src/mmap-timestamp $testfile 2>&1
+
+status=0
+exit
Index: xfstests-dev/tests/generic/609.out
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ xfstests-dev/tests/generic/609.out	2020-09-11 18:24:24.000000000 +0200
@@ -0,0 +1,2 @@
+QA output created by 609
+Silence is golden
Index: xfstests-dev/tests/generic/group
===================================================================
--- xfstests-dev.orig/tests/generic/group	2020-09-06 12:38:40.000000000 +0200
+++ xfstests-dev/tests/generic/group	2020-09-11 18:25:09.000000000 +0200
@@ -611,3 +611,4 @@
 606 auto attr quick dax
 607 auto attr quick dax
 608 auto attr quick dax
+609 auto quick
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
