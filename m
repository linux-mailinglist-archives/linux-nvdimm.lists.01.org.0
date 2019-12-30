Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8FB12CD28
	for <lists+linux-nvdimm@lfdr.de>; Mon, 30 Dec 2019 07:04:05 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DB97910097F37;
	Sun, 29 Dec 2019 22:07:23 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::344; helo=mail-ot1-x344.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 77AA610097F36
	for <linux-nvdimm@lists.01.org>; Sun, 29 Dec 2019 22:07:21 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id 19so32498283otz.3
        for <linux-nvdimm@lists.01.org>; Sun, 29 Dec 2019 22:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=smvezbCcafrjZEwcimdyWmIWKHfbIjLpwAnC8grM4UI=;
        b=2TpmuTd9MCfMIG5yShwzCJU/QZQM+aRE1b4GXXHJ7g8Ny6JBIXaBaPBCiCCP9qfHfU
         dXug2MWXDrFMbmT3ICqjCcg8TnlOcu3VewVoR6TERgfKsxNacMBdqgCsCumRYAL/ae6e
         tXnmFFImCBDQKFYty15daS7hpxKwI6QnMk/HErJhCCi6XyKps8Pk0Yjc8k4lXSu/tf5Y
         1wYTDEDfrq7uZgkf20EbxrNu4TRI0zC9a9UU1wQonEnH/CVi1ZFb/JiVSsLfzw4bL1Ng
         PLuw3nlJtNjjHoH8WN4gVQ8LIuhdUieEgDAO6OEv42pjuHi3U8R0MuWcxgPClsrBU6/W
         CL/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=smvezbCcafrjZEwcimdyWmIWKHfbIjLpwAnC8grM4UI=;
        b=OlnmETgjOVVFMfJKESl9DTCnQWZHuMGrn51zknzwzjnrXSXrHkcD5QLVzodxraSvBO
         qx0SWYCfoDF1CDIyHRZxU+9NMA8Uq3r7dLURjDnsiAsFHc/6hHDN0znvYc7w3LG9z8Qi
         caNh+DdntBmsUGSnWGMfucAYnDOqgupFhJz0+OZrAvkIucvmcn5SyubjrdAHw2oYLszq
         iypahqANwE0+SaB5c2AQ3k/aZyCZ+HZx5UbwKf5zw61uMrnnpuIfS/99JPaEwBLnU31F
         voz3gDXWEC2dmupSSbqQ1yP4rEjkTm5xJ/UWfNKNk00nExDzV2QpxDYIjiynMDCGWKeu
         3SMA==
X-Gm-Message-State: APjAAAX0viOhit6sM2PjgO0PJRlRLLZb5o6yQU+u8qV8aBnXN4GHM7Jd
	g86zAyu5qjm7bULR3yzDFC11T+HtB+JBzjb8phqslQ==
X-Google-Smtp-Source: APXvYqyRSjSA/BJ2hUhnpC5ngT+MkQQWqLSVafk2WRooZvObK0KzAtk0dttLfvf5vb6OuhNTzaso26c9YLGriok4bqA=
X-Received: by 2002:a9d:4e99:: with SMTP id v25mr74434468otk.363.1577685841063;
 Sun, 29 Dec 2019 22:04:01 -0800 (PST)
MIME-Version: 1.0
References: <20191228040927.4800-1-redhairer.li@intel.com>
In-Reply-To: <20191228040927.4800-1-redhairer.li@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Sun, 29 Dec 2019 22:03:50 -0800
Message-ID: <CAPcyv4jOT50r8Hh2Gx8voTjaSVSv=X+2mYLkb+f7hNkrs_dQPA@mail.gmail.com>
Subject: Re: [PATCH 1/1] ndctl, test: add UUID_LIBS for blk_namespaces/pmem_namespaces/device_dax
To: redhairer <redhairer.li@intel.com>
Message-ID-Hash: WB7OOL73TTDFIAYAHTLLRTIRAWXJK4VE
X-Message-ID-Hash: WB7OOL73TTDFIAYAHTLLRTIRAWXJK4VE
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WB7OOL73TTDFIAYAHTLLRTIRAWXJK4VE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Dec 27, 2019 at 8:09 PM redhairer <redhairer.li@intel.com> wrote:
>
> Some environments automatically include the missing library dependency,
> and others need it to be explicitly included.
>
> Signed-off-by: Redhairer Li <redhairer.li@intel.com>

Looks good, applied.

>  test/Makefile.am | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/test/Makefile.am b/test/Makefile.am
> index 829146d..a13440e 100644
> --- a/test/Makefile.am
> +++ b/test/Makefile.am
> @@ -98,10 +98,10 @@ ack_shutdown_count_set_SOURCES =\
>  ack_shutdown_count_set_LDADD = $(LIBNDCTL_LIB) $(KMOD_LIBS)
>
>  blk_ns_SOURCES = blk_namespaces.c $(testcore)
> -blk_ns_LDADD = $(LIBNDCTL_LIB) $(KMOD_LIBS)
> +blk_ns_LDADD = $(LIBNDCTL_LIB) $(KMOD_LIBS) $(UUID_LIBS)
>
>  pmem_ns_SOURCES = pmem_namespaces.c $(testcore)
> -pmem_ns_LDADD = $(LIBNDCTL_LIB) $(KMOD_LIBS)
> +pmem_ns_LDADD = $(LIBNDCTL_LIB) $(KMOD_LIBS) $(UUID_LIBS)
>
>  dpa_alloc_SOURCES = dpa-alloc.c $(testcore)
>  dpa_alloc_LDADD = $(LIBNDCTL_LIB) $(UUID_LIBS) $(KMOD_LIBS)
> @@ -143,6 +143,7 @@ device_dax_LDADD = \
>                 $(LIBNDCTL_LIB) \
>                 $(KMOD_LIBS) \
>                 $(JSON_LIBS) \
> +                $(UUID_LIBS) \
>                 ../libutil.a
>
>  smart_notify_SOURCES = smart-notify.c
> --
> 2.20.1.windows.1
>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
