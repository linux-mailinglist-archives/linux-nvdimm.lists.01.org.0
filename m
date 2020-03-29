Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCCF196FE3
	for <lists+linux-nvdimm@lfdr.de>; Sun, 29 Mar 2020 22:25:47 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7909610FC362C;
	Sun, 29 Mar 2020 13:26:35 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=63.128.21.74; helo=us-smtp-delivery-74.mimecast.com; envelope-from=mpatocka@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [63.128.21.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 613681003ECB6
	for <linux-nvdimm@lists.01.org>; Sun, 29 Mar 2020 13:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1585513541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9DK2kwuBXwfEyM8Nzok/c3nxOx8PsVKFK+mVn1gsCfk=;
	b=BhHCTlf5UC/NtlEOhguGU0qsCREdvtFyEKOhN0bWowtB45uWf56XHfenqo5r/ylb8DAWRm
	+CtkbJ4gGRuQXdIWy/OQRGLmUisaRCNMIB0hKua2ZC3POId0bsXR1xCc4qXU3r56I9emw/
	MuyrYpT9/cASJXx61rlY3cI05Qe96e8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-QA8JFurQONyJBXaz4NG82g-1; Sun, 29 Mar 2020 16:25:36 -0400
X-MC-Unique: QA8JFurQONyJBXaz4NG82g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E291800D53;
	Sun, 29 Mar 2020 20:25:35 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1DB4597B02;
	Sun, 29 Mar 2020 20:25:32 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
	by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 02TKPVed032162;
	Sun, 29 Mar 2020 16:25:31 -0400
Received: from localhost (mpatocka@localhost)
	by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 02TKPV0b032159;
	Sun, 29 Mar 2020 16:25:31 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date: Sun, 29 Mar 2020 16:25:30 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To: Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
        Mike Snitzer <msnitzer@redhat.com>
Subject: Optane nvdimm performance
Message-ID: <alpine.LRH.2.02.2003291116490.9236@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Message-ID-Hash: FOAFXBQDEHYBEQ2QHTYYT5UGLP2WK3O6
X-Message-ID-Hash: FOAFXBQDEHYBEQ2QHTYYT5UGLP2WK3O6
X-MailFrom: mpatocka@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, dm-devel@redhat.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FOAFXBQDEHYBEQ2QHTYYT5UGLP2WK3O6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi

I performed some microbenchmarks on a system with real Optane-based nvdimm 
and I found out that the fastest method how to write to persistent memory 
is to fill a cacheline with 8 8-byte writes and then issue clwb or 
clflushopt on the cacheline. With this method, we can achieve 1.6 GB/s 
throughput for linear writes. On the other hand, non-temporal writes 
achieve only 1.3 GB/s.

The results are here:
http://people.redhat.com/~mpatocka/testcases/pmem/microbenchmarks/pmem.txt

The benchmarks here:
http://people.redhat.com/~mpatocka/testcases/pmem/microbenchmarks/

The winning benchmark is this:
http://people.redhat.com/~mpatocka/testcases/pmem/microbenchmarks/thrp-write-8-clwb.c


However, the kernel is not using this fastest method, it is using 
non-temporal stores instead.


I took the novafs filesystem (see git clone 
https://github.com/NVSL/linux-nova), it uses 
__copy_from_user_inatomic_nocache, which calls __copy_user_nocache which 
performs non-temporal stores. I hacked __copy_user_nocache to use clwb 
instead of non-temporal stores and it improved filesystem performance 
significantly.

This is the patch
http://people.redhat.com/~mpatocka/testcases/pmem/benchmarks/copy-nocache.patch 
(for the kernel 5.1 because novafs needs this version) and these are 
benchmark results:
http://people.redhat.com/~mpatocka/testcases/pmem/benchmarks/fs-bench.txt

- you can see that "test2" has twice the write throughput of "test1"


I took the dm-writecache driver, it uses memcpy_flushcache to write data 
to persistent memory. I hacked memcpy_flushcache to use clwb instead of 
non-temporal stores.

The result is - for 512-byte writes, non-temporal stores perform better 
than cache flushing. For 1024-byte and larger writes, cache flushing 
performs better than non-temporal stores. (I also tried to use cached 
writes + clwb for dm-writecache metadata updates, but it had bad 
performance)


Do you have some explanation why nontemporal stores are better for 
512-byte copies and worse for 1024-byte copies? (like filling up some 
buffers inside the CPU)?

In the next email, I'm sending a patch that makes memcpy_flushcache use 
clflushopt for transfers larger than 768 bytes.


Mikulas
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
