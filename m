Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ABABE2BB08C
	for <lists+linux-nvdimm@lfdr.de>; Fri, 20 Nov 2020 17:29:45 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B68F3100EF27D;
	Fri, 20 Nov 2020 08:29:43 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.205.24.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jmoyer@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B442F100EF254
	for <linux-nvdimm@lists.01.org>; Fri, 20 Nov 2020 08:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1605889777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6oFc89bO86QU1mdEfCE8klKFxoaA/oLyP8YHkAY49/g=;
	b=cmW+RmJ4YoXKI3SxH+UYm5eOG/85CBi0UwReI8m0A3jmNLc2wZ+PNt/sDiWUF62BgOrZQ8
	RNgxHpzw3AqVJ/lJQYYouTQJi719uSnpvQ6ZHRXfug+IlnPG1D/1jB5oJtzU3d6TDZYF5B
	L3IvCLRJ+E+xKEhqMDsdatxi/gBRZR8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-gOWe1-XkP3KoU9EJnjAqRg-1; Fri, 20 Nov 2020 11:29:33 -0500
X-MC-Unique: gOWe1-XkP3KoU9EJnjAqRg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2CCE51A1;
	Fri, 20 Nov 2020 16:29:31 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 48F515D9D5;
	Fri, 20 Nov 2020 16:29:31 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Zhiqiang Liu <liuzhiqiang26@huawei.com>
Subject: Re: [ndctl PATCH 1/8] namespace: check whether pfn|dax|btt is NULL in setup_namespace
References: <bed3b3b3-1f30-6751-c0bf-15ecf70192f9@huawei.com>
	<4f51f398-08d0-15c9-fdcb-27b73db78d24@huawei.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Fri, 20 Nov 2020 11:29:35 -0500
In-Reply-To: <4f51f398-08d0-15c9-fdcb-27b73db78d24@huawei.com> (Zhiqiang Liu's
	message of "Fri, 6 Nov 2020 17:24:04 +0800")
Message-ID: <x494klkng9c.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jmoyer@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Message-ID-Hash: Y7L274NVLDKD66KNMG4NK3CKN6ZG6WWZ
X-Message-ID-Hash: Y7L274NVLDKD66KNMG4NK3CKN6ZG6WWZ
X-MailFrom: jmoyer@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, linfeilong <linfeilong@huawei.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/Y7L274NVLDKD66KNMG4NK3CKN6ZG6WWZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Zhiqiang Liu <liuzhiqiang26@huawei.com> writes:

> In setup_namespace(), pfn|dax|btt is obtained by calling
> ndctl_region_get_**_seed(), which may return NULL. So we
> need to check whether pfn|dax|btt is NULL before accessing
> them.
>
> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> ---
>  ndctl/namespace.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/ndctl/namespace.c b/ndctl/namespace.c
> index e946bb6..257384d 100644
> --- a/ndctl/namespace.c
> +++ b/ndctl/namespace.c
> @@ -549,6 +549,8 @@ static int setup_namespace(struct ndctl_region *region,
>
>  	if (do_setup_pfn(ndns, p)) {
>  		struct ndctl_pfn *pfn = ndctl_region_get_pfn_seed(region);
> +		if (!pfn)
> +			return -ENXIO;
>
>  		rc = check_dax_align(ndns);
>  		if (rc)
> @@ -563,6 +565,8 @@ static int setup_namespace(struct ndctl_region *region,
>  			ndctl_pfn_set_namespace(pfn, NULL);
>  	} else if (p->mode == NDCTL_NS_MODE_DEVDAX) {
>  		struct ndctl_dax *dax = ndctl_region_get_dax_seed(region);
> +		if (!dax)
> +			return -ENXIO;
>
>  		rc = check_dax_align(ndns);
>  		if (rc)
> @@ -577,7 +581,8 @@ static int setup_namespace(struct ndctl_region *region,
>  			ndctl_dax_set_namespace(dax, NULL);
>  	} else if (p->mode == NDCTL_NS_MODE_SECTOR) {
>  		struct ndctl_btt *btt = ndctl_region_get_btt_seed(region);
> -
> +		if (!btt)
> +			return -ENXIO;
>  		/*
>  		 * Handle the case of btt on a pmem namespace where the
>  		 * pmem kernel support is pre-v1.2 namespace labels

Minor inconsistency in the last hunk.  The empty line should come after
the return, no?

Other than that, LGTM.

Acked-by: Jeff Moyer <jmoyer@redhat.com>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
