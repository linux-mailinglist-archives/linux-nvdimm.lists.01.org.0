Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8E626C8BD
	for <lists+linux-nvdimm@lfdr.de>; Wed, 16 Sep 2020 20:56:51 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D01E014DF578B;
	Wed, 16 Sep 2020 11:56:49 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.205.24.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mpatocka@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 147421462EC60
	for <linux-nvdimm@lists.01.org>; Wed, 16 Sep 2020 11:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1600282606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RskhOddlyzxn2O1hiGiO8qkIeVUodbG095OhCxUszWY=;
	b=hMFEdL3cyOid+2xH9cNYyUI7CjAd/IGXWtGOI13YB/rKNOfYKpDkxNiOdwfxdjZXEmNLrs
	8gNVuIldeRrkJKmcdDTrv1BKAuhOuBugODVgxIptAaahJceR9+gEX/0xD7ZmA/0YGNqTVs
	7mUPz6IlHRV9FDM7yk5eH2Xub3SRHxI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-kILKsbndN-GspIYu-UxDow-1; Wed, 16 Sep 2020 14:56:42 -0400
X-MC-Unique: kILKsbndN-GspIYu-UxDow-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33309873081;
	Wed, 16 Sep 2020 18:56:40 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DD88C5C22D;
	Wed, 16 Sep 2020 18:56:39 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
	by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 08GIudmJ025956;
	Wed, 16 Sep 2020 14:56:39 -0400
Received: from localhost (mpatocka@localhost)
	by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 08GIuc6o025952;
	Wed, 16 Sep 2020 14:56:39 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date: Wed, 16 Sep 2020 14:56:38 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH] pmem: fix __copy_user_flushcache
In-Reply-To: <CAPcyv4gD0ZFkfajKTDnJhEEjf+5Av-GH+cHRFoyhzGe8bNEgAA@mail.gmail.com>
Message-ID: <alpine.LRH.2.02.2009161451140.21915@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2009140852030.22422@file01.intranet.prod.int.rdu2.redhat.com> <CAPcyv4gh=QaDB61_9_QTgtt-pZuTFdR6td0orE0VMH6=6SA2vw@mail.gmail.com> <alpine.LRH.2.02.2009151216050.16057@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009151332280.3851@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2009160649560.20720@file01.intranet.prod.int.rdu2.redhat.com> <CAPcyv4gW6AvR+RaShHdQzOaEPv9nrq5myXDmywuoCTYDZxk-hw@mail.gmail.com>
 <alpine.LRH.2.02.2009161254400.745@file01.intranet.prod.int.rdu2.redhat.com> <CAPcyv4gD0ZFkfajKTDnJhEEjf+5Av-GH+cHRFoyhzGe8bNEgAA@mail.gmail.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Message-ID-Hash: OQBXGLKHYWFFDJ32O6QTIBQJNUYSDHU2
X-Message-ID-Hash: OQBXGLKHYWFFDJ32O6QTIBQJNUYSDHU2
X-MailFrom: mpatocka@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, Eric Sandeen <esandeen@redhat.com>, Dave Chinner <dchinner@redhat.com>, "Tadakamadla, Rajesh (DCIG/CDI/HPS Perf)" <rajesh.tadakamadla@hpe.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OQBXGLKHYWFFDJ32O6QTIBQJNUYSDHU2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Wed, 16 Sep 2020, Dan Williams wrote:

> On Wed, Sep 16, 2020 at 10:24 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
> >
> >
> >
> > On Wed, 16 Sep 2020, Dan Williams wrote:
> >
> > > On Wed, Sep 16, 2020 at 3:57 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
> > > >
> > > >
> > > >
> > > > I'm submitting this patch that adds the required exports (so that we could
> > > > use __copy_from_user_flushcache on x86, arm64 and powerpc). Please, queue
> > > > it for the next merge window.
> > >
> > > Why? This should go with the first user, and it's not clear that it
> > > needs to be relative to the current dax_operations export scheme.
> >
> > Before nvfs gets included in the kernel, I need to distribute it as a
> > module. So, it would make my maintenance easier. But if you don't want to
> > export it now, no problem, I can just copy __copy_user_flushcache from the
> > kernel to the module.
> 
> That sounds a better plan than exporting symbols with no in-kernel consumer.

BTW, this function is buggy. Here I'm submitting the patch.



From: Mikulas Patocka <mpatocka@redhat.com>

If we copy less than 8 bytes and if the destination crosses a cache line,
__copy_user_flushcache would invalidate only the first cache line. This
patch makes it invalidate the second cache line as well.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org

---
 arch/x86/lib/usercopy_64.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/arch/x86/lib/usercopy_64.c
===================================================================
--- linux-2.6.orig/arch/x86/lib/usercopy_64.c	2020-09-05 10:01:27.000000000 +0200
+++ linux-2.6/arch/x86/lib/usercopy_64.c	2020-09-16 20:48:31.000000000 +0200
@@ -120,7 +120,7 @@ long __copy_user_flushcache(void *dst, c
 	 */
 	if (size < 8) {
 		if (!IS_ALIGNED(dest, 4) || size != 4)
-			clean_cache_range(dst, 1);
+			clean_cache_range(dst, size);
 	} else {
 		if (!IS_ALIGNED(dest, 8)) {
 			dest = ALIGN(dest, boot_cpu_data.x86_clflush_size);
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
