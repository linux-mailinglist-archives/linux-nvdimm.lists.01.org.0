Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C03436C8FE
	for <lists+linux-nvdimm@lfdr.de>; Tue, 27 Apr 2021 17:58:23 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 53267100EBB98;
	Tue, 27 Apr 2021 08:58:21 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2600:3c01:e000:3a1::42; helo=ms.lwn.net; envelope-from=corbet@lwn.net; receiver=<UNKNOWN> 
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6D48D100EBB97
	for <linux-nvdimm@lists.01.org>; Tue, 27 Apr 2021 08:58:18 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id C04752C1;
	Tue, 27 Apr 2021 15:58:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C04752C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1619539096; bh=32JbU+gLnbX1jmUuwmVFyNRAMmXw0M5RxNBqOE6G4gI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=cbEDjBbx83QSba420HmqA8g1o8Yf6+Hl4Mh356YlEZ/8faa7oQAWMgY5Yw4hKD/Uy
	 azkSJDrWXiOmf7vPrsL6mvlRGrg/q8of8JFYupTlHepCkEQugj/bB1QzHjXcx0j00D
	 68dpNLl3EbYQQ1MpyzwSRbYylFa5RO9ynS8jYq1AwRqXzrt/FxI8Pvcqmga7loDVEw
	 FiLxQVnrhHiRV2zuQ2Bg1UEtwJnRkcEyr9am1oTbsoTWxVLdPoTJt9ArAhSmsePG8Y
	 9FwcNGmkKPutIys6cbYBuFwPY2QnnUyy+8xrcTtLLOFP+gFChqgCE4Tjvjm+Kr0r+2
	 4WD3ajG2dyB6Q==
From: Jonathan Corbet <corbet@lwn.net>
To: Dan Williams <dan.j.williams@intel.com>, linux-nvdimm@lists.01.org
Subject: Re: [PATCH] MAINTAINERS: Move nvdimm mailing list
In-Reply-To: <161898872871.3406469.4054282559340528393.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <161898872871.3406469.4054282559340528393.stgit@dwillia2-desk3.amr.corp.intel.com>
Date: Tue, 27 Apr 2021 09:58:16 -0600
Message-ID: <87sg3bd8iv.fsf@meer.lwn.net>
MIME-Version: 1.0
Message-ID-Hash: NHYMCIULDOFQ5I5R7UPD3MM2LHS5UXEJ
X-Message-ID-Hash: NHYMCIULDOFQ5I5R7UPD3MM2LHS5UXEJ
X-MailFrom: corbet@lwn.net
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NHYMCIULDOFQ5I5R7UPD3MM2LHS5UXEJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dan Williams <dan.j.williams@intel.com> writes:

> After seeing some users have subscription management trouble, more spam
> than other Linux development lists, and considering some of the benefits
> of kernel.org hosted lists, nvdimm and persistent memory development is
> moving to nvdimm@lists.linux.dev.
>
> The old list will remain up until v5.14-rc1 and shutdown thereafter.
>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Oliver O'Halloran <oohall@gmail.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  Documentation/ABI/obsolete/sysfs-class-dax    |    2 +
>  Documentation/ABI/removed/sysfs-bus-nfit      |    2 +
>  Documentation/ABI/testing/sysfs-bus-nfit      |   40 +++++++++++++------------
>  Documentation/ABI/testing/sysfs-bus-papr-pmem |    4 +--
>  Documentation/driver-api/nvdimm/nvdimm.rst    |    2 +
>  MAINTAINERS                                   |   14 ++++-----
>  6 files changed, 32 insertions(+), 32 deletions(-)

Would you like me to take this through docs-next, or did you have
another path in mind?

Thanks,

jon
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
