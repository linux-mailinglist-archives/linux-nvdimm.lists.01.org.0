Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B7828EE1E
	for <lists+linux-nvdimm@lfdr.de>; Thu, 15 Oct 2020 10:03:04 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 36BE415F525C6;
	Thu, 15 Oct 2020 01:03:02 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=batv+d12e96c8672b4e58918a+6262+infradead.org+hch@casper.srs.infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 480ED15F525C1
	for <linux-nvdimm@lists.01.org>; Thu, 15 Oct 2020 01:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=a2qZql200AZN5N8nLwRfRT3TJyI5WyTogEl+yUVcMaU=; b=mMRHnNZTH9o/HtpUjP8YHNIQyp
	AsR7PsYskBsLyou/+zQT+n+HEg36cIqGJo4jK+hwKhZ6+up4QpErlS2U5uPhGAMXxmA3H11U0UNYb
	1zJkNa5i6EcfKih1iPRHJfuNEg9ub8J7V9cICfb3i3ze+7ssw6/V0nKuUGS7SOkzZef6WPMlrDx0p
	EDKti4gagCtiMFFd/3tPfO5iHN33GZmMVpj3tNBlQsID/rHbQeP7zzyp01dFUB3WMnNCXwxYlJDvg
	1PEKzLUSzj2WDjb+BWXqgZcS2of6pFNVLrq8IjyCFbSd7zYsuYq42W2SvUMAlTxq5kC6pxaKJDwDs
	1j6BdwiQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kSyDu-0008AD-QZ; Thu, 15 Oct 2020 08:02:54 +0000
Date: Thu, 15 Oct 2020 09:02:54 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Nabeel M Mohamed <nmeeramohide@micron.com>
Subject: Re: [PATCH v2 00/22] add Object Storage Media Pool (mpool)
Message-ID: <20201015080254.GA31136@infradead.org>
References: <20201012162736.65241-1-nmeeramohide@micron.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201012162736.65241-1-nmeeramohide@micron.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: BFMSY6SQRFRN4QVGCPWOR7QMTP5INZJG
X-Message-ID-Hash: BFMSY6SQRFRN4QVGCPWOR7QMTP5INZJG
X-MailFrom: BATV+d12e96c8672b4e58918a+6262+infradead.org+hch@casper.srs.infradead.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-mm@kvack.org, linux-nvdimm@lists.01.org, smoyer@micron.com, gbecker@micron.com, plabat@micron.com, jgroves@micron.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BFMSY6SQRFRN4QVGCPWOR7QMTP5INZJG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

I don't think this belongs into the kernel.  It is a classic case for
infrastructure that should be built in userspace.  If anything is
missing to implement it in userspace with equivalent performance we
need to improve out interfaces, although io_uring should cover pretty
much everything you need.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
