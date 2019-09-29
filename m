Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C74C18A2
	for <lists+linux-nvdimm@lfdr.de>; Sun, 29 Sep 2019 19:50:28 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0630F1011360B;
	Sun, 29 Sep 2019 10:52:09 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C02AC10113609
	for <linux-nvdimm@lists.01.org>; Sun, 29 Sep 2019 10:52:06 -0700 (PDT)
Subject: Re: [GIT PULL] libnvdimm fixes for v5.4-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569779423;
	bh=sLpBK98JGjYLJeeMKeMxZXtgz3IbLinnFUJWoo1RwjE=;
	h=From:In-Reply-To:References:Date:To:Cc:From;
	b=S2FmXA27bktlnMH3emqurNob0egawmtiVT06arsVQPs65bcvb6jDvRzV6tR2k1x4d
	 TZxuckVZTADTqO73grBvrAdyjVEreHwvqdvQsViA5PEgxFS3eCY1zYAQ4Dcws6cIry
	 jeAD7YNIQvWgz4CDWZnneUAoM3x5w7tvn5pfPVwY=
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4jJjjkXXSYpYNC3y2r2YJrcSYw=tZ9p=KyA8BS46kfFuA@mail.gmail.com>
References: <CAPcyv4jJjjkXXSYpYNC3y2r2YJrcSYw=tZ9p=KyA8BS46kfFuA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPcyv4jJjjkXXSYpYNC3y2r2YJrcSYw=tZ9p=KyA8BS46kfFuA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
 tags/libnvdimm-fixes-5.4-rc1
X-PR-Tracked-Commit-Id: 4c806b897d6075bfa5067e524fb058c57ab64e7b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a3c0e7b1fe1fc62bba5f591c4bc404eea96823b8
Message-Id: <156977942385.28081.14590936149544081114.pr-tracker-bot@kernel.org>
Date: Sun, 29 Sep 2019 17:50:23 +0000
To: Dan Williams <dan.j.williams@intel.com>
Message-ID-Hash: VSW2CTL743W3TJDVZG3JGTFULF2T3EVT
X-Message-ID-Hash: VSW2CTL743W3TJDVZG3JGTFULF2T3EVT
X-MailFrom: pr-tracker-bot@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Linus Torvalds <torvalds@linux-foundation.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <>
List-Archive: <>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The pull request you sent on Sat, 28 Sep 2019 18:44:17 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-fixes-5.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a3c0e7b1fe1fc62bba5f591c4bc404eea96823b8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
