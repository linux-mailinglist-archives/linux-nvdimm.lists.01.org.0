Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F02F0164D47
	for <lists+linux-nvdimm@lfdr.de>; Wed, 19 Feb 2020 19:04:11 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6526F10FC319D;
	Wed, 19 Feb 2020 10:05:02 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.81; helo=us-smtp-1.mimecast.com; envelope-from=jmoyer@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-2.mimecast.com [207.211.31.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C6634100780A7
	for <linux-nvdimm@lists.01.org>; Wed, 19 Feb 2020 10:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1582135446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1rSNrYdvxRpxUDDPHpuwK4KI7RMecWg7U4q/MyGnM6M=;
	b=CVTg5m1PgDozxrQaE7s4XedQiQcEerUOkNHABlADSeEf8jxwLplxBl3dQ5K3V2Ze7TDUxU
	do7su3Cq/+FY7XHX4b/yxGNRr4eRH01YBGELL+/y93GOoJncybnq06a93sRWtIB3FdCHXb
	LgxfY8jOIR/WC45e4u7qwUlfOBiSfSI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-RXlMpJ_rNi2bEpGcZ8mgpg-1; Wed, 19 Feb 2020 13:04:02 -0500
X-MC-Unique: RXlMpJ_rNi2bEpGcZ8mgpg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EDA068010FB;
	Wed, 19 Feb 2020 18:04:00 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8165F100EBAA;
	Wed, 19 Feb 2020 18:04:00 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [ndctl PATCH 1/2] ndctl/region: Support ndctl_region_{get, set}_align()
References: <158042414995.3946705.2742716492944802875.stgit@dwillia2-desk3.amr.corp.intel.com>
	<158042415512.3946705.18330231517256727320.stgit@dwillia2-desk3.amr.corp.intel.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Wed, 19 Feb 2020 13:03:59 -0500
In-Reply-To: <158042415512.3946705.18330231517256727320.stgit@dwillia2-desk3.amr.corp.intel.com>
	(Dan Williams's message of "Thu, 30 Jan 2020 14:42:35 -0800")
Message-ID: <x49o8tulai8.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Message-ID-Hash: 54AKC57SMJKHP3FCPMDJTOHHEYXT6ZTJ
X-Message-ID-Hash: 54AKC57SMJKHP3FCPMDJTOHHEYXT6ZTJ
X-MailFrom: jmoyer@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/54AKC57SMJKHP3FCPMDJTOHHEYXT6ZTJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dan Williams <dan.j.williams@intel.com> writes:

>  
> +NDCTL_EXPORT unsigned long ndctl_region_get_align(struct ndctl_region *region)
> +{
> +	return region->align;
> +}
> +
> +NDCTL_EXPORT int ndctl_region_set_align(struct ndctl_region *region,
> +		unsigned long align)
> +{
> +	struct ndctl_ctx *ctx = ndctl_region_get_ctx(region);
> +	char *path = region->region_buf;
> +	int len = region->buf_len, rc;
> +	char buf[SYSFS_ATTR_SIZE];
> +
> +	if (snprintf(path, len, "%s/align", region->region_path) >= len) {
> +		err(ctx, "%s: buffer too small!\n",
> +				ndctl_region_get_devname(region));
> +		return -ENXIO;
> +	}
> +
> +	sprintf(buf, "%#lx\n", align);
> +	rc = sysfs_write_attr(ctx, path, buf);
> +	if (rc < 0)
> +		return rc;
> +
> +	region->align = align;
> +	return 0;
> +}
> +

Missing doctext.  Specifically, there should be a big, fat warning
against changing the region alignment.

-Jeff
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
