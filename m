Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D171F163518
	for <lists+linux-nvdimm@lfdr.de>; Tue, 18 Feb 2020 22:33:28 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4C75510FC3407;
	Tue, 18 Feb 2020 13:34:14 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.120; helo=us-smtp-1.mimecast.com; envelope-from=jmoyer@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [205.139.110.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A60C01007B1C6
	for <linux-nvdimm@lists.01.org>; Tue, 18 Feb 2020 13:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1582061598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qRrjWIJM5Cc3ypyY2XCc8rTQQIadD5J4Bc3O4gt6cuE=;
	b=dyi0yU0P+yiattncuylk7IWQY5SeayCQmbmctMUkSwapa9f8Usvz0gWFekJXXXr2kf2TS4
	Hm6UPUQNXCIOX9HyeC/R/ckAEnk8ilD07HuElchf8shRpo3ndP1QNrbaAduVVu2fxDJi4L
	oMygC7DsQfc7vNc8/oFFTr7Srjhebxg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-9qNL65a4M6WVEKPQYjSJkQ-1; Tue, 18 Feb 2020 16:33:14 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C2648017DF;
	Tue, 18 Feb 2020 21:33:13 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D49FA19756;
	Tue, 18 Feb 2020 21:33:12 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [ndctl PATCH] ndctl/lib: make dimm_ops in private.h extern
References: <20200130185631.29817-1-vishal.l.verma@intel.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Tue, 18 Feb 2020 16:33:12 -0500
In-Reply-To: <20200130185631.29817-1-vishal.l.verma@intel.com> (Vishal Verma's
	message of "Thu, 30 Jan 2020 11:56:31 -0700")
Message-ID: <x497e0jbmxz.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 9qNL65a4M6WVEKPQYjSJkQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Message-ID-Hash: KCAT4WFOFNGJKWI6WRMPJKMSEVFA47MB
X-Message-ID-Hash: KCAT4WFOFNGJKWI6WRMPJKMSEVFA47MB
X-MailFrom: jmoyer@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KCAT4WFOFNGJKWI6WRMPJKMSEVFA47MB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Vishal Verma <vishal.l.verma@intel.com> writes:

> A toolchain update in Fedora 32 caused new compile errors due to
> multiple definitions of dimm_ops structures. The declarations in
> 'private.h' for the various NFIT families are present so that libndctl
> can find all the per-family dimm-ops. However they need to be declared
> as extern because the actual definitions are in <family>.c
>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  ndctl/lib/private.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/ndctl/lib/private.h b/ndctl/lib/private.h
> index e445301..16bf8f9 100644
> --- a/ndctl/lib/private.h
> +++ b/ndctl/lib/private.h
> @@ -343,10 +343,10 @@ struct ndctl_dimm_ops {
>  	int (*xlat_firmware_status)(struct ndctl_cmd *);
>  };
>  
> -struct ndctl_dimm_ops * const intel_dimm_ops;
> -struct ndctl_dimm_ops * const hpe1_dimm_ops;
> -struct ndctl_dimm_ops * const msft_dimm_ops;
> -struct ndctl_dimm_ops * const hyperv_dimm_ops;
> +extern struct ndctl_dimm_ops * const intel_dimm_ops;
> +extern struct ndctl_dimm_ops * const hpe1_dimm_ops;
> +extern struct ndctl_dimm_ops * const msft_dimm_ops;
> +extern struct ndctl_dimm_ops * const hyperv_dimm_ops;
>  
>  static inline struct ndctl_bus *cmd_to_bus(struct ndctl_cmd *cmd)
>  {

Acked-by: Jeff Moyer <jmoyer@redhat.com>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
