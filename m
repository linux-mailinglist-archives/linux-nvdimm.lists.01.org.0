Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 342782990E2
	for <lists+linux-nvdimm@lfdr.de>; Mon, 26 Oct 2020 16:19:09 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 07799161A7F31;
	Mon, 26 Oct 2020 08:19:08 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DF2ED161A7F31
	for <linux-nvdimm@lists.01.org>; Mon, 26 Oct 2020 08:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=tJdlcdGVmO5hb1GVldhbnE4FaImFjKkuAuz1KFFasXY=; b=DWQfni3dYUpdPMXkGjThM7VqH8
	6kijMsd/J434O8lkAqUkW9kCPSPbHrN1t2J6mQuPrQo+69/7r63fSVEopoRZjxYjNoCPGVGD6AJfO
	Ox/o4C++Xv0glhBB/Ytl/w2piiG5HglNneRFupXuwvlhVXrikRPSjwp105nFcZ9T1vLh3r8mrH5jQ
	gjh439PddBlQm1htBsBE0zPyc820WMwlf6W7PZXnZk9TOoO2/HSUKazSvfSsNy7QZu6JE+sIjR59w
	HuGHnbL0JYFjoWziJtq74gxzTxqYFPMQ85HIhnw5xIFRm5yGKl4j4Z7DVhXnn+9X05Ir+8fobVEkJ
	crWmwBWQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kX4Gp-0006Jr-3D; Mon, 26 Oct 2020 15:18:51 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-mm@kvack.org
Subject: [PATCH v2 0/4] Remove nrexceptional tracking
Date: Mon, 26 Oct 2020 15:18:45 +0000
Message-Id: <20201026151849.24232-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Message-ID-Hash: MFKT43OZ5F4AHIMTG4DHX2YR25E2LWLJ
X-Message-ID-Hash: MFKT43OZ5F4AHIMTG4DHX2YR25E2LWLJ
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MFKT43OZ5F4AHIMTG4DHX2YR25E2LWLJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

We actually use nrexceptional for very little these days.  It's a minor
pain to keep in sync with nrpages, but the pain becomes much bigger
with the THP patches because we don't know how many indices a shadow
entry occupies.  It's easier to just remove it than keep it accurate.

Also, we save 8 bytes per inode which is nothing to sneeze at; on my
laptop, it would improve shmem_inode_cache from 22 to 23 objects per
16kB, and inode_cache from 26 to 27 objects.  Combined, that saves
a megabyte of memory from a combined usage of 25MB for both caches.
Unfortunately, ext4 doesn't cross a magic boundary, so it doesn't save
any memory for ext4.

Matthew Wilcox (Oracle) (4):
  mm: Introduce and use mapping_empty
  mm: Stop accounting shadow entries
  dax: Account DAX entries as nrpages
  mm: Remove nrexceptional from inode

 fs/block_dev.c          |  2 +-
 fs/dax.c                |  8 ++++----
 fs/gfs2/glock.c         |  3 +--
 fs/inode.c              |  2 +-
 include/linux/fs.h      |  2 --
 include/linux/pagemap.h |  5 +++++
 mm/filemap.c            | 16 ----------------
 mm/swap_state.c         |  4 ----
 mm/truncate.c           | 19 +++----------------
 mm/workingset.c         |  1 -
 10 files changed, 15 insertions(+), 47 deletions(-)

-- 
2.28.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
