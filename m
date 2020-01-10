Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D1821136D2C
	for <lists+linux-nvdimm@lfdr.de>; Fri, 10 Jan 2020 13:36:39 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1049710097DD1;
	Fri, 10 Jan 2020 04:39:57 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=batv+524c891bdf23d94d05f7+5983+infradead.org+hch@bombadil.srs.infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 994CD10097DD0
	for <linux-nvdimm@lists.01.org>; Fri, 10 Jan 2020 04:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	 bh=f/42qAPbVsW+72MUlq6/DiKhzWxy8T8Hdkwap/qT96A=; b=fEApSJolHaXmpdLYBb+Kkv8Df
	BGQz3JHJbvpYxwghgcQ6w2GqDx37gBdlNAcBRR2IhHq7bLXUI0kKJMEKsa0vIsqtORSOf/CH4cE5T
	Xwsj1uGAQtxR/yLpUOSiwVEBEYdzPgHAUs1ofiX1hdTQu1EHvg1Xy/6nf0/BV6/6Z1co1P+6cHxk4
	Xnqyp0cPEwm83h6/DTRS+riPEzRcEw3vnnEH/NSQGzCNmLwpBofZFEikltSBx+l2HJgHLATqQTKvr
	Z23nhy3IejVYasyMnB5v/3udsJnqEdFD3lfUFeQnEoms+RUyXa2IO2K0GKHmbFdvlPMuh4SZezxpr
	LkSZT0k7A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iptWh-0006RF-VG; Fri, 10 Jan 2020 12:36:31 +0000
Date: Fri, 10 Jan 2020 04:36:31 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 01/19] dax: remove block device dependencies
Message-ID: <20200110123631.GA16268@infradead.org>
References: <20200107125159.GA15745@infradead.org>
 <CAPcyv4jZE35sbDo6J4ihioEUFTuekJ3_h0=2Ra4PY+xn2xn1cQ@mail.gmail.com>
 <20200107170731.GA472641@magnolia>
 <CAPcyv4ggH7-QhYg+YOOWn_m25uds+-0L46=N09ap-LALeGuU_A@mail.gmail.com>
 <20200107180101.GC15920@redhat.com>
 <CAPcyv4gmdoqpwwwy4dS3D2eZFjmJ_Zi39k=1a4wn-_ksm-UV4A@mail.gmail.com>
 <20200107183307.GD15920@redhat.com>
 <CAPcyv4ggoS4dWjq-1KbcuaDtroHKEi5Vu19ggJ-qgycs6w1eCA@mail.gmail.com>
 <20200109112447.GG27035@quack2.suse.cz>
 <CAPcyv4j5Mra8qeLO3=+BYZMeXNAxFXv7Ex7tL9gra1TbhOgiqg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4j5Mra8qeLO3=+BYZMeXNAxFXv7Ex7tL9gra1TbhOgiqg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: A6FRPAN4KKWLNZLF2ZA625KRYGW3ZX6V
X-Message-ID-Hash: A6FRPAN4KKWLNZLF2ZA625KRYGW3ZX6V
X-MailFrom: BATV+524c891bdf23d94d05f7+5983+infradead.org+hch@bombadil.srs.infradead.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Jan Kara <jack@suse.cz>, "Darrick J. Wong" <darrick.wong@oracle.com>, Christoph Hellwig <hch@infradead.org>, Dave Chinner <david@fromorbit.com>, Miklos Szeredi <miklos@szeredi.hu>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/A6FRPAN4KKWLNZLF2ZA625KRYGW3ZX6V/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jan 09, 2020 at 12:03:01PM -0800, Dan Williams wrote:
> > So I'd find two options reasonably consistent:
> > 1) Keep status quo where partitions are created and support DAX.
> > 2) Stop partition creation altogether, if anyones wants to split pmem
> > device further, he can use dm-linear for that (i.e., kpartx).
> >
> > But I'm not sure if the ship hasn't already sailed for option 2) to be
> > feasible without angry users and Linus reverting the change.
> 
> Christoph? I feel myself leaning more and more to the "keep pmem
> partitions" camp.
> 
> I don't see "drop partition support" effort ending well given the long
> standing "ext4 fails to mount when dax is not available" precedent.

Do we have any evidence of existing setups with DAX and partitions?
Can we just throw in a patch to reject that case for now before actually
removing the code and see if anyone screams.  And fix ext4 up while
we are at it.

> I think the next least bad option is to have a dax_get_by_host()
> variant that passes an offset and length pair rather than requiring a
> later bdev_dax_pgoff() to recall the offset. This also prevents
> needing to add another dax-device object representation.

IFF we have to keep partition support, yes.  But keeping it just seems
like a really bad idea.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
