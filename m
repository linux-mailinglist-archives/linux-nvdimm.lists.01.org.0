Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEB6312730
	for <lists+linux-nvdimm@lfdr.de>; Sun,  7 Feb 2021 20:23:15 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C875E100EBB7B;
	Sun,  7 Feb 2021 11:23:13 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 155EB100EBB62
	for <linux-nvdimm@lists.01.org>; Sun,  7 Feb 2021 11:23:10 -0800 (PST)
Received: by mail.kernel.org (Postfix) with ESMTPS id AC23D64E3A;
	Sun,  7 Feb 2021 19:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1612725789;
	bh=IeP1OvJ/k8x8gikOH5SEUORTPYx4qLXqVQVQFSsRFhs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Jok/F8hus0w+lI/pk6NY5unYbH9BETlJf84sibD7pwN2m3bUi08GWmqBrYet4Dlig
	 3o9AINusWTpxCCP5P9xkqNL0wURU0d2CghEdYDTZ5Sgl/OOSpIikT8EMkRgvFXl6Dr
	 4TjBFlsqPk89OOm5nQ9L0HqeOyNo/PSwa0xmTWNBKt8D8anSnyVIIlUx4YfyDjrWzH
	 Jc7qhVfpdUezfZmWoyva3SehDSSAFJnlh5K1edtdBVb0NNIYh8HmMXRau2vM2VZIYQ
	 6sYdV83Fwr9L//u0pZ17zuZPX7Wlbbx2+Cb2P2XzF2rS0yzm7IeTSnDB4YBB+9smS2
	 jackFgYAhYuuQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9BD0060A0E;
	Sun,  7 Feb 2021 19:23:09 +0000 (UTC)
Subject: Re: [GIT PULL] libnvdimm fixes for v5.11-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4j++J_ra8zWkvVovmwmYCERp8vKsVSZn9x4PYGoJa-XOA@mail.gmail.com>
References: <CAPcyv4j++J_ra8zWkvVovmwmYCERp8vKsVSZn9x4PYGoJa-XOA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPcyv4j++J_ra8zWkvVovmwmYCERp8vKsVSZn9x4PYGoJa-XOA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-fixes-5.11-rc7
X-PR-Tracked-Commit-Id: 7018c897c2f243d4b5f1b94bc6b4831a7eab80fb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b75dba7f472ca6c2dd0b8ee41f5a4b5a45539306
Message-Id: <161272578963.18997.13576347206696291411.pr-tracker-bot@kernel.org>
Date: Sun, 07 Feb 2021 19:23:09 +0000
To: Dan Williams <dan.j.williams@intel.com>
Message-ID-Hash: IX77IEAOUSMB2CS6H5ZAUXXTSFBNKOTE
X-Message-ID-Hash: IX77IEAOUSMB2CS6H5ZAUXXTSFBNKOTE
X-MailFrom: pr-tracker-bot@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Linus Torvalds <torvalds@linux-foundation.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IX77IEAOUSMB2CS6H5ZAUXXTSFBNKOTE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The pull request you sent on Sun, 7 Feb 2021 09:37:21 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-fixes-5.11-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b75dba7f472ca6c2dd0b8ee41f5a4b5a45539306

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
