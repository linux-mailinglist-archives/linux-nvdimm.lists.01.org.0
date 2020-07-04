Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 795AF2145D7
	for <lists+linux-nvdimm@lfdr.de>; Sat,  4 Jul 2020 14:31:02 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 96C81114EB6BF;
	Sat,  4 Jul 2020 05:30:59 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::744; helo=mail-qk1-x744.google.com; envelope-from=vilhelm.gray@gmail.com; receiver=<UNKNOWN> 
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D7839114E9C11
	for <linux-nvdimm@lists.01.org>; Sat,  4 Jul 2020 05:30:57 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id z63so30959905qkb.8
        for <linux-nvdimm@lists.01.org>; Sat, 04 Jul 2020 05:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sOwZHk+VUidgfHH4SuXy00BIvhn2pt9U8Ew+xLvAsZg=;
        b=OpZFtOaWIMlYV+gfwKL/L+8ff8UWmweHWOKfEufQ7KjkPr/LF9GO3Suf5BAUOgHdG+
         YMRvdzJkBOY6hna7YZrEpLXFBOOBp81PwigxKHmOJ2GPwZhBdeHv05BtupTZV7tATXwR
         DPcdZ9jElS7N771ftpchtTFTYqu55hNeZprcQJhE09KKMrs2uqGFEt5pTEoyH2es8Iqq
         ro0Us25isi/BQXdmmHuwbBHcvFnxXeGG56nVsOPxbYCN+zs0kMMnrVT4EN8443erjvAN
         i8H5GFPG9frq8EQT+swZCSwTZFhUhI8U1TX+Z6kFiVVLsdLaHU/QMWqNKs5DDcd3VZaH
         rZrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sOwZHk+VUidgfHH4SuXy00BIvhn2pt9U8Ew+xLvAsZg=;
        b=O3JnGJS2v6A3KFcLqCSzUdds2qiYxYHuKKn0FOCCTMWmNHadj4A4KHhPHBf4HhKZ6L
         xhO/u8A1G5UPCQ6Dd04IUT/fpDdsJVMcBSnzUI4NNm7zXcjMOJm/NxbxXTMZQjMZK/wv
         0YbWx2gOB6VtofKAwX6e1RWp3pm5s4Bd+t62AiLK2CNq2Evww+1VkD2+LwkKYytCz1eV
         VSRdJQXhLEOrEsxRI+BQJDm8YQDnA88fUG+Dwlf93lN9dINP+zPM3PXqWYjbLpzRPVsb
         sg+67z4i7NsYqvAnRW/gGpwciX343O9JMBRHjlgQYVqeKjfTUTHxuMbMqi/AvDmt/Llx
         d4lA==
X-Gm-Message-State: AOAM531um39P5JhQUPpexPNucF6zDcNb7exX4agP4hJLme4Ns0lFPMVO
	u2YIWuEAJqEogyWUvRnTW+I=
X-Google-Smtp-Source: ABdhPJxQkc5E1xdUVhKWRhep5Tf5kvtqhrZWqA7orRfGsTG/6YQJPlx2ZdIX0fYJyfo1s/jCEkbjNQ==
X-Received: by 2002:a37:a14c:: with SMTP id k73mr39030752qke.145.1593865856267;
        Sat, 04 Jul 2020 05:30:56 -0700 (PDT)
Received: from shinobu (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id 21sm13502872qkj.56.2020.07.04.05.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 05:30:55 -0700 (PDT)
Date: Sat, 4 Jul 2020 08:30:41 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 06/17] Documentation/driver-api: generic-counter: drop
 doubled word
Message-ID: <20200704123041.GA5194@shinobu>
References: <20200704034502.17199-1-rdunlap@infradead.org>
 <20200704034502.17199-7-rdunlap@infradead.org>
MIME-Version: 1.0
In-Reply-To: <20200704034502.17199-7-rdunlap@infradead.org>
Message-ID-Hash: YW7TTG6EXOUCROYR2K4GAV6P7WXXJVWK
X-Message-ID-Hash: YW7TTG6EXOUCROYR2K4GAV6P7WXXJVWK
X-MailFrom: vilhelm.gray@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, linux-nvdimm@lists.01.org, linux-usb@vger.kernel.org, Eli Billauer <eli.billauer@gmail.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YW7TTG6EXOUCROYR2K4GAV6P7WXXJVWK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: multipart/mixed; boundary="===============1508785840458084391=="


--===============1508785840458084391==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 03, 2020 at 08:44:51PM -0700, Randy Dunlap wrote:
> Drop the doubled word "the".
>=20
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: William Breathitt Gray <vilhelm.gray@gmail.com>
> Cc: linux-iio@vger.kernel.org
> ---
>  Documentation/driver-api/generic-counter.rst |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> --- linux-next-20200701.orig/Documentation/driver-api/generic-counter.rst
> +++ linux-next-20200701/Documentation/driver-api/generic-counter.rst
> @@ -262,7 +262,7 @@ the system.
>  Counter Counts may be allocated via counter_count structures, and
>  respective Counter Signal associations (Synapses) made via
>  counter_synapse structures. Associated counter_synapse structures are
> -stored as an array and set to the the synapses array member of the
> +stored as an array and set to the synapses array member of the
>  respective counter_count structure. These counter_count structures are
>  set to the counts array member of an allocated counter_device structure
>  before the Counter is registered to the system.

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl8AdmgACgkQhvpINdm7
VJKL2g/9H6mqC4m/nbUz0xx6u/KB2FTl+BheIuZdhAKQ7vaavuFT9QQK7KdB4VlZ
9/mxbfR37ZCap3U06SMiqcB3cBirDGz38z0kpQEnjoRLfO86+gb7WfpBn19BkBt3
SgI+iKUWbpFBZQnOXpP/mpmGDIIBJdb/oPeqamTmeCP5zmkGPStlR66mReRTCF5A
C1ISpNFBpFTCSLXvMannoxxEWHfug95Oq+z2MxNY87LfNKQm+jtRD+yjfvNJJDEO
EA/p8gavvQuNNS7HnwjzT7F5xc+1eoZINk5w4/KkoSJzcyMQEBnPCKQV/T6YJT9A
odyOiKcmBQOQ4SjjWZwsaf86ELIGt85SR6MtjXAv/+Hakuim0lvEN53LjeLw42XS
UiQ6k3UvFMLccw56hfUrntSUWiMCNSHJHi7CNiHKoR8Bu2lUpGZUbsj2dJ5f2f6B
QTZxZrFKdYpWQ6Bj56Gw+qz7n6YKWoAdhW6BhSqmnNn+gvgpWqPTgz5OG6hXARgI
2MyKfuKyyc73wPPenSuCF+0ugENfjmYAfkKkFIHweBP82YemBQH1gzRNtusQgjp3
NYyhPpdbiSDucr9uicWqOTwEjOppSfUpNIehHwKmZQOePA+Ewj1U0mbKsA17IbDm
7tXxxkVxTlKSuEIfgiDufrHw5oOner+LPe/QKsMK4nNBHKTRGpQ=
=Q9+X
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--

--===============1508785840458084391==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

--===============1508785840458084391==--
