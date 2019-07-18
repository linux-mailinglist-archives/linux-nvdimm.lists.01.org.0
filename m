Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE1F6D3EF
	for <lists+linux-nvdimm@lfdr.de>; Thu, 18 Jul 2019 20:30:22 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6EACD212D2750;
	Thu, 18 Jul 2019 11:32:49 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=pr-tracker-bot@kernel.org; receiver=linux-nvdimm@lists.01.org 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 27F02212D2747
 for <linux-nvdimm@lists.01.org>; Thu, 18 Jul 2019 11:32:47 -0700 (PDT)
Subject: Re: [GIT PULL] libnvdimm for 5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1563474618;
 bh=yp+v1G+WHtqQfLqTmTaMh0XIuJLVgPNGYlbEHdjF3Iw=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=W8rdAO4Mc/XIaEqO2H9YRT1Xi27zGF63+NUbaVX5oGS3WFr5HIBwDY8A1AHeER0ee
 sFq7WNpeECel/g5+Z3bFp6lz6CWis72GnjEJ7pE8+AOZlhJ8g2HvLIh8ouAE9+qlGd
 bbW3xX5tQ4gSvTtfjDKIo7MKaBmfsLy9pz19t+Y0=
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4ji_0CqmeO2hh1ERvUnVJZkFcuj+=QQ3mrSx13y3uSHoQ@mail.gmail.com>
References: <CAPcyv4ji_0CqmeO2hh1ERvUnVJZkFcuj+=QQ3mrSx13y3uSHoQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPcyv4ji_0CqmeO2hh1ERvUnVJZkFcuj+=QQ3mrSx13y3uSHoQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
 tags/libnvdimm-for-5.3
X-PR-Tracked-Commit-Id: 8c2e408e73f735d2e6e8b43f9b038c9abb082939
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f8c3500cd137867927bc080f4a6e02e0222dd1b8
Message-Id: <156347461871.12683.18224715719343040057.pr-tracker-bot@kernel.org>
Date: Thu, 18 Jul 2019 18:30:18 +0000
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

The pull request you sent on Thu, 18 Jul 2019 07:16:41 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-for-5.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f8c3500cd137867927bc080f4a6e02e0222dd1b8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
