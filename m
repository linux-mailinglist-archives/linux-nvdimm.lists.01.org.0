Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2ADEB55F
	for <lists+linux-nvdimm@lfdr.de>; Thu, 31 Oct 2019 17:51:59 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B54AA100DC409;
	Thu, 31 Oct 2019 09:52:23 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.120; helo=us-smtp-1.mimecast.com; envelope-from=jmoyer@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [205.139.110.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E76B8100DC407
	for <linux-nvdimm@lists.01.org>; Thu, 31 Oct 2019 09:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1572540713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Eg9oWuOPqo1L+W4rD3h5PNuEgEsQhGB7UKbPvjWbL1s=;
	b=MluCu6y6bVul00sat6EIE3zMZ6v1WIwQUL/zTTxQAoSjgibjPQJe0pKpC5Nr+Q/HZDKHYJ
	Hs/ydTGUh47hbW43Hz5Mqo3VmFFIOEsBopPHB6A7ql4/MtWeupssFfhzi9L+I0ZQ8gbJ8e
	Yvp6bzlSzFF0Wq2+aR2bpUcGLZ84D3I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-SFOVO5HhMI-DJYYvgzKgZA-1; Thu, 31 Oct 2019 12:51:49 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5AD8D107ACC0;
	Thu, 31 Oct 2019 16:51:47 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3AC541001B07;
	Thu, 31 Oct 2019 16:51:46 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 4/4] modpost: do not set ->preloaded for symbols from Module.symvers
References: <20191003102915.28301-1-yamada.masahiro@socionext.com>
	<20191003102915.28301-4-yamada.masahiro@socionext.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Thu, 31 Oct 2019 12:51:45 -0400
In-Reply-To: <20191003102915.28301-4-yamada.masahiro@socionext.com> (Masahiro
	Yamada's message of "Thu, 3 Oct 2019 19:29:15 +0900")
Message-ID: <x497e4kluxq.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: SFOVO5HhMI-DJYYvgzKgZA-1
X-Mimecast-Spam-Score: 0
Message-ID-Hash: CV64EIWQNOUVN3T7G2EIK4MP24IRQMYZ
X-Message-ID-Hash: CV64EIWQNOUVN3T7G2EIK4MP24IRQMYZ
X-MailFrom: jmoyer@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-kbuild@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>, Michal Marek <michal.lkml@markovi.net>, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CV64EIWQNOUVN3T7G2EIK4MP24IRQMYZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Masahiro Yamada <yamada.masahiro@socionext.com> writes:

> Now that there is no overwrap between symbols from ELF files and
> ones from Module.symvers.
>
> So, the 'exported twice' warning should be reported irrespective
> of where the symbol in question came from. Only the exceptional case
> is when __crc_<sym> symbol appears before __ksymtab_<sym>. This
> typically occurs for EXPORT_SYMBOL in .S files.

Hi, Masahiro,

After apply this patch, I get the following modpost warnings when doing:

$ make M=tools/tesing/nvdimm
...
  Building modules, stage 2.
  MODPOST 12 modules
WARNING: tools/testing/nvdimm/libnvdimm: 'nvdimm_bus_lock' exported twice. Previous export was in drivers/nvdimm/libnvdimm.ko
WARNING: tools/testing/nvdimm/libnvdimm: 'nvdimm_bus_unlock' exported twice. Previous export was in drivers/nvdimm/libnvdimm.ko
WARNING: tools/testing/nvdimm/libnvdimm: 'is_nvdimm_bus_locked' exported twice. Previous export was in drivers/nvdimm/libnvdimm.ko
WARNING: tools/testing/nvdimm/libnvdimm: 'devm_nvdimm_memremap' exported twice. Previous export was in drivers/nvdimm/libnvdimm.ko
WARNING: tools/testing/nvdimm/libnvdimm: 'nd_fletcher64' exported twice. Previous export was in drivers/nvdimm/libnvdimm.ko
WARNING: tools/testing/nvdimm/libnvdimm: 'to_nd_desc' exported twice. Previous export was in drivers/nvdimm/libnvdimm.ko
WARNING: tools/testing/nvdimm/libnvdimm: 'to_nvdimm_bus_dev' exported twice. Previous export was in drivers/nvdimm/libnvdimm.ko
...

There are a lot of these warnings.  :)  If I revert this patch, no
complaints.

Cheers,
Jeff


>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  scripts/mod/modpost.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 5234555cf550..6ca38d10efc5 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -2457,7 +2457,6 @@ static void read_dump(const char *fname, unsigned int kernel)
>  		s = sym_add_exported(symname, namespace, mod,
>  				     export_no(export));
>  		s->kernel    = kernel;
> -		s->preloaded = 1;
>  		s->is_static = 0;
>  		sym_update_crc(symname, mod, crc, export_no(export));
>  	}
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
