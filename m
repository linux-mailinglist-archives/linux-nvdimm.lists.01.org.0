Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4F63679DF
	for <lists+linux-nvdimm@lfdr.de>; Thu, 22 Apr 2021 08:25:53 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 33E42100EAB67;
	Wed, 21 Apr 2021 23:25:51 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=batv+3eeb648068207d7d58b2+6451+infradead.org+hch@casper.srs.infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0E419100EAB66
	for <linux-nvdimm@lists.01.org>; Wed, 21 Apr 2021 23:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Htu27fcauCIeNAT1CNME/QOxZktPj64iBdmB2H8njcI=; b=lXK4RR4Pe60ylqYwFlXI3ChRDG
	hnSeO4/GoHq6M4ceNs1tOYvp3YWuD+GKnaJvIyIVtO/5o4GWvRXFS07DoScW4oAtcmps8EO6aRU1c
	VmosGKwwBKzJwQEV1mxrRpCca+iZxVVoPyqGbR0X6xfGWGhgUVLI1y52DpeHyC298ABQdVzSwAXBt
	Igmc+kY4Kf+jUbQpwCDifRqjEKCwHlpdFjC4pESppVPyYEoOu8OTUlYK04EbJflYwYRl1QQIy9WFF
	LJfj25QfbZ51TB4ExKQ0Tvkl1/qNEWp6iGCxcZLyyKjnh4nv947zhFCKOfWE9eSO9D7Le8Xe2pPq8
	tNHCH/xw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
	id 1lZSlm-00HWdr-8a; Thu, 22 Apr 2021 06:25:02 +0000
Date: Thu, 22 Apr 2021 07:24:58 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [Virtio-fs] [PATCH v3 2/3] dax: Add a wakeup mode parameter to
 put_unlocked_entry()
Message-ID: <20210422062458.GA4176641@infradead.org>
References: <20210419213636.1514816-1-vgoyal@redhat.com>
 <20210419213636.1514816-3-vgoyal@redhat.com>
 <20210420093420.2eed3939@bahia.lan>
 <20210420140033.GA1529659@redhat.com>
 <CAPcyv4g2raipYhivwbiSvsHmSdgLO8wphh5dhY3hpjwko9G4Hw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4g2raipYhivwbiSvsHmSdgLO8wphh5dhY3hpjwko9G4Hw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: S7N74UGMJF4AIEQPK54DRAMKCJK5VHTX
X-Message-ID-Hash: S7N74UGMJF4AIEQPK54DRAMKCJK5VHTX
X-MailFrom: BATV+3eeb648068207d7d58b2+6451+infradead.org+hch@casper.srs.infradead.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Greg Kurz <groug@kaod.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Miklos Szeredi <miklos@szeredi.hu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtio-fs-list <virtio-fs@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/S7N74UGMJF4AIEQPK54DRAMKCJK5VHTX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Apr 21, 2021 at 12:09:54PM -0700, Dan Williams wrote:
> Can you get in the habit of not replying inline with new patches like
> this? Collect the review feedback, take a pause, and resend the full
> series so tooling like b4 and patchwork can track when a new posting
> supersedes a previous one. As is, this inline style inflicts manual
> effort on the maintainer.

Honestly I don't mind it at all.  If you shiny new tooling can't handle
it maybe you should fix your shiny new tooling instead of changing
everyones workflow?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
