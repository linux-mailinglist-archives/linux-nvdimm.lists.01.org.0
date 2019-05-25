Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1036F2A5CA
	for <lists+linux-nvdimm@lfdr.de>; Sat, 25 May 2019 19:20:23 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CD3CE212794A6;
	Sat, 25 May 2019 10:20:19 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=pr-tracker-bot@kernel.org; receiver=linux-nvdimm@lists.01.org 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id DAE1D2194EB7B
 for <linux-nvdimm@lists.01.org>; Sat, 25 May 2019 10:20:17 -0700 (PDT)
Subject: Re: [GIT PULL] libnvdimm fixes for v5.2-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1558804817;
 bh=hM6OadMFhEZvV+/0q2EXuMBZAHrS1SgwQeNA3HHgJd8=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=ozJnTovkxqyDNrBOuNlyht6Mb5e+wlVo9YG6ICWiDrooFlBXnpRaukw4+ARbyXDG1
 heH95BDYRBdLiUwCOFtDENBThbyGP6DRnM12NJUGgl/3zh102XRrNqAa/XhF6OVkso
 asO4ZXxnMWnZdbbBan4PeA5HnJ23RB8pjVIjM564=
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4ghA3bGeTFw+wVV5N8cb-izpwdi9BQU5Ec6wNTw8ZywMw@mail.gmail.com>
References: <CAPcyv4ghA3bGeTFw+wVV5N8cb-izpwdi9BQU5Ec6wNTw8ZywMw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPcyv4ghA3bGeTFw+wVV5N8cb-izpwdi9BQU5Ec6wNTw8ZywMw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
 tags/libnvdimm-fixes-5.2-rc2
X-PR-Tracked-Commit-Id: 52f476a323f9efc959be1c890d0cdcf12e1582e0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b2ad81363f12261f8b6a97ed7723960ea6450f31
Message-Id: <155880481554.7430.6840543435398022446.pr-tracker-bot@kernel.org>
Date: Sat, 25 May 2019 17:20:15 +0000
To: Dan Williams <dan.j.williams@intel.com>
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

The pull request you sent on Sat, 25 May 2019 09:05:03 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-fixes-5.2-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b2ad81363f12261f8b6a97ed7723960ea6450f31

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
