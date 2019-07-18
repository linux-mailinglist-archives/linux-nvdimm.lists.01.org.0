Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9666A6D3F0
	for <lists+linux-nvdimm@lfdr.de>; Thu, 18 Jul 2019 20:30:23 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B25C02194EB7B;
	Thu, 18 Jul 2019 11:32:49 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=pr-tracker-bot@kernel.org; receiver=linux-nvdimm@lists.01.org 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 393A8212D2747
 for <linux-nvdimm@lists.01.org>; Thu, 18 Jul 2019 11:32:48 -0700 (PDT)
Subject: Re: [GIT PULL] dax for 5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1563474619;
 bh=1r3EurQxmmR6M8I1pSPfcCUy90F9rFAi+TAF9Ghmyi4=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=aAICNbsVy9WLwJ7dSj7dhKxofmKV90mme2Jc++9KRZEVqHWBkQVEGrQ/R+6EusN1W
 JOTMmwbiliVMOl71oTcgCUgG9qmnYcW+oM7qP4fOVuqfHqJMBrl1cRdXtRmx2eGoXh
 11e8vgtLLr8/SshIRDnDIFkOKz6x+Dom+BWc/JsU=
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4jMjvPYTa00hbq=64LZ=Vcu-gi7hLcgDTnD9d4dF0t9ng@mail.gmail.com>
References: <CAPcyv4jMjvPYTa00hbq=64LZ=Vcu-gi7hLcgDTnD9d4dF0t9ng@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPcyv4jMjvPYTa00hbq=64LZ=Vcu-gi7hLcgDTnD9d4dF0t9ng@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/dax-for-5.3
X-PR-Tracked-Commit-Id: 23c84eb7837514e16d79ed6d849b13745e0ce688
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0fe49f70a08d7d25acee3b066a88c654fea26121
Message-Id: <156347461988.12683.5649730008355419191.pr-tracker-bot@kernel.org>
Date: Thu, 18 Jul 2019 18:30:19 +0000
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
Cc: Jan Kara <jack@suse.cz>, Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Matthew Wilcox <willy@infradead.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

The pull request you sent on Thu, 18 Jul 2019 07:37:07 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/dax-for-5.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0fe49f70a08d7d25acee3b066a88c654fea26121

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
