Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F23352BB09E
	for <lists+linux-nvdimm@lfdr.de>; Fri, 20 Nov 2020 17:33:49 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2EB81100ED484;
	Fri, 20 Nov 2020 08:33:48 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=63.128.21.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jmoyer@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [63.128.21.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id F2926100EF27E
	for <linux-nvdimm@lists.01.org>; Fri, 20 Nov 2020 08:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1605890024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w9/LOZ+bXWKTtgwuuPhRfmRsPNGdW9+R8AWTzjxw3iw=;
	b=dSaOTgGdsS74xTUq4LEo2h4w43H2WVWaK3qWDpvwgDpruULjIqM6lBZJdHQ93OZmgMN566
	lIzCEtFKUAqbGSu3OqcHDjEZ4HwN/r5BtMTJ+Ox6RpN2lMdOkDlagwEv33zO5pfWzrhJAI
	eQ+K9z+Z3YZztgl2OFP6qaPdcuxc7k0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-524-sgzfpuAhM2W82sWoJhcK8w-1; Fri, 20 Nov 2020 11:33:42 -0500
X-MC-Unique: sgzfpuAhM2W82sWoJhcK8w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21506873088;
	Fri, 20 Nov 2020 16:33:41 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A28FE19C71;
	Fri, 20 Nov 2020 16:33:40 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Zhiqiang Liu <liuzhiqiang26@huawei.com>
Subject: Re: [ndctl PATCH 3/8] libdaxctl: fix memory leakage in add_dax_region()
References: <bed3b3b3-1f30-6751-c0bf-15ecf70192f9@huawei.com>
	<7ae72048-0c26-9da2-41a9-c1b63a8db117@huawei.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Fri, 20 Nov 2020 11:33:45 -0500
In-Reply-To: <7ae72048-0c26-9da2-41a9-c1b63a8db117@huawei.com> (Zhiqiang Liu's
	message of "Fri, 6 Nov 2020 17:25:32 +0800")
Message-ID: <x49v9e0m1hy.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jmoyer@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Message-ID-Hash: SSD43WMCVN3YM4LVLNKMLCUDAS5LAPHI
X-Message-ID-Hash: SSD43WMCVN3YM4LVLNKMLCUDAS5LAPHI
X-MailFrom: jmoyer@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, linfeilong <linfeilong@huawei.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SSD43WMCVN3YM4LVLNKMLCUDAS5LAPHI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Zhiqiang Liu <liuzhiqiang26@huawei.com> writes:

> In add_dax_region(), region->devname is allocated by
> calling strdup(), which may return NULL. So, we need
> to check whether region->devname is NULL, and free
> region->devname in err_read tag.
>
> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> ---
>  daxctl/lib/libdaxctl.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/libdaxctl.c
> index ee4a069..d841b78 100644
> --- a/daxctl/lib/libdaxctl.c
> +++ b/daxctl/lib/libdaxctl.c
> @@ -287,6 +287,8 @@ static struct daxctl_region *add_dax_region(void *parent, int id,
>  	region->refcount = 1;
>  	list_head_init(&region->devices);
>  	region->devname = strdup(devpath_to_devname(base));
> +	if (!region->devname)
> +		goto err_read;
>
>  	sprintf(path, "%s/%s/size", base, attrs);
>  	if (sysfs_read_attr(ctx, path, buf) == 0)
> @@ -314,6 +316,7 @@ static struct daxctl_region *add_dax_region(void *parent, int id,
>   err_read:
>  	free(region->region_buf);
>  	free(region->region_path);
> +	free(region->devname);
>  	free(region);
>   err_region:
>  	free(path);

Acked-by: Jeff Moyer <jmoyer@redhat.com>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
