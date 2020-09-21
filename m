Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E7262272AAD
	for <lists+linux-nvdimm@lfdr.de>; Mon, 21 Sep 2020 17:49:23 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3D698144DAB99;
	Mon, 21 Sep 2020 08:49:22 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8797513E17882
	for <linux-nvdimm@lists.01.org>; Mon, 21 Sep 2020 08:49:19 -0700 (PDT)
Subject: Re: [GIT PULL] libnvdimm fix for v5.9-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600703358;
	bh=FVW2pjh7gDrjMnXGIR26gERgAX+e5lfOUkBMt5VBywM=;
	h=From:In-Reply-To:References:Date:To:Cc:From;
	b=DYcgT06YLvsM26NJXSaV2acuZ0akzLTFXQQPXLd2W+5eat0r0GMlwver0OTjN4x8/
	 r6TQgaxHo0kXuvyGJUJNcUi0b1v1dgWchKNMhqLxqSaKiZgVt7R7gUhRZPB8iM1SI4
	 J9BTrLEpxlzdSKuH9vRWORQzo65EdEzVbz7Y6lB8=
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4jCqzs7vjFCvLxHSL13OE0CX0Ptc75ApT-dyyGo_UZ1jw@mail.gmail.com>
References: <CAPcyv4jCqzs7vjFCvLxHSL13OE0CX0Ptc75ApT-dyyGo_UZ1jw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPcyv4jCqzs7vjFCvLxHSL13OE0CX0Ptc75ApT-dyyGo_UZ1jw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-fixes-5.9-rc7
X-PR-Tracked-Commit-Id: 88b67edd7247466bc47f01e1dc539b0d0d4b931e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a31128384dfd9ca11f15ef4ea73df25e394846d1
Message-Id: <160070335876.23869.6754079280762938592.pr-tracker-bot@kernel.org>
Date: Mon, 21 Sep 2020 15:49:18 +0000
To: Dan Williams <dan.j.williams@intel.com>
Message-ID-Hash: FODIB4D5ANBIBW5SMZUL3GLAODADCDZR
X-Message-ID-Hash: FODIB4D5ANBIBW5SMZUL3GLAODADCDZR
X-MailFrom: pr-tracker-bot@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Linus Torvalds <torvalds@linux-foundation.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Jan Kara <jack@suse.cz>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FODIB4D5ANBIBW5SMZUL3GLAODADCDZR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The pull request you sent on Mon, 21 Sep 2020 07:37:33 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-fixes-5.9-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a31128384dfd9ca11f15ef4ea73df25e394846d1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
