Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FF520F928
	for <lists+linux-nvdimm@lfdr.de>; Tue, 30 Jun 2020 18:12:01 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 19D3F11427DBA;
	Tue, 30 Jun 2020 09:12:00 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.61; helo=us-smtp-delivery-1.mimecast.com; envelope-from=mpatocka@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com [205.139.110.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A322D1003EFE6
	for <linux-nvdimm@lists.01.org>; Tue, 30 Jun 2020 09:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1593533516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hdekUrxaV2KDuRTiDSjdTwlVovUCyT6cEg+RNMzig2I=;
	b=MHn/RMWQUCr4Wst2P2ULUDVaY3r69oEAXW1Ksc7bl4Ub7vh/5dNrS6GejYP7IOUPHRwWnH
	ajIg2wMpgwjg31J4oF9YE8/7N7MAcf+6+c+zJ/xi66sQCA5N0L2H8bK0rl2J3HvNQHBFDh
	slcc3KA963tJEGHmrDLnhxqbaGqI7QE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-DMvfPIlhMvmTntxXdpXb2w-1; Tue, 30 Jun 2020 12:11:54 -0400
X-MC-Unique: DMvfPIlhMvmTntxXdpXb2w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A12031054F9E;
	Tue, 30 Jun 2020 16:11:52 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 504BB10013C1;
	Tue, 30 Jun 2020 16:11:44 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
	by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 05UGBhxm030187;
	Tue, 30 Jun 2020 12:11:43 -0400
Received: from localhost (mpatocka@localhost)
	by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 05UGBhha030183;
	Tue, 30 Jun 2020 12:11:43 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date: Tue, 30 Jun 2020 12:11:43 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To: Michal Suchanek <msuchanek@suse.de>
Subject: Re: [PATCH v3] dm writecache: reject asynchronous pmem.
In-Reply-To: <20200630154924.3283-1-msuchanek@suse.de>
Message-ID: <alpine.LRH.2.02.2006301210270.24082@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2006301101210.24028@file01.intranet.prod.int.rdu2.redhat.com> <20200630154924.3283-1-msuchanek@suse.de>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Message-ID-Hash: YU4TMM7S7OTQSAI4ESBYFSRECP4VEX5R
X-Message-ID-Hash: YU4TMM7S7OTQSAI4ESBYFSRECP4VEX5R
X-MailFrom: mpatocka@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Jan Kara <jack@suse.cz>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com, Jakub Staron <jstaron@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, Yuval Shaia <yuval.shaia@oracle.com>, Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YU4TMM7S7OTQSAI4ESBYFSRECP4VEX5R/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Tue, 30 Jun 2020, Michal Suchanek wrote:

> The writecache driver does not handle asynchronous pmem. Reject it when
> supplied as cache.
> 
> Link: https://lore.kernel.org/linux-nvdimm/87lfk5hahc.fsf@linux.ibm.com/
> Fixes: 6e84200c0a29 ("virtio-pmem: Add virtio pmem driver")
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>

Acked-by: Mikulas Patocka <mpatocka@redhat.com>

> ---
>  drivers/md/dm-writecache.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
> index 30505d70f423..5358894bb9fd 100644
> --- a/drivers/md/dm-writecache.c
> +++ b/drivers/md/dm-writecache.c
> @@ -2266,6 +2266,12 @@ static int writecache_ctr(struct dm_target *ti, unsigned argc, char **argv)
>  	}
>  
>  	if (WC_MODE_PMEM(wc)) {
> +		if (!dax_synchronous(wc->ssd_dev->dax_dev)) {
> +			r = -EOPNOTSUPP;
> +			ti->error = "Asynchronous persistent memory not supported as pmem cache";
> +			goto bad;
> +		}
> +
>  		r = persistent_memory_claim(wc);
>  		if (r) {
>  			ti->error = "Unable to map persistent memory for cache";
> -- 
> 2.26.2
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
