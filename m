Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBE9B9F4F
	for <lists+linux-nvdimm@lfdr.de>; Sat, 21 Sep 2019 20:15:26 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DB05921962301;
	Sat, 21 Sep 2019 11:18:09 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=pr-tracker-bot@kernel.org; receiver=linux-nvdimm@lists.01.org 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 47F58202ECFD0
 for <linux-nvdimm@lists.01.org>; Sat, 21 Sep 2019 11:18:08 -0700 (PDT)
Subject: Re: [GIT PULL] libnvdimm for 5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1569089723;
 bh=5/1Co2dhtCJ+2dhp9MAkmlBq5yjC23womgX1T5IGAzA=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=u0cNmLSBT3M0r845jbRhjIPVDphGFo3O8we3cdolMIxbpMDqBMAGyJ70bfS6djcOV
 iY6FInF5TbUo9UCuK6y+YNj3ZP1LsO2meCLeHd/Q0gommxep5CSkBTsn3xEq0h0not
 J3gznpgVgeNiIMTW6EmmUrPuQYk3c4Q/b70GBtag=
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4g9TpgciDdVpQajSxEYTaHxB4+R9KWF0d=Emt9J7LkAqg@mail.gmail.com>
References: <CAPcyv4g9TpgciDdVpQajSxEYTaHxB4+R9KWF0d=Emt9J7LkAqg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPcyv4g9TpgciDdVpQajSxEYTaHxB4+R9KWF0d=Emt9J7LkAqg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
 tags/libnvdimm-for-5.4
X-PR-Tracked-Commit-Id: 5b26db95fee3f1ce0d096b2de0ac6f3716171093
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6cb2e9ee51b5f1539f027346a02904e282b87d4d
Message-Id: <156908972332.32474.14806435139939273985.pr-tracker-bot@kernel.org>
Date: Sat, 21 Sep 2019 18:15:23 +0000
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
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

The pull request you sent on Fri, 20 Sep 2019 16:57:31 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-for-5.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6cb2e9ee51b5f1539f027346a02904e282b87d4d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
