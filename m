Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B68D1FDA1
	for <lists+linux-nvdimm@lfdr.de>; Thu, 16 May 2019 04:05:22 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 60C67212657BC;
	Wed, 15 May 2019 19:05:20 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=pr-tracker-bot@kernel.org; receiver=linux-nvdimm@lists.01.org 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 476A22125F1EE
 for <linux-nvdimm@lists.01.org>; Wed, 15 May 2019 19:05:19 -0700 (PDT)
Subject: Re: [GIT PULL] libnvdimm fixes for v5.2-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1557972318;
 bh=vNqSnMbYYcXI324Ix8jOL7SnkxL6rCbYBcP08H/89pU=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=Wn/bZXpxxugnsiecPZIckdqvLImTt5wLCOX08tMwAYtNtX+aJ2aI6cgFXHb3zr42S
 3BlTzDGVVImRxAdpRM5RTx+bauTDUaDVEUvt3rN+GqpXVjcFZJ3ryYwxNdfblBiXpL
 BwjmongDZJHwAhxTVt5kR58spAIgdIjOz6B9auks=
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4iXv7Jh4rjO9XQAFpeCJEZ4-4nvb46nZyQP554uLNbOyg@mail.gmail.com>
References: <CAPcyv4iXv7Jh4rjO9XQAFpeCJEZ4-4nvb46nZyQP554uLNbOyg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPcyv4iXv7Jh4rjO9XQAFpeCJEZ4-4nvb46nZyQP554uLNbOyg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
 tags/libnvdimm-fixes-5.2-rc1
X-PR-Tracked-Commit-Id: 67476656febd7ec5f1fe1aeec3c441fcf53b1e45
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 83f3ef3de625a5766de2382f9e077d4daafd5bac
Message-Id: <155797231889.20425.9070701612629696184.pr-tracker-bot@kernel.org>
Date: Thu, 16 May 2019 02:05:18 +0000
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

The pull request you sent on Wed, 15 May 2019 17:05:58 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-fixes-5.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/83f3ef3de625a5766de2382f9e077d4daafd5bac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
