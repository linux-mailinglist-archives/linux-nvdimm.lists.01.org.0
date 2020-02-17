Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C477161969
	for <lists+linux-nvdimm@lfdr.de>; Mon, 17 Feb 2020 19:08:19 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 490BA10FC3170;
	Mon, 17 Feb 2020 10:11:34 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.120; helo=us-smtp-1.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [205.139.110.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id F07441007A82E
	for <linux-nvdimm@lists.01.org>; Mon, 17 Feb 2020 10:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1581962894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oKPYNNkCF3IqXeM4Sekm3RjE/MqPpfUyUylxVmrQRcA=;
	b=bNnADejCeZDpyJt5VDTd5r94tSxH9TmJk/myLDwSOctXjzBQ16rUpj16VaIsDMZauVZu7B
	jx/jzejlwzmCBIPZGgmBA+Y7RFd/oZQojtMPq2wOSX+OAIA/ctncBOF9mkVnbaxMKG3kx/
	mVFQI+Sxrl6C211irTnKOVld0BpQo1E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-3WlWElH3Ph-COvLq3VxCdg-1; Mon, 17 Feb 2020 13:08:12 -0500
X-MC-Unique: 3WlWElH3Ph-COvLq3VxCdg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2248107ACC5;
	Mon, 17 Feb 2020 18:08:10 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E649D19C69;
	Mon, 17 Feb 2020 18:08:07 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id 770172257D2; Mon, 17 Feb 2020 13:08:07 -0500 (EST)
Date: Mon, 17 Feb 2020 13:08:07 -0500
From: Vivek Goyal <vgoyal@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v3 3/7] dax, pmem: Add a dax operation zero_page_range
Message-ID: <20200217180807.GC24816@redhat.com>
References: <20200207202652.1439-1-vgoyal@redhat.com>
 <20200207202652.1439-4-vgoyal@redhat.com>
 <20200217132607.GD14490@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200217132607.GD14490@infradead.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Message-ID-Hash: 4AO5MPLENL4VXOSTGETSOXSYGROYD46Q
X-Message-ID-Hash: 4AO5MPLENL4VXOSTGETSOXSYGROYD46Q
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org, dm-devel@redhat.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4AO5MPLENL4VXOSTGETSOXSYGROYD46Q/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Feb 17, 2020 at 05:26:07AM -0800, Christoph Hellwig wrote:
> > +	int rc;
> > +	struct pmem_device *pmem = dax_get_private(dax_dev);
> > +	struct page *page = ZERO_PAGE(0);
> 
> Nit: I tend to find code easier to read if variable declarations
> with assignments are above those without.

Fixed in V4. 

> 
> Also I don't think we need the page variable here.

Fixed in V4.

> 
> > +	rc = pmem_do_write(pmem, page, 0, offset, len);
> > +	if (rc > 0)
> > +		return -EIO;
> 
> pmem_do_write returns a blk_status_t, so the type of rc and the > check
> seem odd.  But I think pmem_do_write (and pmem_do_read) might be better
> off returning a normal errno anyway.

Now I am using blk_status_to_errno() to convert error in V4.

        rc = pmem_do_write(pmem, ZERO_PAGE(0), 0, offset, len);
        return blk_status_to_errno(rc);

Did not modify pmem_do_read()/pmem_do_write() to return errno as there
is still one caller which expects to return blk_status_t and then that
caller will have to do the converstion.

Having said that, it probably is good idea to clean up functions called
by pmem_do_read()/pmem_do_write() to return errno. I prefer not to take
that work in that patch series as that seems like a nice to have thing
and can be handled in a separate patch series.

Thanks
Vivek
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
