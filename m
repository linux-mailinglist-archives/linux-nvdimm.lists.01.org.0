Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE141113119
	for <lists+linux-nvdimm@lfdr.de>; Wed,  4 Dec 2019 18:51:32 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 82FB91011333F;
	Wed,  4 Dec 2019 09:54:53 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::344; helo=mail-ot1-x344.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0ED191011332D
	for <linux-nvdimm@lists.01.org>; Wed,  4 Dec 2019 09:54:51 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id g18so7068457otj.13
        for <linux-nvdimm@lists.01.org>; Wed, 04 Dec 2019 09:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DuvXQCEAEl8zuUuEoWrgvqoNUMkq3kQJ6rm3A29ykk8=;
        b=KdxwcWMZG7ihKEJJoBdeWL5SaDmI9Uk0WNA81QO+q3cIejO1pZuH3KDd3ptG/jYO2G
         mMGTkGkjP4Z9pT9OMCYadqKLb/W0nfKeDRBI94rL2OY+ZK4ckxDc4PTEh/RPN7l7cBUQ
         JNcSEAuIdoDHrh0KKH+JMGNaf9zMg32bImlXU1wHwv7z5Rp7hzXF6JclTx2hW/FUjOHC
         YrFLygNmrBGf6jPS/kMQoIMRX4aJtmNRQ5XbMqNQmNhrV5yAzqMMDjanDYpBR5NbGAEN
         kxtMf/xVOo/XZOc4A1WcONyrjkHaRmTiVYCvuQLM76O5lT2BKsjki0bPMnSW5JzgV6At
         R+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DuvXQCEAEl8zuUuEoWrgvqoNUMkq3kQJ6rm3A29ykk8=;
        b=sHf2x5Q4d1tQmpdUFDbM9hUZO9ojry83WhzNsynfndJCaCEd9UjwLYr4sUqOap/dfA
         +Dgk/F+x4SZCbskiNqu3NFb+tnX2Bb34lMOCTTza+TO5/t5zKdX99QcoEmwL/ZCXFyc5
         9U4Ua2NR//Q9hSjTX13f4T0ZQeVXPD9ejt8DJ+4J54RN9CNDY7l3H9rfbrKescLVNiyG
         +sE8PDYFSnPg3jNp5erQw/972U7+09wWX5ItLdVVWFG18EzTEaKIZdZokdHxU0+H+L/M
         z3bpbqcPcWzS/6BYJE6avf7eIZdyhV3XGMpV06PzCvBRBm8AsGaW46bTvAQs3KSGHujt
         /xbQ==
X-Gm-Message-State: APjAAAWZt252Yd5mGeinWD7WXQ5vK/uYKJTyVLMMlt7b+kyBbgICCd4W
	25DFD0ufbuL2pGIFwQSZ/uf1/BUmZnM+2jemGmHxow==
X-Google-Smtp-Source: APXvYqzEgUueMDi7xEtqLvuKAVu5sOkB6LFYUruvsnaZ/srqUo1AQFsNroO4zBe6u0YXpb/fAu6ZvX/NpHTTnzi/7es=
X-Received: by 2002:a9d:24c1:: with SMTP id z59mr3151788ota.207.1575481888245;
 Wed, 04 Dec 2019 09:51:28 -0800 (PST)
MIME-Version: 1.0
References: <20191204095553.83209-1-santosh@fossix.org>
In-Reply-To: <20191204095553.83209-1-santosh@fossix.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 4 Dec 2019 09:51:17 -0800
Message-ID: <CAPcyv4jF6ofAmXrcNXsK-vaSD8ptzhH4SrcaksD_wSwrsYi0KA@mail.gmail.com>
Subject: Re: [PATCH ndctl] namespace/create: Don't create multiple namespace
 unless greedy
To: Santosh Sivaraj <santosh@fossix.org>
Message-ID-Hash: LOAUX6IDCXJAJ6HP5ZDNJW3NNUTOPFKX
X-Message-ID-Hash: LOAUX6IDCXJAJ6HP5ZDNJW3NNUTOPFKX
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Vaibhav Jain <vaibhav@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LOAUX6IDCXJAJ6HP5ZDNJW3NNUTOPFKX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Dec 4, 2019 at 1:56 AM Santosh Sivaraj <santosh@fossix.org> wrote:
>
> From: Vaibhav Jain <vaibhav@linux.ibm.com>
>
> Currently create-namespace creates two namespaces with the '-f' option
> even without the greedy flag. This behavior got introduced by
> c75f7236d. The earlier behaviour was to create one namespace even with
> the '-f' flag. The earlier behavior:
>
> $ sudo ./ndctl/ndctl create-namespace -s 16M -f
> [sudo] password for santosh:
> {
>   "dev":"namespace1.14",
>   "mode":"fsdax",
>   "map":"dev",
>   "size":"14.00 MiB (14.68 MB)",
>   "uuid":"03f6b921-7684-4736-b2be-87f021996e52",
>   "sector_size":512,
>   "align":65536,
>   "blockdev":"pmem1.14"
> }
>
> After greedy option was introduced:
>
> $ sudo ./ndctl/ndctl create-namespace -s 16M -f
> {
>   "dev":"namespace1.8",
>   "mode":"fsdax",
>   "map":"dev",
>   "size":"14.00 MiB (14.68 MB)",
>   "uuid":"1a9d6610-558b-454e-8b95-76c6201798cb",
>   "sector_size":512,
>   "align":65536,
>   "blockdev":"pmem1.8"
> }
> {
>   "dev":"namespace0.3",
>   "mode":"fsdax",
>   "map":"dev",
>   "size":"14.00 MiB (14.68 MB)",
>   "uuid":"eed9d28b-69a2-4c7c-9503-24e8aee87b1e",
>   "sector_size":512,
>   "align":65536,
>   "blockdev":"pmem0.3"
> }
>
> If no region or '-c' flag is specified bail out if the creation was successful.
>
> Fixes: c75f7236d (ndctl/namespace: add a --continue option to create namespaces greedily)
> Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---
>  ndctl/namespace.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/ndctl/namespace.c b/ndctl/namespace.c
> index 7fb0007..8098456 100644
> --- a/ndctl/namespace.c
> +++ b/ndctl/namespace.c
> @@ -1392,6 +1392,8 @@ static int do_xaction_namespace(const char *namespace,
>                                 if (force) {
>                                         if (rc)
>                                                 saved_rc = rc;
> +                                       else if (!param.region)
> +                                                       return rc;

I see the bug, but the fix looks wrong to me. --force has no meaning
in this case. I'd rather just clean-up --force to be ignored when
neither "-c" nor "-e" are specified.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
