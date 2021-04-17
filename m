Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00658363146
	for <lists+linux-nvdimm@lfdr.de>; Sat, 17 Apr 2021 19:02:14 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2F35D100EC1C6;
	Sat, 17 Apr 2021 10:02:12 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CE42F100EF26A
	for <linux-nvdimm@lists.01.org>; Sat, 17 Apr 2021 10:02:06 -0700 (PDT)
Received: by mail.kernel.org (Postfix) with ESMTPS id 820176120F;
	Sat, 17 Apr 2021 17:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1618678926;
	bh=gRCZhPw34VPReowmJecTqwoA9iSAjlZuG4AcKbByCmI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LzSp59DdaOYYjvaWK8M53Gv8hyO5YmyUx3e9fcoVqLhg1sdfzuO0fYdFx8wCJM/tJ
	 IpsgbSgVWbK49g/4oueSvetnDBArkL9sc65tAzQXqwels8J3DyXaspfWivE6BUmO7M
	 oxFycm/s/LuGuurodrhWVku93ksgOr7vIPt2VjE/DG2V9LZPDqREUC4oS7j1KmoSEt
	 srWEbj2f8j6YD/CcJPlswfoPfgidG0culobWV2/Jv9og8r1UnS5yxQW5z40rZpQlc/
	 rUISSRBPmhUi+qvzx6AA3AmAnVR61fdxHRrJAAzyJaZ+hM4Mud9dM+c3NTHWOhUvcY
	 +kwcTDuy8F43A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7CA4D60986;
	Sat, 17 Apr 2021 17:02:06 +0000 (UTC)
Subject: Re: [GIT PULL] libnvdimm fixes for v5.12-rc8 / final
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4iUPPY7XpwwY1zK3VGUY72p+zZckSCwgWuvJa183Y_QBA@mail.gmail.com>
References: <CAPcyv4iUPPY7XpwwY1zK3VGUY72p+zZckSCwgWuvJa183Y_QBA@mail.gmail.com>
X-PR-Tracked-List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
X-PR-Tracked-Message-Id: <CAPcyv4iUPPY7XpwwY1zK3VGUY72p+zZckSCwgWuvJa183Y_QBA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-fixes-for-5.12-rc8
X-PR-Tracked-Commit-Id: 11d2498f1568a0f923dc8ef7621de15a9e89267f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bdfd99e6d6bd690b47bd1d45dad218bf08be1dde
Message-Id: <161867892650.3103.1470679395812363097.pr-tracker-bot@kernel.org>
Date: Sat, 17 Apr 2021 17:02:06 +0000
To: Dan Williams <dan.j.williams@intel.com>
Message-ID-Hash: OHSHG36QDZJGT7LHZQHBLEBVTBMGJFXR
X-Message-ID-Hash: OHSHG36QDZJGT7LHZQHBLEBVTBMGJFXR
X-MailFrom: pr-tracker-bot@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Linus Torvalds <torvalds@linux-foundation.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OHSHG36QDZJGT7LHZQHBLEBVTBMGJFXR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The pull request you sent on Fri, 16 Apr 2021 20:25:28 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-fixes-for-5.12-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bdfd99e6d6bd690b47bd1d45dad218bf08be1dde

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
