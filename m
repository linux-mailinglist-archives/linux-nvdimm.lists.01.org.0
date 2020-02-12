Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C453F159E85
	for <lists+linux-nvdimm@lfdr.de>; Wed, 12 Feb 2020 02:10:27 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9B0C71003E999;
	Tue, 11 Feb 2020 17:13:42 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B80141007A82E
	for <linux-nvdimm@lists.01.org>; Tue, 11 Feb 2020 17:13:40 -0800 (PST)
Subject: Re: [GIT PULL] dax fixes for v5.6-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581469823;
	bh=1zxWpQ2kIBJxRWqJGLN1xWrlPdtElQ48K3NlgPo5TnA=;
	h=From:In-Reply-To:References:Date:To:Cc:From;
	b=zUgDgnHe7A7Kin9yy0/qIaJP8Ka5qX9syJt6uWukF8qzDBQtCjmm41NdTYxY6Epr1
	 Qxkb21Ul13oUvlTFTGjmkBYop5Eu41KaJfQzuNO/cjAYZO83poDYLTW+fSR6KqpYdK
	 8OYEIJ1fL8MZUM+1lWB39KmHFL90mXReUu6WMQOs=
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4iQf80XGwYVU3-GnbxU7u+bu2bn=+MwM54WGyG1kN=ddQ@mail.gmail.com>
References: <CAPcyv4iQf80XGwYVU3-GnbxU7u+bu2bn=+MwM54WGyG1kN=ddQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPcyv4iQf80XGwYVU3-GnbxU7u+bu2bn=+MwM54WGyG1kN=ddQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
 tags/dax-fixes-5.6-rc1
X-PR-Tracked-Commit-Id: 96222d53842dfe54869ec4e1b9d4856daf9105a2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 359c92c02bfae1a6f1e8e37c298e518fd256642c
Message-Id: <158146982342.31393.14778365135756811474.pr-tracker-bot@kernel.org>
Date: Wed, 12 Feb 2020 01:10:23 +0000
To: Dan Williams <dan.j.williams@intel.com>
Message-ID-Hash: NJEQ33W3E6BR2BYPDDDS26ZAQDLOHEEK
X-Message-ID-Hash: NJEQ33W3E6BR2BYPDDDS26ZAQDLOHEEK
X-MailFrom: pr-tracker-bot@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Linus Torvalds <torvalds@linux-foundation.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NJEQ33W3E6BR2BYPDDDS26ZAQDLOHEEK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The pull request you sent on Tue, 11 Feb 2020 13:48:56 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/dax-fixes-5.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/359c92c02bfae1a6f1e8e37c298e518fd256642c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
