Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EABA31C139
	for <lists+linux-nvdimm@lfdr.de>; Mon, 15 Feb 2021 19:15:00 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CF194100EBBBD;
	Mon, 15 Feb 2021 10:14:57 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=63.128.21.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jmoyer@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [63.128.21.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B3275100EC1EE
	for <linux-nvdimm@lists.01.org>; Mon, 15 Feb 2021 10:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1613412894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jdxZgnRtW/dPS1rQNcZoXborknSPSs2HnDCVjOoAe5A=;
	b=geVY2GXz7CcX4+VVbuAWTLT/fpqgjUaoWuLBaNttkpJtUG+rteX7S2qolcLzC9/9ENBHTl
	4JyDm893zMk9DyU5wrMbwBofLPW4ZGUw51QO0TTyYHYlV0CLpVYq1rq2HviJAj5afZ7u/m
	7lPGpsEivJtmfZxljXml/ljMCPm545M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-PHB8bNgONTeE-BMduNi7AA-1; Mon, 15 Feb 2021 13:14:51 -0500
X-MC-Unique: PHB8bNgONTeE-BMduNi7AA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EAC2B107ACF9;
	Mon, 15 Feb 2021 18:14:49 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 53E0D2CD34;
	Mon, 15 Feb 2021 18:14:49 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Michal Suchanek <msuchanek@suse.de>
Subject: Re: [PATCH ndctl] dimm: re-fix potential fd leakage in dimm_action()
References: <20210106144343.22099-1-msuchanek@suse.de>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Mon, 15 Feb 2021 13:15:28 -0500
In-Reply-To: <20210106144343.22099-1-msuchanek@suse.de> (Michal Suchanek's
	message of "Wed, 6 Jan 2021 15:43:43 +0100")
Message-ID: <x49pn11ci4f.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jmoyer@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Message-ID-Hash: L7X3RO4NND4IN2YQGCGBDMZYRKNYAQWE
X-Message-ID-Hash: L7X3RO4NND4IN2YQGCGBDMZYRKNYAQWE
X-MailFrom: jmoyer@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, Zhiqiang Liu <liuzhiqiang26@huawei.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/L7X3RO4NND4IN2YQGCGBDMZYRKNYAQWE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Michal Suchanek <msuchanek@suse.de> writes:

> There are cases not covered by the original fix and cases added by the
> latter patch.
>
> Also there is one case of usage added without returning from the
> function.
>
> Fixes: ff434d87ccbd ("dimm: fix potential fd leakage in dimm_action()")
> Fixes: 41a7e24af5db ("ndctl/dimm: Auto-arm firmware activation")
>
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>  ndctl/dimm.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/ndctl/dimm.c b/ndctl/dimm.c
> index 09ce49e1d2ca..1c177b5494ec 100644
> --- a/ndctl/dimm.c
> +++ b/ndctl/dimm.c
> @@ -1333,12 +1333,15 @@ static int dimm_action(int argc, const char **argv, struct ndctl_ctx *ctx,
>  	if (param.arm_set && param.disarm_set) {
>  		fprintf(stderr, "set either --arm, or --disarm, not both\n");
>  		usage_with_options(u, options);
> +		rc = -EINVAL;
> +		goto out_close_fout;

usage_with_options calls exit():

void usage_with_options(const char * const *usagestr,
                        const struct option *opts)
{
        usage_with_options_internal(usagestr, opts, 0);
        exit(129);
}

So I don't think this patch is necessary.

Cheers,
Jeff
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
