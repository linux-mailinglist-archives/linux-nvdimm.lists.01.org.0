Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D491633A1
	for <lists+linux-nvdimm@lfdr.de>; Tue, 18 Feb 2020 22:00:26 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0426110FC33EE;
	Tue, 18 Feb 2020 13:01:12 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.81; helo=us-smtp-delivery-1.mimecast.com; envelope-from=jmoyer@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com [207.211.31.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7123010FC3384
	for <linux-nvdimm@lists.01.org>; Tue, 18 Feb 2020 13:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1582059616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R+5nH0RbYnRX8oS+gNkYUcbLgvJOnmEAnQ8QVqp5CYo=;
	b=QP9z+vzg6gdtj23gi9gz6nV1ywUr4ISQYVdStz1I9NOj8JzB7gjXcyGnhMYOm8zIivjzGb
	BklJfoEZb9nsDYfP/3mI/Bb9dOt5ETMTTAa+bP667K4tbu51kZRuv9HfVeAkF7COwuf/NW
	y6kAzeNhLTFsylspipor6u9xU5943DM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-tFGKheXRND-26PKBmDudDQ-1; Tue, 18 Feb 2020 16:00:13 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7E2B18C8C39;
	Tue, 18 Feb 2020 21:00:11 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EA9D438D;
	Tue, 18 Feb 2020 21:00:10 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [PATCH] libnvdimm/bus: return the outvar 'cmd_rc' error code in __nd_ioctl()
References: <20200122155304.120733-1-vaibhav@linux.ibm.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Tue, 18 Feb 2020 16:00:09 -0500
In-Reply-To: <20200122155304.120733-1-vaibhav@linux.ibm.com> (Vaibhav Jain's
	message of "Wed, 22 Jan 2020 21:23:04 +0530")
Message-ID: <x49r1yrboh2.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: tFGKheXRND-26PKBmDudDQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Message-ID-Hash: XP7SE3Y4JMZWP5HBOL5OWL74C6XM6A6A
X-Message-ID-Hash: XP7SE3Y4JMZWP5HBOL5OWL74C6XM6A6A
X-MailFrom: jmoyer@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XP7SE3Y4JMZWP5HBOL5OWL74C6XM6A6A/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Vaibhav Jain <vaibhav@linux.ibm.com> writes:

> Presently the error code returned via out variable 'cmd_rc' from the
> nvdimm-bus controller function is ignored when called from
> __nd_ioctl() and never communicated back to user-space code that called
> an ioctl on dimm/bus.
>
> This minor patch updates __nd_ioctl() to propagate the value of out
> variable 'cmd_rc' back to user-space in case it reports an error.
>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---
>  drivers/nvdimm/bus.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
> index a8b515968569..5b687a27fdf2 100644
> --- a/drivers/nvdimm/bus.c
> +++ b/drivers/nvdimm/bus.c
> @@ -1153,6 +1153,11 @@ static int __nd_ioctl(struct nvdimm_bus *nvdimm_bus, struct nvdimm *nvdimm,
>  	if (rc < 0)
>  		goto out_unlock;
>  
> +	if (cmd_rc < 0) {
> +		rc = cmd_rc;
> +		goto out_unlock;
> +	}
> +
>  	if (!nvdimm && cmd == ND_CMD_CLEAR_ERROR && cmd_rc >= 0) {
>  		struct nd_cmd_clear_error *clear_err = buf;

Looks good to me.

Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
