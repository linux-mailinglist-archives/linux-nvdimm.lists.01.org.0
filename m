Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DE3155ABF
	for <lists+linux-nvdimm@lfdr.de>; Fri,  7 Feb 2020 16:31:21 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 427D11007B1C7;
	Fri,  7 Feb 2020 07:34:36 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.120; helo=us-smtp-1.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [207.211.31.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9BADF1007B1C6
	for <linux-nvdimm@lists.01.org>; Fri,  7 Feb 2020 07:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1581089475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lJl9IZ4rUKZV3MVrE3d9DP7C/ZB0uGxE0eGmP9j33k8=;
	b=PGuq9NkNAKhjROaBmo5RAfHQIYDjjK6NZZGR28zo2Twdq0UYn2lFAqgBfkAS1rMGDFfZpL
	OBdWWBCrhRzIbKR4nHI5/zicNIM3ew8/rUWk+LT6/fwE47CVl1X7IXaCpLPDQCOBFT/VgV
	zKwY9PRgZSaUJ+LZ4umNNkJSCEeUsBs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-uIY1Wbw4ODWEPr8MtHbRMg-1; Fri, 07 Feb 2020 10:31:11 -0500
X-MC-Unique: uIY1Wbw4ODWEPr8MtHbRMg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7746189F762;
	Fri,  7 Feb 2020 15:31:09 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D38B68ECE6;
	Fri,  7 Feb 2020 15:31:06 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id 645CD220A24; Fri,  7 Feb 2020 10:31:06 -0500 (EST)
Date: Fri, 7 Feb 2020 10:31:06 -0500
From: Vivek Goyal <vgoyal@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 4/5] dax,iomap: Start using dax native zero_page_range()
Message-ID: <20200207153106.GA11998@redhat.com>
References: <20200203200029.4592-1-vgoyal@redhat.com>
 <20200203200029.4592-5-vgoyal@redhat.com>
 <20200205183356.GD26711@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200205183356.GD26711@infradead.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Message-ID-Hash: BKDZ2PUUQDVZKPVXU6J6FVIERJNNIQEA
X-Message-ID-Hash: BKDZ2PUUQDVZKPVXU6J6FVIERJNNIQEA
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org, dm-devel@redhat.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BKDZ2PUUQDVZKPVXU6J6FVIERJNNIQEA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Feb 05, 2020 at 10:33:56AM -0800, Christoph Hellwig wrote:
> On Mon, Feb 03, 2020 at 03:00:28PM -0500, Vivek Goyal wrote:
> > +	id = dax_read_lock();
> > +	rc = dax_zero_page_range(dax_dev, pgoff, offset, size);
> > +	dax_read_unlock(id);
> > +	return rc;
> 
> Is there a good reason not to move the locking into dax_zero_page_range?

Thinking more about it. If we keep locking outside, then we don't have
to take lock again when we recurse into dax_zero_page_range() in device
mapper path. IIUC, just taking lock once at top level is enough. If that's
the case then it probably is better to keep locking outside of
dax_zero_page_range().

Thanks
Vivek
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
