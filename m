Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A04D517983D
	for <lists+linux-nvdimm@lfdr.de>; Wed,  4 Mar 2020 19:44:55 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1BC0910FC36D8;
	Wed,  4 Mar 2020 10:45:45 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.120; helo=us-smtp-1.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [207.211.31.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 50F7010FC36D6
	for <linux-nvdimm@lists.01.org>; Wed,  4 Mar 2020 10:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1583347489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=moXPAdEKcwvW7/ixmstEWxx99dGc7wM8ZSRE9ppHmFY=;
	b=GNrbkIwpW346lFxkYRVthZdW9bRhmsCmYhLhSgqEHSLyZMJZTSZFniESJwd9CzIZCQuM+A
	eLeXmCP2IArQ+/aO9/bR532n8wO3KzbjdY2aj2Y5CO04Ug6G+TNczQVUTOgB5BK+w+1e3h
	2sx8f75NEKsj9rzzKI2t7clUqVCUQ00=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-LQUr4p8ZOWSOu8VP_5g3PA-1; Wed, 04 Mar 2020 13:44:45 -0500
X-MC-Unique: LQUr4p8ZOWSOu8VP_5g3PA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51728100550E;
	Wed,  4 Mar 2020 18:44:44 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B21E49CA3;
	Wed,  4 Mar 2020 18:44:41 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id 5286E2257D2; Wed,  4 Mar 2020 13:44:41 -0500 (EST)
Date: Wed, 4 Mar 2020 13:44:41 -0500
From: Vivek Goyal <vgoyal@redhat.com>
To: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: Re: [PATCH v6 1/6] pmem: Add functions for reading/writing page
 to/from pmem
Message-ID: <20200304184441.GE21542@redhat.com>
References: <20200228163456.1587-1-vgoyal@redhat.com>
 <20200228163456.1587-2-vgoyal@redhat.com>
 <CAM9Jb+gJWH_bC-9fgGdeP5LaSVjJ3JgTnjBxpRJMfe6vbTPOTA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAM9Jb+gJWH_bC-9fgGdeP5LaSVjJ3JgTnjBxpRJMfe6vbTPOTA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Message-ID-Hash: TEFNFLM22KSX62N55WMI5UXJJOOO5ZGF
X-Message-ID-Hash: TEFNFLM22KSX62N55WMI5UXJJOOO5ZGF
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org, hch@infradead.org, david@fromorbit.com, dm-devel@redhat.com, Christoph Hellwig <hch@lst.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TEFNFLM22KSX62N55WMI5UXJJOOO5ZGF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, Feb 29, 2020 at 09:04:00AM +0100, Pankaj Gupta wrote:
> On Fri, 28 Feb 2020 at 17:35, Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > This splits pmem_do_bvec() into pmem_do_read() and pmem_do_write().
> > pmem_do_write() will be used by pmem zero_page_range() as well. Hence
> > sharing the same code.
> >
> > Suggested-by: Christoph Hellwig <hch@infradead.org>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > ---
> >  drivers/nvdimm/pmem.c | 86 +++++++++++++++++++++++++------------------
> >  1 file changed, 50 insertions(+), 36 deletions(-)
> >
> > diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> > index 4eae441f86c9..075b11682192 100644
> > --- a/drivers/nvdimm/pmem.c
> > +++ b/drivers/nvdimm/pmem.c
> > @@ -136,9 +136,25 @@ static blk_status_t read_pmem(struct page *page, unsigned int off,
> >         return BLK_STS_OK;
> >  }
> >
> > -static blk_status_t pmem_do_bvec(struct pmem_device *pmem, struct page *page,
> > -                       unsigned int len, unsigned int off, unsigned int op,
> > -                       sector_t sector)
> > +static blk_status_t pmem_do_read(struct pmem_device *pmem,
> > +                       struct page *page, unsigned int page_off,
> > +                       sector_t sector, unsigned int len)
> > +{
> > +       blk_status_t rc;
> > +       phys_addr_t pmem_off = sector * 512 + pmem->data_offset;
> 
> minor nit,  maybe 512 is replaced by macro? Looks like its used at multiple
> places, maybe can keep at is for now.

This came from existing code. If I end up spinning this patch series
again, I will replace it with (sector << SECTOR_SHIFT).

Thanks
Vivek
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
