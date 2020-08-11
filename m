Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FD4242145
	for <lists+linux-nvdimm@lfdr.de>; Tue, 11 Aug 2020 22:27:26 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D4D5F12EC927B;
	Tue, 11 Aug 2020 13:27:23 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id F1BE112EBFEA4
	for <linux-nvdimm@lists.01.org>; Tue, 11 Aug 2020 13:27:20 -0700 (PDT)
Subject: Re: [GIT PULL] libnvdimm for v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597177640;
	bh=qSJ2hmDn6wJ1ZrKTulfts5iP7n/kImdSr4MJJ3oLLMk=;
	h=From:In-Reply-To:References:Date:To:Cc:From;
	b=KgZ0PNH5FYPqQ4Dj5Nn9OOHe77bFZpCAMmiR3/dc9HPOU8Y8rOr33sYOxpDSF6Itf
	 7PL1K8ff5WdIrNzQhoCQAntnVfkk+foJhL7g4AFTcE5pFabIrzVdCVFR/aiZCgpAZ7
	 jtA3f4ihg/7u6qr7oJeOQEoseXj4VssoLbMdtwV4=
From: pr-tracker-bot@kernel.org
In-Reply-To: <f44b21c38313fa8e19a3e70eb285e0dd319eb421.camel@intel.com>
References: <f44b21c38313fa8e19a3e70eb285e0dd319eb421.camel@intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <f44b21c38313fa8e19a3e70eb285e0dd319eb421.camel@intel.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git/ tags/libnvdimm-for-5.9
X-PR-Tracked-Commit-Id: 7f674025d9f7321dea11b802cc0ab3f09cbe51c5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4bf5e3611895ede257d736b7359db669879a109f
Message-Id: <159717764041.9233.3951429619218554065.pr-tracker-bot@kernel.org>
Date: Tue, 11 Aug 2020 20:27:20 +0000
To: "Verma, Vishal L" <vishal.l.verma@intel.com>
Message-ID-Hash: WVTIU5IDO7JPOE2VWOKQGR7Y6VWKGUQR
X-Message-ID-Hash: WVTIU5IDO7JPOE2VWOKQGR7Y6VWKGUQR
X-MailFrom: pr-tracker-bot@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WVTIU5IDO7JPOE2VWOKQGR7Y6VWKGUQR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The pull request you sent on Tue, 11 Aug 2020 01:20:48 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git/ tags/libnvdimm-for-5.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4bf5e3611895ede257d736b7359db669879a109f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
