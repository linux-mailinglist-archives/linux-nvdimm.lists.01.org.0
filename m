Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFE221A2E7
	for <lists+linux-nvdimm@lfdr.de>; Thu,  9 Jul 2020 17:00:59 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3DC5711427DB8;
	Thu,  9 Jul 2020 08:00:58 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=batv+9909843fd9ad822e0971+6164+infradead.org+hch@casper.srs.infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B57AC111FF49B
	for <linux-nvdimm@lists.01.org>; Thu,  9 Jul 2020 08:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=d6Fy1Ff8XKWJW7cdhpnfoPEQT8m7nn2QugrKA2y4BTE=; b=sXjsW/W8stofL0fSqv1devL9iA
	NF8pTtSu1pmMI2cx2Ezm5BoeofYSnPN6/rZYmpD+i2SwKMs8rbtY2EPcBcEn7LmzBMlRLH+HYv4ou
	IIiSGFJU8JQLbSCfDquQtv8nlD8xpYOQ1F33SWeREt+m+MKW2AS9lsim693P8pOA6Vn81rDU4U0pQ
	5CL7N1SiSxz2S6PRS4eEqvntN+bK6HeL9i5oI+CCBxoYMsT/JAjCwF5JHINgYNRZxp7hyfyhsJm5A
	TrgN6ANkFqMOJfU2KX4+HzhiTpzqnYh8wY/zml3sRidyoIzqKYX3E/qQYPkqN/E1WGtoJpXZ0IVyl
	KCO5FDkg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jtY2d-0004br-7k; Thu, 09 Jul 2020 15:00:51 +0000
Date: Thu, 9 Jul 2020 16:00:51 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 11/12] PM, libnvdimm: Add 'mem-quiet' state and
 callback for firmware activation
Message-ID: <20200709150051.GA17342@infradead.org>
References: <159408711335.2385045.2567600405906448375.stgit@dwillia2-desk3.amr.corp.intel.com>
 <159408717289.2385045.14094866475168644020.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <159408717289.2385045.14094866475168644020.stgit@dwillia2-desk3.amr.corp.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: W2JWMKYHYTSNTDO3K2QLZLIHK5A7K72X
X-Message-ID-Hash: W2JWMKYHYTSNTDO3K2QLZLIHK5A7K72X
X-MailFrom: BATV+9909843fd9ad822e0971+6164+infradead.org+hch@casper.srs.infradead.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@mellanox.com>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/W2JWMKYHYTSNTDO3K2QLZLIHK5A7K72X/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jul 06, 2020 at 06:59:32PM -0700, Dan Williams wrote:
> The runtime firmware activation capability of Intel NVDIMM devices
> requires memory transactions to be disabled for 100s of microseconds.
> This timeout is large enough to cause in-flight DMA to fail and other
> application detectable timeouts. Arrange for firmware activation to be
> executed while the system is "quiesced", all processes and device-DMA
> frozen.
> 
> It is already required that invoking device ->freeze() callbacks is
> sufficient to cease DMA. A device that continues memory writes outside
> of user-direction violates expectations of the PM core to be to
> establish a coherent hibernation image.
> 
> That said, RDMA devices are an example of a device that access memory
> outside of user process direction. RDMA drivers also typically assume
> the system they are operating in will never be hibernated. A solution
> for RDMA collisions with firmware activation is outside the scope of
> this change and may need to rely on being able to survive the platform
> imposed memory controller quiesce period.

Yikes.  I don't think we should support such a broken runtime firmware
activation.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
