Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B483020265F
	for <lists+linux-nvdimm@lfdr.de>; Sat, 20 Jun 2020 22:25:28 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 12E8510FCC6CB;
	Sat, 20 Jun 2020 13:25:27 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7F28510FCC6C7
	for <linux-nvdimm@lists.01.org>; Sat, 20 Jun 2020 13:25:24 -0700 (PDT)
Subject: Re: [GIT PULL] libnvdimm for v5.8-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592684723;
	bh=nBMiu7wv3crII+RtLA98eRK4r5UhAJIvJbfA40Wdr7Q=;
	h=From:In-Reply-To:References:Date:To:Cc:From;
	b=QSPqz6QI5pSm5rCIicfLLj1/AEtOJLRsISu/hhts51JOF66qBi2T8Dknyr1tSCZZY
	 /TAQtZEe6ddaxfBSS7uFZrEOTY+HUjzW7UKijXhk7nXSdXb0qRZ/kkx3TbM9yg6IEg
	 94FiL5dDbfNT5D+dpKFBc1rN22dvHD3RujEAIs04=
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4jA-_Wd4S6gM2jf_VhVsgsdR5rQTeAc3AEPr6SAvhq3eA@mail.gmail.com>
References: <CAPcyv4jA-_Wd4S6gM2jf_VhVsgsdR5rQTeAc3AEPr6SAvhq3eA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPcyv4jA-_Wd4S6gM2jf_VhVsgsdR5rQTeAc3AEPr6SAvhq3eA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
 tags/libnvdimm-for-5.8-rc2
X-PR-Tracked-Commit-Id: 9df24eaef86f5d5cb38c77eaa1cfa3eec09ebfe8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eede2b9b3fe01168940bb42ff3ab502ef5f6375c
Message-Id: <159268472295.18389.7225516964875239399.pr-tracker-bot@kernel.org>
Date: Sat, 20 Jun 2020 20:25:22 +0000
To: Dan Williams <dan.j.williams@intel.com>
Message-ID-Hash: BRLGSAIAEGWIDCS5SSTFW2FQTNAXGUEO
X-Message-ID-Hash: BRLGSAIAEGWIDCS5SSTFW2FQTNAXGUEO
X-MailFrom: pr-tracker-bot@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Vaibhav Jain <vaibhav@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BRLGSAIAEGWIDCS5SSTFW2FQTNAXGUEO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The pull request you sent on Fri, 19 Jun 2020 15:07:04 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-for-5.8-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eede2b9b3fe01168940bb42ff3ab502ef5f6375c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
