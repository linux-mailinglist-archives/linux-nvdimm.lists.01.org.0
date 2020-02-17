Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7BE16195B
	for <lists+linux-nvdimm@lfdr.de>; Mon, 17 Feb 2020 19:05:08 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0664C1007B191;
	Mon, 17 Feb 2020 10:08:24 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.81; helo=us-smtp-delivery-1.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com [207.211.31.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8B69E1007B1FC
	for <linux-nvdimm@lists.01.org>; Mon, 17 Feb 2020 10:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1581962703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HRqcrGPHEdqvwZNYYrrPoLpqoBOsV7DSl5ls/cswJjQ=;
	b=GfA9XD1zYP7POT0/7FLvOimMTPEuvdm9rBANPfMjdxPODAz3W3+5sAOX4fhydlkvNmwj7M
	HI79Nx+vVl/vQ89CGZTeiFfyBZReWqAGduHDOq21KOWk2+18Cm/uTiZBR915s4popCYAhJ
	YHs8p+K8kEGp370qrwDHPuY8sXr1PHs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-Ntyb3J08PpyLN9WEeRLa9Q-1; Mon, 17 Feb 2020 13:05:01 -0500
X-MC-Unique: Ntyb3J08PpyLN9WEeRLa9Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1A5313F5;
	Mon, 17 Feb 2020 18:04:59 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B21C119C69;
	Mon, 17 Feb 2020 18:04:56 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id 2E8782257D2; Mon, 17 Feb 2020 13:04:56 -0500 (EST)
Date: Mon, 17 Feb 2020 13:04:56 -0500
From: Vivek Goyal <vgoyal@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v3 1/7] pmem: Add functions for reading/writing page
 to/from pmem
Message-ID: <20200217180456.GB24816@redhat.com>
References: <20200207202652.1439-1-vgoyal@redhat.com>
 <20200207202652.1439-2-vgoyal@redhat.com>
 <20200217132138.GB14490@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200217132138.GB14490@infradead.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Message-ID-Hash: DALL6HZ2EMMYVQ3NPFQQS6K7JKPXSNMH
X-Message-ID-Hash: DALL6HZ2EMMYVQ3NPFQQS6K7JKPXSNMH
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org, dm-devel@redhat.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DALL6HZ2EMMYVQ3NPFQQS6K7JKPXSNMH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Feb 17, 2020 at 05:21:38AM -0800, Christoph Hellwig wrote:
> On Fri, Feb 07, 2020 at 03:26:46PM -0500, Vivek Goyal wrote:
> > +static blk_status_t pmem_do_bvec(struct pmem_device *pmem, struct page *page,
> > +			unsigned int len, unsigned int off, unsigned int op,
> > +			sector_t sector)
> > +{
> > +	if (!op_is_write(op))
> > +		return pmem_do_read(pmem, page, off, sector, len);
> > +
> > +	return pmem_do_write(pmem, page, off, sector, len);
> 
> Why not:
> 
> 	if (op_is_write(op))
> 		return pmem_do_write(pmem, page, off, sector, len);
> 	return pmem_do_read(pmem, page, off, sector, len);
> 
> that being said I don't see the point of this pmem_do_bvec helper given
> that it only has two callers.

Ok, I am about to post V4 of patches and I got rid of pmem_do_bvec() and
callers are directly calling pmem_do_read()/pmem_do_write().

Vivek
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
