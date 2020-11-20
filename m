Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F892BB0AA
	for <lists+linux-nvdimm@lfdr.de>; Fri, 20 Nov 2020 17:37:11 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A0722100EC1F8;
	Fri, 20 Nov 2020 08:37:09 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.205.24.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jmoyer@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B8EB7100ED4AD
	for <linux-nvdimm@lists.01.org>; Fri, 20 Nov 2020 08:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1605890218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y0b1zHRo1zYVIc4QGuL3x+/Y6ADdb8wyS9HhmxSmhJI=;
	b=eD8uQqYxNk7pgTAp0k94OaVa3+RAZjC8TlKuKmPEV2PuUxjh6hQWliReh34ggpic+fY9D2
	MlveqfCZceWCnh9OMWGLRkoAWEqDelOP2NOBmLxFA+H4S9A0EA1Q+PV/xmUbSb4fiMalHV
	wMPS8ctC9dD9T6LTvGrr8wDbjkik8D4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-COWV-rO8PH61zXVuPKAECQ-1; Fri, 20 Nov 2020 11:36:56 -0500
X-MC-Unique: COWV-rO8PH61zXVuPKAECQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1DFA1009B62;
	Fri, 20 Nov 2020 16:36:55 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3D4C7F6DA;
	Fri, 20 Nov 2020 16:36:55 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Zhiqiang Liu <liuzhiqiang26@huawei.com>
Subject: Re: [ndctl PATCH 4/8] dimm: fix potential fd leakage in dimm_action()
References: <bed3b3b3-1f30-6751-c0bf-15ecf70192f9@huawei.com>
	<1ca17cf4-a5fd-786d-fa50-8ed09ccd55e4@huawei.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Fri, 20 Nov 2020 11:36:59 -0500
In-Reply-To: <1ca17cf4-a5fd-786d-fa50-8ed09ccd55e4@huawei.com> (Zhiqiang Liu's
	message of "Fri, 6 Nov 2020 17:26:12 +0800")
Message-ID: <x49r1oom1ck.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jmoyer@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Message-ID-Hash: QGKLN6C5WAJP4I5XWYBVJA6OUY6ZIB46
X-Message-ID-Hash: QGKLN6C5WAJP4I5XWYBVJA6OUY6ZIB46
X-MailFrom: jmoyer@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, linfeilong <linfeilong@huawei.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QGKLN6C5WAJP4I5XWYBVJA6OUY6ZIB46/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Zhiqiang Liu <liuzhiqiang26@huawei.com> writes:

> In dimm_action(), actx.f_out and actx.f_in may be set by calling
> fopen(). If exceptions occur, we will directly goto out tag.
> However, we did not close actx.f_out|actx.f_in in out tag, which
> will cause fd leakage.
>
> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> ---
>  ndctl/dimm.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/ndctl/dimm.c b/ndctl/dimm.c
> index 90eb0b8..2f52cda 100644
> --- a/ndctl/dimm.c
> +++ b/ndctl/dimm.c
> @@ -1352,7 +1352,7 @@ static int dimm_action(int argc, const char **argv, struct ndctl_ctx *ctx,
>  			fprintf(stderr, "failed to open: %s: (%s)\n",
>  					param.infile, strerror(errno));
>  			rc = -errno;
> -			goto out;
> +			goto out_close_fout;
>  		}
>  	}
>
> @@ -1371,7 +1371,7 @@ static int dimm_action(int argc, const char **argv, struct ndctl_ctx *ctx,
>  		fprintf(stderr, "'%s' is not a valid label version\n",
>  				param.labelversion);
>  		rc = -EINVAL;
> -		goto out;
> +		goto out_close_fin_fout;
>  	}
>
>  	rc = 0;
> @@ -1423,12 +1423,14 @@ static int dimm_action(int argc, const char **argv, struct ndctl_ctx *ctx,
>  		util_display_json_array(actx.f_out, actx.jdimms, flags);
>  	}
>
> -	if (actx.f_out != stdout)
> -		fclose(actx.f_out);
> -
> + out_close_fin_fout:
>  	if (actx.f_in != stdin)
>  		fclose(actx.f_in);
>
> + out_close_fout:
> +	if (actx.f_out != stdout)
> +		fclose(actx.f_out);
> +
>   out:
>  	/*
>  	 * count if some actions succeeded, 0 if none were attempted,

Acked-by: Jeff Moyer <jmoyer@redhat.com>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
