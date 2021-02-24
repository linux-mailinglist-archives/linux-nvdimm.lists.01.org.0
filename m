Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8DD3243EC
	for <lists+linux-nvdimm@lfdr.de>; Wed, 24 Feb 2021 19:46:34 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0B96E100ED4BF;
	Wed, 24 Feb 2021 10:46:31 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DC1C8100ED4AE
	for <linux-nvdimm@lists.01.org>; Wed, 24 Feb 2021 10:46:28 -0800 (PST)
Received: by mail.kernel.org (Postfix) with ESMTPS id 2326C64F0D;
	Wed, 24 Feb 2021 18:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1614192388;
	bh=FrQixc8e3rZo/OEW1ahxLjAM38zkv7Y4pqS9ZqgfZlM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=AhW6kbqKV/lbu583tecQWjEh+TLQ/wQej38W/Fb/QxRVhKVri+y3rNvURqyAppquP
	 QHT7UZlq0YAzxNqmWZVZxKMRCGrvBIa5tSp+N1pE4vvYm2gxYCjCgFxS6jwh4SX0y0
	 We6v6WnT3cqBIv9JcItV2yBCGOPw4jlPQHHQU8/8j4hbdgqQ9pw7sKifn7AnBdRaTc
	 lOpmbZAez5jtqYXViUH/v8DcQJ7V72XLBPmwOuZNoqAGCSsYKeDLE880DXpwABg1GV
	 6yoKyWK15Rl52sOghGFr4h8MM3TP9Ke0yhdlfL99Nq6MpdOLaKkpqOFoHDH9SY3lec
	 jCCOY8Ofiz4zw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 0665F60176;
	Wed, 24 Feb 2021 18:46:28 +0000 (UTC)
Subject: Re: [GIT PULL] Compute Express Linux (CXL) for v5.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4gsXbi6Cc71wW5hob8mGuupXKkL5tHLRaZkdLZ1oAuK8Q@mail.gmail.com>
References: <CAPcyv4gsXbi6Cc71wW5hob8mGuupXKkL5tHLRaZkdLZ1oAuK8Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cxl.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPcyv4gsXbi6Cc71wW5hob8mGuupXKkL5tHLRaZkdLZ1oAuK8Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/cxl-for-5.12
X-PR-Tracked-Commit-Id: 88ff5d466c0250259818f3153dbdc4af1f8615dd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 825d1508750c0cad13e5da564d47a6d59c7612d6
Message-Id: <161419238797.20610.4661050005924774981.pr-tracker-bot@kernel.org>
Date: Wed, 24 Feb 2021 18:46:27 +0000
To: Dan Williams <dan.j.williams@intel.com>
Message-ID-Hash: KTL6NUWTYNFR377RXEXPZZXNURTGY6K3
X-Message-ID-Hash: KTL6NUWTYNFR377RXEXPZZXNURTGY6K3
X-MailFrom: pr-tracker-bot@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Linus Torvalds <torvalds@linux-foundation.org>, linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KTL6NUWTYNFR377RXEXPZZXNURTGY6K3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The pull request you sent on Tue, 23 Feb 2021 20:05:36 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/cxl-for-5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/825d1508750c0cad13e5da564d47a6d59c7612d6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
