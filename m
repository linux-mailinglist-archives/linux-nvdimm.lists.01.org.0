Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9679734F63B
	for <lists+linux-nvdimm@lfdr.de>; Wed, 31 Mar 2021 03:30:57 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C4029100EB857;
	Tue, 30 Mar 2021 18:30:54 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::235; helo=mail-oi1-x235.google.com; envelope-from=hughd@google.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A4D41100EB855
	for <linux-nvdimm@lists.01.org>; Tue, 30 Mar 2021 18:30:52 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id i3so18448840oik.7
        for <linux-nvdimm@lists.01.org>; Tue, 30 Mar 2021 18:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=KQ4UhoRuOYIePIQ52r8+aVrhFWUe79SfbbimcSIL+Nc=;
        b=lQx2TYvo3z4/Y4K/aqMjcHcRs6Wma0Bb6oKkFH9AIxVw34/QBkIzCjYOs0bfDw9izS
         j1yelFrahfno18c3R6rrJk6pF/aghxdTt32ikGRWmoIeGuL1FnH3bw88C0HBHj3J2wvI
         TgIVA8/qZhNr9ivGIfA0FP4+jByBTuc+2bJFmHQXY3YO5ZJ3u4Lcob2X4H0T/y+BqOgg
         F7pFfydHBC4to4A5RcWZYzWCIelEUmAD45atU/J84syxq3vRvFaUZ4ydNwKEJMWxYA8M
         T9fIxBg84kK59o8yCDeArwA9HIijk+I9//OcqphHVpWlrHFh4StWLqFZScfmE86NpUVB
         +rgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=KQ4UhoRuOYIePIQ52r8+aVrhFWUe79SfbbimcSIL+Nc=;
        b=txpFRoZvXAoY5R+/a8VLZ+BZDBaTJ+Kzwfyw6sDWRu9CtPHxNkPYRrxJw1NpOhKagP
         7kXSoVqD5B1WIAAfs/BQuPqwuZsTMI8un4MIZdkYa5vHeEh++Nj2yQ0X6o9Ys7ikoJst
         EzpbeqHh5Ezch0Z4lDOr9ZADlVngfSeuhhzpN3YRajdE1NT1RzjK55xpXqfrM0PcNfPH
         XcT9EY47XIW+2z4gxG/Zzq/DyWWQxqK4kUPycOOPItoWKAlMYO/8IVs3dgjZ6o8QxnTV
         0JZ04+H0Rh119RxZz9E6wSDhscwoAVUPBG/8P7fFq3HWG4PbS0l7lZnwiDsFlHycI0oq
         hZ2w==
X-Gm-Message-State: AOAM532DdC8VuzW65t2EPl1xnIRLMBDO97/k1Jus0y2ySVXtBGdK+pgy
	1+ExWlq+GclfkYfYNU3QXWySHg==
X-Google-Smtp-Source: ABdhPJzgATn5d/xGPP8lN0hUfrUaP2MzX9O5uWPP80RgZEGYBVqB4ER4X7Jo2RE+R3sVH8Ekz00hSQ==
X-Received: by 2002:a05:6808:5cb:: with SMTP id d11mr502740oij.169.1617154251409;
        Tue, 30 Mar 2021 18:30:51 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id g11sm141653ots.34.2021.03.30.18.30.50
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 30 Mar 2021 18:30:51 -0700 (PDT)
Date: Tue, 30 Mar 2021 18:30:22 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To: Matthew Wilcox <willy@infradead.org>
Subject: BUG_ON(!mapping_empty(&inode->i_data))
Message-ID: <alpine.LSU.2.11.2103301654520.2648@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Message-ID-Hash: QLOYBWYWDHHXDTLS3XEGXMLUL4VA7A52
X-Message-ID-Hash: QLOYBWYWDHHXDTLS3XEGXMLUL4VA7A52
X-MailFrom: hughd@google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QLOYBWYWDHHXDTLS3XEGXMLUL4VA7A52/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Running my usual tmpfs kernel builds swapping load, on Sunday's rc4-mm1
mmotm (I never got to try rc3-mm1 but presume it behaved the same way),
I hit clear_inode()'s BUG_ON(!mapping_empty(&inode->i_data)); on two
machines, within an hour or few, repeatably though not to order.

The stack backtrace has always been clear_inode < ext4_clear_inode <
ext4_evict_inode < evict < dispose_list < prune_icache_sb <
super_cache_scan < do_shrink_slab < shrink_slab_memcg < shrink_slab <
shrink_node_memgs < shrink_node < balance_pgdat < kswapd.

ext4 is the disk filesystem I read the source to build from, and also
the filesystem I use on a loop device on a tmpfs file: I have not tried
with other filesystems, nor checked whether perhaps it happens always on
the loop one or always on the disk one.  I have not seen it happen with
tmpfs - probably because its inodes cannot be evicted by the shrinker
anyway; I have not seen it happen when "rm -rf" evicts ext4 or tmpfs
inodes (but suspect that may be down to timing, or less pressure).
I doubt it's a matter of filesystem: think it's an XArray thing.

Whenever I've looked at the XArray nodes involved, the root node
(shift 6) contained one or three (adjacent) pointers to empty shift
0 nodes, which each had offset and parent and array correctly set.
Is there some way in which empty nodes can get left behind, and so
fail eviction's mapping_empty() check?

I did wonder whether some might get left behind if xas_alloc() fails
(though probably the tree here is too shallow to show that).  Printks
showed that occasionally xas_alloc() did fail while testing (maybe at
memcg limit), but there was no correlation with the BUG_ONs.

I did wonder whether this is a long-standing issue, which your new
BUG_ON is the first to detect: so tried 5.12-rc5 clear_inode() with
a BUG_ON(!xa_empty(&inode->i_data.i_pages)) after its nrpages and
nrexceptional BUG_ONs.  The result there surprised me: I expected
it to behave the same way, but it hits that BUG_ON in a minute or
so, instead of an hour or so.  Was there a fix you made somewhere,
to avoid the BUG_ON(!mapping_empty) most of the time? but needs
more work. I looked around a little, but didn't find any.

I had hoped to work this out myself, and save us both some writing:
but better hand over to you, in the hope that you'll quickly guess
what's up, then I can try patches. I do like the no-nrexceptionals
series, but there's something still to be fixed.

Hugh
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
