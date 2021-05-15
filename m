Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 100773819D2
	for <lists+linux-nvdimm@lfdr.de>; Sat, 15 May 2021 18:29:06 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 44FCC100EBBC0;
	Sat, 15 May 2021 09:29:02 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8EBD8100EBBA2
	for <linux-nvdimm@lists.01.org>; Sat, 15 May 2021 09:28:59 -0700 (PDT)
Received: by mail.kernel.org (Postfix) with ESMTPS id 486CA613C4;
	Sat, 15 May 2021 16:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1621096136;
	bh=X3+Sb559v2Vf5aXRxfe8iEp/yqakvWJ6olj5taOgRdI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rGbBBANDPEGJmbN5BSFfEf1NqHj4EXm8iOba/5hzLWCqpu7l17lCfUcLTgt01b8d2
	 nBoJkZ3efceeHbympLKgqo6n197u8xb0B6/jlJecDLFdOwI6TpExDMIciEB6KC0uxM
	 SxJ+J1vFQwPW/588QDAPpEmXP80gtnyCMzGPT8acPAOvRiv7Cocxn0NDqA8yNot+3c
	 9Y15uyxAS0qskB0HmatntEXIOP073uusPxEhEmGLXrK6mL5va/VkyvdYIKzMmVSm6x
	 1vI1yeJiihmSUQztk9hfHggH2gDhwVBbwPFhD0tWIZhzEtUjkw134A97nDYnCJD/6T
	 7+d1rN/9SpXSw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4260760727;
	Sat, 15 May 2021 16:28:56 +0000 (UTC)
Subject: Re: [GIT PULL] dax fixes for v5.13-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4hDfxpYh1rvvqFCQ+eNk_XxZD3grUOYkHWbERfxky43xQ@mail.gmail.com>
References: <CAPcyv4hDfxpYh1rvvqFCQ+eNk_XxZD3grUOYkHWbERfxky43xQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPcyv4hDfxpYh1rvvqFCQ+eNk_XxZD3grUOYkHWbERfxky43xQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/dax-fixes-5.13-rc2
X-PR-Tracked-Commit-Id: 237388320deffde7c2d65ed8fc9eef670dc979b3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 393f42f113b607786207449dc3241d05ec61d5dc
Message-Id: <162109613626.13678.5421183533760328887.pr-tracker-bot@kernel.org>
Date: Sat, 15 May 2021 16:28:56 +0000
To: Dan Williams <dan.j.williams@intel.com>
Message-ID-Hash: HOARTTJN5H264IO6FGAGMTDM6UXWPAQT
X-Message-ID-Hash: HOARTTJN5H264IO6FGAGMTDM6UXWPAQT
X-MailFrom: pr-tracker-bot@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, nvdimm@lists.linux.dev
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HOARTTJN5H264IO6FGAGMTDM6UXWPAQT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The pull request you sent on Fri, 14 May 2021 16:33:22 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/dax-fixes-5.13-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/393f42f113b607786207449dc3241d05ec61d5dc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
