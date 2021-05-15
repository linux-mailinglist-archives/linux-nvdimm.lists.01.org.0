Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 120A63819D3
	for <lists+linux-nvdimm@lfdr.de>; Sat, 15 May 2021 18:29:06 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 591F7100F2251;
	Sat, 15 May 2021 09:29:02 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8FB51100EBBC0
	for <linux-nvdimm@lists.01.org>; Sat, 15 May 2021 09:28:59 -0700 (PDT)
Received: by mail.kernel.org (Postfix) with ESMTPS id 0A07A613C5;
	Sat, 15 May 2021 16:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1621096138;
	bh=k7gxnQ3jgb/s38QvG7Txft5y6PiqAO8JYg21ZFlKOAo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=pdC4n8ijCmMgq6A9feSTvbmXnLVGEX2c6aKrkm3+oghqt/JMwC8NevHQu5NTP706b
	 DfMVR0iqJC5sqOYRAMQ6joZRz6YUDXwBIHQFLu+5nkwRZHtyJDZLfAgQ1LxBTL7K+N
	 gPl62LNUFrH/j34SOG8l89pLF5C3IvTg6l/SoClhntdiH1MlNv1f2PKiq9MKqRoQNr
	 rhqZbg9kHz8VMTdaodZ6YpeFfzxeWhkoF0uWjqFzS98/jI87ZiXYAyCtzXFLTff/up
	 GA8qukDjLmqpe4yoKR67w8hemILZfrx1CxU5XCTapkzTVuF2pctaIq9OrgYTyzEXcV
	 iBr7Vl4KOrpfQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 03FA560A2C;
	Sat, 15 May 2021 16:28:58 +0000 (UTC)
Subject: Re: [GIT PULL] libnvdimm fixes for 5.13-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4gEKckAC2_mtjdK22OsEH4tHQSprYmuB7hkhafYquKNGQ@mail.gmail.com>
References: <CAPcyv4gEKckAC2_mtjdK22OsEH4tHQSprYmuB7hkhafYquKNGQ@mail.gmail.com>
X-PR-Tracked-List-Id: <nvdimm.lists.linux.dev>
X-PR-Tracked-Message-Id: <CAPcyv4gEKckAC2_mtjdK22OsEH4tHQSprYmuB7hkhafYquKNGQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-fixes-5.13-rc2
X-PR-Tracked-Commit-Id: e9cfd259c6d386f6235395a13bd4f357a979b2d0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a5ce4296b0416b3001c69abef7b5fa751c0f7578
Message-Id: <162109613800.13678.1977158030499199784.pr-tracker-bot@kernel.org>
Date: Sat, 15 May 2021 16:28:58 +0000
To: Dan Williams <dan.j.williams@intel.com>
Message-ID-Hash: 4NN3O6VTHPWKY2OYWEU3BBQQVNJR6RQC
X-Message-ID-Hash: 4NN3O6VTHPWKY2OYWEU3BBQQVNJR6RQC
X-MailFrom: pr-tracker-bot@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Linus Torvalds <torvalds@linux-foundation.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, nvdimm@lists.linux.dev, Linux ACPI <linux-acpi@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4NN3O6VTHPWKY2OYWEU3BBQQVNJR6RQC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The pull request you sent on Fri, 14 May 2021 16:43:31 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-fixes-5.13-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a5ce4296b0416b3001c69abef7b5fa751c0f7578

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
