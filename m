Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC6189395
	for <lists+linux-nvdimm@lfdr.de>; Sun, 11 Aug 2019 22:20:21 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 07878212E843F;
	Sun, 11 Aug 2019 13:22:46 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=pr-tracker-bot@kernel.org; receiver=linux-nvdimm@lists.01.org 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 0548E21290DCB
 for <linux-nvdimm@lists.01.org>; Sun, 11 Aug 2019 13:22:43 -0700 (PDT)
Subject: Re: [GIT PULL] dax fixes v5.3-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1565554813;
 bh=i4w8B+cpVPXThlxBvwy4MnGi42Qt5vWodoM8k3EI0oc=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=prCFR2BhegsueU5De1GSXYh3GJ3xKxMD9aceQyN2kMhmCSJYAV8UMigzQq5GccTXY
 fS6JzB3mnDutkrtArtYRQgdvhVefGnKulp+ZkEWDcF4/sXU+l/CqIkaY+GbiTT1yZi
 Zr/HRfxtkgxAYeF3lmT0z4bVbu1NvfWrtsx8IR8Q=
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4iaYiXbv2sf-Znn5dYphLKEi77NjafkEzXA2kAEMqyR0w@mail.gmail.com>
References: <CAPcyv4iaYiXbv2sf-Znn5dYphLKEi77NjafkEzXA2kAEMqyR0w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPcyv4iaYiXbv2sf-Znn5dYphLKEi77NjafkEzXA2kAEMqyR0w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
 tags/dax-fixes-5.3-rc4
X-PR-Tracked-Commit-Id: 06282373ff57a2b82621be4f84f981e1b0a4eb28
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b6c0649caf351d39e1dfb5698d7b3bb7536850b1
Message-Id: <156555480716.24420.8804304827340944517.pr-tracker-bot@kernel.org>
Date: Sun, 11 Aug 2019 20:20:07 +0000
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

The pull request you sent on Sun, 11 Aug 2019 12:01:02 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/dax-fixes-5.3-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b6c0649caf351d39e1dfb5698d7b3bb7536850b1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
