Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 225777B746
	for <lists+linux-nvdimm@lfdr.de>; Wed, 31 Jul 2019 02:40:16 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 08E5A212E8430;
	Tue, 30 Jul 2019 17:42:45 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=pr-tracker-bot@kernel.org; receiver=linux-nvdimm@lists.01.org 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id DFAC4212E4B5A
 for <linux-nvdimm@lists.01.org>; Tue, 30 Jul 2019 17:42:43 -0700 (PDT)
Subject: Re: [GIT PULL] dax fix for v5.3-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1564533613;
 bh=NHbuxyEgLSoC499SN8BkNunymePONLRyhWu422VBgO4=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=Dzz8sipVgdMN+nmkaVXM/Gpiw5lrM8TohMY8IIATGzAxmm45ZzmF+N0OjI8g+xuig
 Qq92IHbddQD2VumMKTHWPHF7lBqdBjDZoIJzVOEJRrcomk6YJbCXjaIDQvs+1ExakS
 +YH2RQxqgvjD1/5+TZqsnrQebij/v4IKbzb1mSL4=
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4hJcRY3aop4jgH8NLsz1A8HH7sH6gnGs02Wy8A=p5o=jg@mail.gmail.com>
References: <CAPcyv4hJcRY3aop4jgH8NLsz1A8HH7sH6gnGs02Wy8A=p5o=jg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPcyv4hJcRY3aop4jgH8NLsz1A8HH7sH6gnGs02Wy8A=p5o=jg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm dax-fix-5.3-rc3
X-PR-Tracked-Commit-Id: 61c30c98ef17e5a330d7bb8494b78b3d6dffe9b8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4010b622f1d2a6112244101f38225eaee20c07f2
Message-Id: <156453361310.6472.7034768044112756538.pr-tracker-bot@kernel.org>
Date: Wed, 31 Jul 2019 00:40:13 +0000
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

The pull request you sent on Tue, 30 Jul 2019 14:32:42 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm dax-fix-5.3-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4010b622f1d2a6112244101f38225eaee20c07f2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
