Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C27E59A3
	for <lists+linux-nvdimm@lfdr.de>; Sat, 26 Oct 2019 12:45:10 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A52D7100EA601;
	Sat, 26 Oct 2019 03:46:15 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id F163E100EEBAC
	for <linux-nvdimm@lists.01.org>; Sat, 26 Oct 2019 03:46:12 -0700 (PDT)
Subject: Re: [GIT PULL] dax fix for v5.4-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572086705;
	bh=Vyc5SB0hiZdfFvAUsjm2Khzs8PKzyK7s7Xp2S38xRQ4=;
	h=From:In-Reply-To:References:Date:To:Cc:From;
	b=cAP4YFJGe8xirFgBYnuBEHyw8wdAEoA9VJ6mvAMV3pSDHpXjNFyoYYZmUO1ys9/Na
	 /ow8284V3XQTHk5TgXut1ZWqPvH68kyV/q83JSGBT04/2XY0G9atPuayW0IPNTfnsN
	 5zrXCc3I/1FLfuF7jVM0yzm5Goj0QqMrwF4dQ70Q=
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4gi--MyxXOt-vb4Tw+ku=jUYmo4y+YSV+6UJf24BCDAMA@mail.gmail.com>
References: <CAPcyv4gi--MyxXOt-vb4Tw+ku=jUYmo4y+YSV+6UJf24BCDAMA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPcyv4gi--MyxXOt-vb4Tw+ku=jUYmo4y+YSV+6UJf24BCDAMA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
 tags/dax-fix-5.4-rc5
X-PR-Tracked-Commit-Id: 6370740e5f8ef12de7f9a9bf48a0393d202cd827
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 485fc4b69cd28f295947535175c147b943b0b2e4
Message-Id: <157208670550.20302.9647429553317188107.pr-tracker-bot@kernel.org>
Date: Sat, 26 Oct 2019 10:45:05 +0000
To: Dan Williams <dan.j.williams@intel.com>
Message-ID-Hash: BH3VT2T6JB3632F7BOTP4WPDS2V4GHCO
X-Message-ID-Hash: BH3VT2T6JB3632F7BOTP4WPDS2V4GHCO
X-MailFrom: pr-tracker-bot@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Linus Torvalds <torvalds@linux-foundation.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BH3VT2T6JB3632F7BOTP4WPDS2V4GHCO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The pull request you sent on Fri, 25 Oct 2019 18:06:22 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/dax-fix-5.4-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/485fc4b69cd28f295947535175c147b943b0b2e4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
