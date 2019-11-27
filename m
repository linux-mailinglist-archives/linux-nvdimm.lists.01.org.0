Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5EF10A95B
	for <lists+linux-nvdimm@lfdr.de>; Wed, 27 Nov 2019 05:20:18 +0100 (CET)
Received: from ml01.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 261E410113331;
	Tue, 26 Nov 2019 20:23:39 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 503A0100DC2CE
	for <linux-nvdimm@lists.01.org>; Tue, 26 Nov 2019 20:23:37 -0800 (PST)
Subject: Re: [GIT PULL] ACPI updates for v5.5-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574828414;
	bh=7U5QvbOcu2GrhmPv65Z5K1XMND22gyJT+/bvOU+tXtM=;
	h=From:In-Reply-To:References:Date:To:Cc:From;
	b=JqILwvzR1BsJxoAyrFiYdqGkCOKo2kTaSk7aJj/tnQq/wh942VjyvBbocQsgTNXlu
	 QK6fedUdzir4oTXS7t7Aj73kKtbJzAO6Pth+yfM0ND99yiDXVC+jo4QG45R4ZQMMpD
	 3hJWrD8p3bYncFROQ73w3Ytg8Ryl1Rt3t/eT82Nw=
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0g944ZbCaoCvGcT7EFJVKW5efSMgf9oi_d3iP_3+iwbNg@mail.gmail.com>
References: <CAJZ5v0g944ZbCaoCvGcT7EFJVKW5efSMgf9oi_d3iP_3+iwbNg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0g944ZbCaoCvGcT7EFJVKW5efSMgf9oi_d3iP_3+iwbNg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 acpi-5.5-rc1
X-PR-Tracked-Commit-Id: 782b59711e1561ee0da06bc478ca5e8249aa8d09
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6e9f879684b46331f51d0c76ebee981c788417db
Message-Id: <157482841395.9403.2315371254751175937.pr-tracker-bot@kernel.org>
Date: Wed, 27 Nov 2019 04:20:13 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Message-ID-Hash: FKY5ZNDFCYCFZH7VN2ZB47OITU6SJ5VH
X-Message-ID-Hash: FKY5ZNDFCYCFZH7VN2ZB47OITU6SJ5VH
X-MailFrom: pr-tracker-bot@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, linux-efi <linux-efi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FKY5ZNDFCYCFZH7VN2ZB47OITU6SJ5VH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The pull request you sent on Tue, 26 Nov 2019 13:59:13 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6e9f879684b46331f51d0c76ebee981c788417db

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
