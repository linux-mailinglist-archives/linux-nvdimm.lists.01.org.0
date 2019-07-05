Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 777645FF97
	for <lists+linux-nvdimm@lfdr.de>; Fri,  5 Jul 2019 04:55:09 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0D615212B0FFC;
	Thu,  4 Jul 2019 19:55:07 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=pr-tracker-bot@kernel.org; receiver=linux-nvdimm@lists.01.org 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 551CC212B0FE0
 for <linux-nvdimm@lists.01.org>; Thu,  4 Jul 2019 19:55:05 -0700 (PDT)
Subject: Re: [GIT PULL] dax fix for v5.2-rc8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1562295305;
 bh=g1fh37E3g0Ecbtf1QI1mp3LBnuqqRLs7j77IMJR3zJE=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=1v7oDAA161pWOrObNe2BSha2K2jtt1dt7wbwQJ9he5t68nfWl/Z8FXZd4xnlvM/Yt
 mB21vby6qB6+M5Vme0rsh0ijYhKKXaft0j+4Xt8LfrKdvvkCFKUd5moaslFpr0f2bP
 YZ5q7KbUuBZDwiJY/tWVDmRVDZNrlo1FIQoMmd3U=
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4hs6bncxc3_vOKYYc-XdL+-dv_dJkmV8EduRrshv3rBgQ@mail.gmail.com>
References: <CAPcyv4hs6bncxc3_vOKYYc-XdL+-dv_dJkmV8EduRrshv3rBgQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPcyv4hs6bncxc3_vOKYYc-XdL+-dv_dJkmV8EduRrshv3rBgQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
 tags/dax-fix-5.2-rc8
X-PR-Tracked-Commit-Id: 1571c029a2ff289683ddb0a32253850363bcb8a7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cde357c392e93aa7fcfc019403e0d1792081d634
Message-Id: <156229530511.12956.15338596813183151186.pr-tracker-bot@kernel.org>
Date: Fri, 05 Jul 2019 02:55:05 +0000
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
 linux-nvdimm <linux-nvdimm@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

The pull request you sent on Thu, 4 Jul 2019 17:11:16 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/dax-fix-5.2-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cde357c392e93aa7fcfc019403e0d1792081d634

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
