Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C34E18092D
	for <lists+linux-nvdimm@lfdr.de>; Tue, 10 Mar 2020 21:30:05 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1D76D10FC3632;
	Tue, 10 Mar 2020 13:30:55 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.81; helo=us-smtp-delivery-1.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com [207.211.31.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B7C9F10FC362F
	for <linux-nvdimm@lists.01.org>; Tue, 10 Mar 2020 13:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1583872200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0k5j5BAO6+j561EWRZLgyRnG3Sw+2DCMIk63U5xiOW4=;
	b=S36H2nQPO8rQ1UBKubkoH5TZ8zRku1GC6rlAj69IDVYaXubo2sXXGk7vP+irJPp1oP0sn4
	AmmPIwntMnZAXQY5GZhmcvPv0T5R+eo+JKLTVIS8N/3tNNctUxbIE5SHp1OTl6eds0MwBP
	k6egP86mC/qVLEPksbukXEPF1xVTEHw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-w0BHEEh_N8eJI055Y3zOFQ-1; Tue, 10 Mar 2020 16:29:56 -0400
X-MC-Unique: w0BHEEh_N8eJI055Y3zOFQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 464561005514;
	Tue, 10 Mar 2020 20:29:55 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.210])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EA87A1001DC2;
	Tue, 10 Mar 2020 20:29:46 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id 7345D22021D; Tue, 10 Mar 2020 16:29:46 -0400 (EDT)
Date: Tue, 10 Mar 2020 16:29:46 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH 02/20] dax: Create a range version of
 dax_layout_busy_page()
Message-ID: <20200310202946.GE38440@redhat.com>
References: <20200304165845.3081-1-vgoyal@redhat.com>
 <20200304165845.3081-3-vgoyal@redhat.com>
 <20200310151906.GA670549@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200310151906.GA670549@iweiny-DESK2.sc.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Message-ID-Hash: XTEPJZDWLPWNEEFLVSPRYOO52HNNRZRD
X-Message-ID-Hash: XTEPJZDWLPWNEEFLVSPRYOO52HNNRZRD
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, virtio-fs@redhat.com, miklos@szeredi.hu, stefanha@redhat.com, dgilbert@redhat.com, mst@redhat.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XTEPJZDWLPWNEEFLVSPRYOO52HNNRZRD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Mar 10, 2020 at 08:19:07AM -0700, Ira Weiny wrote:
> On Wed, Mar 04, 2020 at 11:58:27AM -0500, Vivek Goyal wrote:
> >  
> > +	/* If end == 0, all pages from start to till end of file */
> > +	if (!end) {
> > +		end_idx = ULONG_MAX;
> > +		len = 0;
> 
> I find this a bit odd to specify end == 0 for ULONG_MAX...
> 
> >  }
> > +EXPORT_SYMBOL_GPL(dax_layout_busy_page_range);
> > +
> > +/**
> > + * dax_layout_busy_page - find first pinned page in @mapping
> > + * @mapping: address space to scan for a page with ref count > 1
> > + *
> > + * DAX requires ZONE_DEVICE mapped pages. These pages are never
> > + * 'onlined' to the page allocator so they are considered idle when
> > + * page->count == 1. A filesystem uses this interface to determine if
> > + * any page in the mapping is busy, i.e. for DMA, or other
> > + * get_user_pages() usages.
> > + *
> > + * It is expected that the filesystem is holding locks to block the
> > + * establishment of new mappings in this address_space. I.e. it expects
> > + * to be able to run unmap_mapping_range() and subsequently not race
> > + * mapping_mapped() becoming true.
> > + */
> > +struct page *dax_layout_busy_page(struct address_space *mapping)
> > +{
> > +	return dax_layout_busy_page_range(mapping, 0, 0);
> 
> ... other functions I have seen specify ULONG_MAX here.  Which IMO makes this
> call site more clear.

I think I looked at unmap_mapping_range() where holelen=0 implies till the
end of file and followed same pattern.

But I agree that LLONG_MAX (end is of type loff_t) is probably more
intuitive. I will change it.

Vivek
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
