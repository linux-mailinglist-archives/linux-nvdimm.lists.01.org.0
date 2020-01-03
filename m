Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B42512FCB4
	for <lists+linux-nvdimm@lfdr.de>; Fri,  3 Jan 2020 19:43:34 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 28DFB10097DF6;
	Fri,  3 Jan 2020 10:46:52 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.81; helo=us-smtp-delivery-1.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com [207.211.31.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id ADCD310097DF5
	for <linux-nvdimm@lists.01.org>; Fri,  3 Jan 2020 10:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1578077008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G06rLs4TL8KIzGAoCVXXQSepgpLI5vBIheYDXyHB7xI=;
	b=BynYiSsVnl2x/cMF1J9GWJb3huRUQhQ6muLQv8TnRNYyyTMzIa/U2cNklV9K4RMpZXD20O
	aUdsK291GiwjgYVFR4gL3IS53EG81u3wKo7I2NIsRXobOf3kMNEuCUbO1+DzaAU2haegFR
	WSTN2EyiNuHffYgyxQCpxTcSHXi9nFU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-NDHRQ768NaqZh93_ibVOCw-1; Fri, 03 Jan 2020 13:43:24 -0500
X-MC-Unique: NDHRQ768NaqZh93_ibVOCw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 059151801256;
	Fri,  3 Jan 2020 18:43:23 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DECFF10021B2;
	Fri,  3 Jan 2020 18:43:17 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id 7907C2202E9; Fri,  3 Jan 2020 13:43:17 -0500 (EST)
Date: Fri, 3 Jan 2020 13:43:17 -0500
From: Vivek Goyal <vgoyal@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 02/19] dax: Pass dax_dev to dax_writeback_mapping_range()
Message-ID: <20200103184317.GC13350@redhat.com>
References: <20190821175720.25901-1-vgoyal@redhat.com>
 <20190821175720.25901-3-vgoyal@redhat.com>
 <20190826115316.GB21051@infradead.org>
 <20190826203326.GB13860@redhat.com>
 <20190826205829.GC13860@redhat.com>
 <20200103141235.GA13350@redhat.com>
 <CAPcyv4hr-KXUAT_tVy-GuTOq1GvVGHKsHwAPih60wcW3DGmqRg@mail.gmail.com>
 <CAPcyv4jM8s8T5ifv0c2eyqaBu3f2bd_j+fQHmJttZAajZ-we=g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4jM8s8T5ifv0c2eyqaBu3f2bd_j+fQHmJttZAajZ-we=g@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Message-ID-Hash: 6U3QTDFZFS6AFY2LUADO3RASIVV4QUFG
X-Message-ID-Hash: 6U3QTDFZFS6AFY2LUADO3RASIVV4QUFG
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, virtio-fs@redhat.com, Miklos Szeredi <miklos@szeredi.hu>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Christoph Hellwig <hch@infradead.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6U3QTDFZFS6AFY2LUADO3RASIVV4QUFG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jan 03, 2020 at 10:18:22AM -0800, Dan Williams wrote:

> I'll also circle back to your question about
> partitions on patch1.

Hi Dan,

I was playing with having sector information in dax device (and not having
to look back at bdev). I was thinking of something as follows.

- Create a new structure/handle which also contains offset into dax device
  in sectors. Say.

  struct dax_handle {
  	sector_t start_sect;
  	struct dax_device *dax_dev;
  }

 This handle will have pointer to the actual dax device.

- Modify dax_get_by_bdev(struct block_device *bdev) to return dax_handle
  (instead of dax device).

  struct dax_handle *dax_get_by_bdev(struct block_device *bdev);

  This will create dax_handle. Find dax_device from hash table and
  initialize dax_handle.

  dax_handle->start_sect = get_start_sect(bdev);
  dax_handle->dax_dev = dax_dev;

  Now filesystem and stacked block devices can get pointer to dax_handle
  using block device and they can use this handle to refer to underlying
  dax device partition.

- Now dax_handle can be passed around and hopefully we can get rid of
  passing around bdev in many of the dax interfaces. And partition offset
  information has now moved into dax_handle.

- For the use cases which don't have a bdev (like virtiofs), we can
  provide another helper to get dax_handle with offset 0. And then
  we should not need a bdev to be able to use dax API.

Does this sound like a reasonable step in the direction of getting rid
of this assumption that every dax_device has associated block_device.

Thanks
Vivek
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
