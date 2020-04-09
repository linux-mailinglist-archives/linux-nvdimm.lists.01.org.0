Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E61471A2E9E
	for <lists+linux-nvdimm@lfdr.de>; Thu,  9 Apr 2020 06:55:32 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3A1AD10113FCF;
	Wed,  8 Apr 2020 21:56:20 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5F37410113FCE
	for <linux-nvdimm@lists.01.org>; Wed,  8 Apr 2020 21:56:18 -0700 (PDT)
Subject: Re: [GIT PULL] libnvdimm for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586408129;
	bh=6mJu0lpATwQDPBEXpJ7mTTCHiScjfJP5BkbsCBkxF30=;
	h=From:In-Reply-To:References:Date:To:Cc:From;
	b=nMkVIZbKdATk1otDcBPX6ZZ7LWRg6LAw4XuwOeGcDUkqhP8+2RELcN843OzdVLggH
	 dZPy6gx4RUjOO9CpyNSlLdfWZBp5RcD4xeYMszU2PdGHn3JOfFdxM+9kLD639zATZ5
	 I79G+kbLvX5OWK1UPeo3XzS4rUCTUoqIixu1znwA=
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4gKr57qNnMEupjcjQmH9Vy_iZuLPE1VA36QAkKhzEbzSA@mail.gmail.com>
References: <CAPcyv4gKr57qNnMEupjcjQmH9Vy_iZuLPE1VA36QAkKhzEbzSA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPcyv4gKr57qNnMEupjcjQmH9Vy_iZuLPE1VA36QAkKhzEbzSA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
 tags/libnvdimm-for-5.7
X-PR-Tracked-Commit-Id: f6d2b802f80d0ca89ee1f51c1781b3f79cdb25d5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9b06860d7c1f1f4cb7d70f92e47dfa4a91bd5007
Message-Id: <158640812899.3202.9422311262435999632.pr-tracker-bot@kernel.org>
Date: Thu, 09 Apr 2020 04:55:28 +0000
To: Dan Williams <dan.j.williams@intel.com>
Message-ID-Hash: ZDMICU4ERKRMABWV4ZRVTBJQRU5UYKBA
X-Message-ID-Hash: ZDMICU4ERKRMABWV4ZRVTBJQRU5UYKBA
X-MailFrom: pr-tracker-bot@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Linus Torvalds <torvalds@linux-foundation.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZDMICU4ERKRMABWV4ZRVTBJQRU5UYKBA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The pull request you sent on Tue, 7 Apr 2020 13:12:41 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-for-5.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9b06860d7c1f1f4cb7d70f92e47dfa4a91bd5007

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
