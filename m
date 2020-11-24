Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C12B2C2A7B
	for <lists+linux-nvdimm@lfdr.de>; Tue, 24 Nov 2020 15:55:51 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2043D100EBBA8;
	Tue, 24 Nov 2020 06:55:49 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.205.24.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jmoyer@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 861FF100EF263
	for <linux-nvdimm@lists.01.org>; Tue, 24 Nov 2020 06:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1606229744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IDhfVYWGoL+IpVNQ3e9z+GzCQ3AwBmJ5YyBaFP+39/s=;
	b=NzH85F2xYPSuhTzemjNAZOKzFWzZhBrQtuFHJQKR79udsexoen6XUlWMmr7dgqz8K0gKhQ
	mHvjewEeQZjNflGvb6d4HdJUzx5njjK3EIsLrBl61iVT6doUDNsp7NmlGNd4Ahmyqhimt+
	yhCSRpAtIv7ctB7Npt5+4Gz9Qw0SwQw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-uhRFpvSLPfWubnd5bhYaXw-1; Tue, 24 Nov 2020 09:55:42 -0500
X-MC-Unique: uhRFpvSLPfWubnd5bhYaXw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E98ED9A229;
	Tue, 24 Nov 2020 14:55:40 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5BDB65D6AB;
	Tue, 24 Nov 2020 14:55:40 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] ACPI: NFIT: Fix input validation of bus-family
References: <160619566216.201177.9354229595539334957.stgit@dwillia2-desk3.amr.corp.intel.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Tue, 24 Nov 2020 09:55:44 -0500
In-Reply-To: <160619566216.201177.9354229595539334957.stgit@dwillia2-desk3.amr.corp.intel.com>
	(Dan Williams's message of "Mon, 23 Nov 2020 21:27:42 -0800")
Message-ID: <x49ft4yiz2n.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Message-ID-Hash: ATJDE3GR5BBFSXPV2XMGT6N7P47HUWCG
X-Message-ID-Hash: ATJDE3GR5BBFSXPV2XMGT6N7P47HUWCG
X-MailFrom: jmoyer@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, Dan Carpenter <dan.carpenter@oracle.com>, stable@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ATJDE3GR5BBFSXPV2XMGT6N7P47HUWCG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dan Williams <dan.j.williams@intel.com> writes:

> Dan reports that smatch thinks userspace can craft an out-of-bound bus
> family number. However, nd_cmd_clear_to_send() blocks all non-zero
> values of bus-family since only the kernel can initiate these commands.
> However, in the speculation path, family is a user controlled array
> index value so mask it for speculation safety. Also, since the
> nd_cmd_clear_to_send() safety is non-obvious and possibly may change in
> the future include input validation is if userspace could get past the
> nd_cmd_clear_to_send() gatekeeper.
>
> Link: http://lore.kernel.org/r/20201111113000.GA1237157@mwanda
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Fixes: 6450ddbd5d8e ("ACPI: NFIT: Define runtime firmware activation commands")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/acpi/nfit/core.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index cda7b6c52504..b11b08a60684 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -5,6 +5,7 @@
>  #include <linux/list_sort.h>
>  #include <linux/libnvdimm.h>
>  #include <linux/module.h>
> +#include <linux/nospec.h>
>  #include <linux/mutex.h>
>  #include <linux/ndctl.h>
>  #include <linux/sysfs.h>
> @@ -479,8 +480,11 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
>  		cmd_mask = nd_desc->cmd_mask;
>  		if (cmd == ND_CMD_CALL && call_pkg->nd_family) {
>  			family = call_pkg->nd_family;
> -			if (!test_bit(family, &nd_desc->bus_family_mask))
> +			if (family > NVDIMM_BUS_FAMILY_MAX ||
> +			    !test_bit(family, &nd_desc->bus_family_mask))
>  				return -EINVAL;
> +			family = array_index_nospec(family,
> +						    NVDIMM_BUS_FAMILY_MAX + 1);
>  			dsm_mask = acpi_desc->family_dsm_mask[family];
>  			guid = to_nfit_bus_uuid(family);
>  		} else {

Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
