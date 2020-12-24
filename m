Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A05E2E28E2
	for <lists+linux-nvdimm@lfdr.de>; Thu, 24 Dec 2020 22:59:39 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9829D100EBBAA;
	Thu, 24 Dec 2020 13:59:37 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B3389100EF26D
	for <linux-nvdimm@lists.01.org>; Thu, 24 Dec 2020 13:59:34 -0800 (PST)
Received: by mail.kernel.org (Postfix) with ESMTPS id 76A8322C9D;
	Thu, 24 Dec 2020 21:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1608847174;
	bh=tslbC6tu1seKhg4N3jLbDAc30cLoAS5dItk1azrn31E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=kvOHaNCnkdBighGw3b2RJ35ELJmjirJ9eYOkuQSlsjXcW24FaDslRwOQhKccOVRmV
	 4pf3xmNLJJgUUZFXxS+a6gfR3Wl/OcABmO+AHo+Sk3EeUiaa0lDOPmXFrFc15jxX6H
	 y3pLJHwvwwfLbob7i0ugrVLu6jBG0yZi9RhJDoTT0Xx+jm7v77ggASM1VHvwZe5FxM
	 nxLNeIM99qebkyTkdrqA7R6EhwNbIS2CLXc89Noi7kBuFEDgvkshQtME6SBfVhHxvU
	 EB8gQFzSENozb+zjGe456WynSWyyAGFgD31fEhNReCjRBQVbMfrG95TZvbZ9+7S0Tx
	 wxwZpfy3otuFg==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 70D6960159;
	Thu, 24 Dec 2020 21:59:34 +0000 (UTC)
Subject: Re: [GIT PULL] libnvdimm for v5.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4iufHK1g-KvhOsh5pwNL=DwK5ydVR7NWePaco5v5XL24A@mail.gmail.com>
References: <CAPcyv4iufHK1g-KvhOsh5pwNL=DwK5ydVR7NWePaco5v5XL24A@mail.gmail.com>
X-PR-Tracked-List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
X-PR-Tracked-Message-Id: <CAPcyv4iufHK1g-KvhOsh5pwNL=DwK5ydVR7NWePaco5v5XL24A@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-for-5.11
X-PR-Tracked-Commit-Id: 127c3d2e7e8a79628160e56e54d2be099bdd47c6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1f13d2f7d8a407be09e841f17805b2451271d493
Message-Id: <160884717445.31605.2585474058824378587.pr-tracker-bot@kernel.org>
Date: Thu, 24 Dec 2020 21:59:34 +0000
To: Dan Williams <dan.j.williams@intel.com>
Message-ID-Hash: J6MA5SCKVPX6QBJKKSFDQK4BKNTRLVZY
X-Message-ID-Hash: J6MA5SCKVPX6QBJKKSFDQK4BKNTRLVZY
X-MailFrom: pr-tracker-bot@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/J6MA5SCKVPX6QBJKKSFDQK4BKNTRLVZY/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The pull request you sent on Thu, 24 Dec 2020 11:01:53 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-for-5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1f13d2f7d8a407be09e841f17805b2451271d493

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
