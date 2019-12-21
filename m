Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F48128BD7
	for <lists+linux-nvdimm@lfdr.de>; Sun, 22 Dec 2019 00:20:12 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1140C1011368F;
	Sat, 21 Dec 2019 15:23:31 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D8C6E1011368C
	for <linux-nvdimm@lists.01.org>; Sat, 21 Dec 2019 15:23:29 -0800 (PST)
Subject: Re: [GIT PULL] libnvdimm fix for v5.5-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576970409;
	bh=7fbGfoEJtFS0Sef1e8X5drdSmP96+Xjn9/xIHrZW6Ps=;
	h=From:In-Reply-To:References:Date:To:Cc:From;
	b=BqXnIFoHU2zbEifs0Q/FMNSVssxSyEdl7IcjhDDgfJm+HbVvnY+p1Gxq/qK4bcKE6
	 Hp9OALzIQYHLH4Un6vX9ZoqQTSqfJIhlkyeIDffJPzGheUcIZwVhV/ATBvZZB7RnCW
	 gvMEwXE2hmrQJMyEqLxrxsSOmOJVuvRD+P15p2NQ=
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4gfbuttbdW0ea6EUzMihUK33cc0mBQmLjqZe1T_QCKF-Q@mail.gmail.com>
References: <CAPcyv4gfbuttbdW0ea6EUzMihUK33cc0mBQmLjqZe1T_QCKF-Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPcyv4gfbuttbdW0ea6EUzMihUK33cc0mBQmLjqZe1T_QCKF-Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
 tags/libnvdimm-fix-5.5-rc3
X-PR-Tracked-Commit-Id: c1468554776229d0db69e74a9aaf6f7e7095fd51
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4746104a6f599f213c3d97d8c39032953fd4580f
Message-Id: <157697040940.14543.13427891455993675175.pr-tracker-bot@kernel.org>
Date: Sat, 21 Dec 2019 23:20:09 +0000
To: Dan Williams <dan.j.williams@intel.com>
Message-ID-Hash: GYO6FMBJMGMKV4EO35MFQRLIIDKKZGQ5
X-Message-ID-Hash: GYO6FMBJMGMKV4EO35MFQRLIIDKKZGQ5
X-MailFrom: pr-tracker-bot@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GYO6FMBJMGMKV4EO35MFQRLIIDKKZGQ5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The pull request you sent on Sat, 21 Dec 2019 13:07:20 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-fix-5.5-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4746104a6f599f213c3d97d8c39032953fd4580f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
