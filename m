Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8BE275E79
	for <lists+linux-nvdimm@lfdr.de>; Wed, 23 Sep 2020 19:19:54 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5892C151D34B2;
	Wed, 23 Sep 2020 10:19:52 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=63.128.21.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mpatocka@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [63.128.21.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 14F19151D3498
	for <linux-nvdimm@lists.01.org>; Wed, 23 Sep 2020 10:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1600881588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZAwjKYHLvX7CV9LXjpmU9CFTSk3gBA0Z/UIj2jnpmK8=;
	b=MtC5MxF/ZCduDHq4M10ai9WkSMQMOB2McEHLngBPCLISwUmbVLm6C9cYBTE09okfr+YOej
	0AfogfKhpqZqkETlFNBbmPqoaoZLXnpzuzyFes4rZd8Wp31p2ID8E0J8ppaYIdLTJin613
	dZskjZyD8MRlECItnaHyL3YtbknanO0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-1LsOWFgnOlmg5st1mkkATQ-1; Wed, 23 Sep 2020 13:19:46 -0400
X-MC-Unique: 1LsOWFgnOlmg5st1mkkATQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60228107464E;
	Wed, 23 Sep 2020 17:19:44 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F1241972B;
	Wed, 23 Sep 2020 17:19:44 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
	by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 08NHJhRP016496;
	Wed, 23 Sep 2020 13:19:43 -0400
Received: from localhost (mpatocka@localhost)
	by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 08NHJgdZ016492;
	Wed, 23 Sep 2020 13:19:42 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date: Wed, 23 Sep 2020 13:19:42 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To: Dave Chinner <david@fromorbit.com>
Subject: Re: NVFS XFS metadata (was: [PATCH] pmem: export the symbols
 __copy_user_flushcache and __copy_from_user_flushcache)
In-Reply-To: <20200923024528.GD12096@dread.disaster.area>
Message-ID: <alpine.LRH.2.02.2009230445030.1800@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2009151216050.16057@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2009151332280.3851@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2009160649560.20720@file01.intranet.prod.int.rdu2.redhat.com>
 <CAPcyv4gW6AvR+RaShHdQzOaEPv9nrq5myXDmywuoCTYDZxk-hw@mail.gmail.com> <alpine.LRH.2.02.2009161254400.745@file01.intranet.prod.int.rdu2.redhat.com> <CAPcyv4gD0ZFkfajKTDnJhEEjf+5Av-GH+cHRFoyhzGe8bNEgAA@mail.gmail.com> <alpine.LRH.2.02.2009161359540.20710@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009191336380.3478@file01.intranet.prod.int.rdu2.redhat.com> <20200922050314.GB12096@dread.disaster.area> <alpine.LRH.2.02.2009220815420.16480@file01.intranet.prod.int.rdu2.redhat.com> <20200923024528.GD12096@dread.disaster.area>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Message-ID-Hash: TMV6RE63DMTFLBXPDL2MTWUZABZZGUV5
X-Message-ID-Hash: TMV6RE63DMTFLBXPDL2MTWUZABZZGUV5
X-MailFrom: mpatocka@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, Eric Sandeen <esandeen@redhat.com>, Dave Chinner <dchinner@redhat.com>, "Tadakamadla, Rajesh (DCIG/CDI/HPS Perf)" <rajesh.tadakamadla@hpe.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TMV6RE63DMTFLBXPDL2MTWUZABZZGUV5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Wed, 23 Sep 2020, Dave Chinner wrote:

> > > dir-test /mnt/test/linux-2.6 63000 1048576
> > > nvfs		6.6s
> > > ext4 dax	8.4s
> > > xfs dax		12.2s
> > > 
> > > 
> > > dir-test /mnt/test/linux-2.6 63000 1048576 link
> > > nvfs		4.7s
> > > ext4 dax	5.6s
> > > xfs dax		7.8s
> > > 
> > > dir-test /mnt/test/linux-2.6 63000 1048576 dir
> > > nvfs		8.2s
> > > ext4 dax	15.1s
> > > xfs dax		11.8s
> > > 
> > > Yes, nvfs is faster than both ext4 and XFS on DAX, but it's  not a
> > > huge difference - it's not orders of magnitude faster.
> > 
> > If I increase the size of the test directory, NVFS is order of magnitude 
> > faster:
> > 
> > time dir-test /mnt/test/ 2000000 2000000
> > NVFS: 0m29,395s
> > XFS:  1m59,523s
> > EXT4: 1m14,176s
> 
> What happened to NVFS there? The runtime went up by a factor of 5,
> even though the number of ops performed only doubled.

This test is from a different machine (K10 Opteron) than the above test 
(Skylake Xeon). I borrowed the Xeon for a short time and I no longer have 
access to it.

> > time dir-test /mnt/test/ 8000000 8000000
> > NVFS: 2m13,507s
> > XFS: 14m31,261s
> > EXT4: reports "file 1976882 can't be created: No space left on device", 
> > 	(although there are free blocks and inodes)
> > 	Is it a bug or expected behavior?
> 
> Exponential increase in runtime for a workload like this indicates
> the XFS journal is too small to run large scale operations. I'm
> guessing you're just testing on a small device?

In this test, the pmem device had 64GiB.

I've created 1TiB ramdisk, formatted it with XFS and ran dir-test 8000000 
on it, however it wasn't much better - it took 14m8,824s.

> In which case, you'd get a 16MB log for XFS, which is tiny and most
> definitely will limit performance of any large scale metadta
> operation. Performance should improve significantly for large scale
> operations with a much larger log, and that should bring the XFS
> runtimes down significantly.

Is there some mkfs.xfs option that can increase log size?

> > If you think that the lack of journaling is show-stopper, I can implement 
> > it.
> 
> I did not say that. My comments are about the requirement for
> atomicity of object changes, not journalling. Journalling is an
> -implementation that can provide change atomicity-, it is not a
> design constraint for metadata modification algorithms.
> 
> Really, you can chose how to do object update however you want. What
> I want to review is the design documentation and a correctness proof
> for whatever mechanism you choose to use. Without that information,
> we have absolutely no chance of reviewing the filesystem
> implementation for correctness. We don't need a proof for something
> that uses journalling (because we all know how that works), but for
> something that uses soft updates we most definitely need the proof
> of correctness for the update algorithm before we can determine if
> the implementation is good...
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com

I am thinking about this: I can implement lightweight journaling that will 
journal just a few writes - I'll allocate some small per-cpu intent log 
for that.

For example, in nvfs_rename, we call nvfs_delete_de and nvfs_finish_add - 
these functions are very simple, both of them write just one word - so we 
can add these two words to the intent log. The same for setattr requesting 
simultaneous uid/gid/mode change - they are small, so they'll fit into the 
intent log well.

Regarding verifiability, I can do this - the writes to pmem are wrapped in 
a macro nv_store. So, I can modify this macro so that it logs all 
modifications. Then I take the log, cut it at random time, reorder the 
entries (to simulate reordering in the CPU write-combining buffers), 
replay it, run nvfsck on it and mount it. This way, we can verify that no 
matter where the crash happened, either an old file or a new file is 
present in a directory.

Do you agree with that?

Mikulas
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
