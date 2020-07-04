Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9CB2145D9
	for <lists+linux-nvdimm@lfdr.de>; Sat,  4 Jul 2020 14:31:23 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B3785114EB6C3;
	Sat,  4 Jul 2020 05:31:22 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::744; helo=mail-qk1-x744.google.com; envelope-from=vilhelm.gray@gmail.com; receiver=<UNKNOWN> 
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 69B38114EB6BF
	for <linux-nvdimm@lists.01.org>; Sat,  4 Jul 2020 05:31:20 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id e11so31045838qkm.3
        for <linux-nvdimm@lists.01.org>; Sat, 04 Jul 2020 05:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wXVeQpxCI+iwkYlezHWcf0l5BZQJCmNvUa2xktmhOME=;
        b=E1+xoB3rYQ0NBSpfC4fscDTPs9mkC68MYowA8nh/JRikBI2XWSsFtvSpAqy9F494RE
         0leKOD5qmSi0BkobZ42sbTeyMRO7wxm14RZRZOhOxIkiX3nPIdCcI07bLj4olC9wYduq
         4uzBC4jqPKxwUhCHDDzrmTxxBr2d8T2olx/cn7pGcxJV0QBlkCfqUQ1Z4WLwivN3O4AS
         I4IC7dmrAZnY0A3r6sKrIcJAKFfJ5q/E6PEw3Ki+nZJnq+/3of4oB/1jISH3toeyuS33
         oW2FXmHLG7fLa359OKo8IrsP7AmFyTc4Cg0SKXtooxgf9uEF1gpG0pbPkyOSx9tEkoXI
         Ujcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wXVeQpxCI+iwkYlezHWcf0l5BZQJCmNvUa2xktmhOME=;
        b=kZQXhXuId3uoNS1ixdHqQzhm4rLYUysfIpwm00XkOpKyW0D31Igfjo8mrqCrVge64x
         XmuyvjonR1L8DnUqUbVpjL7nOfRud6W3scCTP0MU5FBla1CmeebAs4Hap/6oJ652l6rQ
         AHgZqXD6RugI2P5kFcenETSymBbvzlrkJ+b/qW0RevZNTWSBZeSz/M5MBdfG9m4ljQ7P
         jlPAM7WfRTSoZHvCwLmMPIA3qFvLIhktIxoC53MCkz4KqxzCKCWygvnonhnTS5olRIDP
         INcGKxWwKNOSFP73eZjHeHGzE8Iw1K/H9TnAMA53A0pr+fvStQVTa9rl9EGQfN3laxh1
         oYvg==
X-Gm-Message-State: AOAM531iMgX7LihEh7aVOOcumBgDcOFipuZAsjZztnSJgkVDdKymuCHw
	awFZ3PCEvlJALELVfy3OOQ0=
X-Google-Smtp-Source: ABdhPJxUcAycygrd/AP+v+wLXYj/t4ZGB/H3x+bdq/DHUXVvrvZSnflEAQw0KbOs9WzSAMnXvd0YaQ==
X-Received: by 2002:a37:6589:: with SMTP id z131mr39309316qkb.235.1593865879534;
        Sat, 04 Jul 2020 05:31:19 -0700 (PDT)
Received: from shinobu (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id a25sm14159031qtk.40.2020.07.04.05.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 05:31:18 -0700 (PDT)
Date: Sat, 4 Jul 2020 08:31:16 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 00/17] Documentation/driver-api: eliminate duplicated
 words
Message-ID: <20200704123116.GB5194@shinobu>
References: <20200704034502.17199-1-rdunlap@infradead.org>
MIME-Version: 1.0
In-Reply-To: <20200704034502.17199-1-rdunlap@infradead.org>
Message-ID-Hash: 5ALFLFSVFJWGZNGCAVKKESAC56EWOZ62
X-Message-ID-Hash: 5ALFLFSVFJWGZNGCAVKKESAC56EWOZ62
X-MailFrom: vilhelm.gray@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, linux-nvdimm@lists.01.org, linux-usb@vger.kernel.org, Eli Billauer <eli.billauer@gmail.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5ALFLFSVFJWGZNGCAVKKESAC56EWOZ62/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: multipart/mixed; boundary="===============8553597338142291369=="


--===============8553597338142291369==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cvVnyQ+4j833TQvp"
Content-Disposition: inline


--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 03, 2020 at 08:44:45PM -0700, Randy Dunlap wrote:
> Remove occurrences of duplicated words in Documentation/driver-api/.
>=20
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: dmaengine@vger.kernel.org
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: William Breathitt Gray <vilhelm.gray@gmail.com>
> Cc: linux-iio@vger.kernel.org
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: linux-media@vger.kernel.org
> Cc: Jon Mason <jdmason@kudzu.us>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Allen Hubbe <allenbh@gmail.com>
> Cc: linux-ntb@googlegroups.com
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: linux-nvdimm@lists.01.org
> Cc: linux-usb@vger.kernel.org
> Cc: Eli Billauer <eli.billauer@gmail.com>
>=20
>=20
>  Documentation/driver-api/dmaengine/provider.rst        |    2 +-
>  Documentation/driver-api/driver-model/platform.rst     |    2 +-
>  Documentation/driver-api/firmware/built-in-fw.rst      |    2 +-
>  Documentation/driver-api/firmware/direct-fs-lookup.rst |    2 +-
>  Documentation/driver-api/firmware/firmware_cache.rst   |    2 +-
>  Documentation/driver-api/firmware/request_firmware.rst |    2 +-
>  Documentation/driver-api/generic-counter.rst           |    2 +-
>  Documentation/driver-api/iio/buffers.rst               |    2 +-
>  Documentation/driver-api/media/cec-core.rst            |    2 +-
>  Documentation/driver-api/media/dtv-frontend.rst        |    6 +++---
>  Documentation/driver-api/media/v4l2-controls.rst       |    4 ++--
>  Documentation/driver-api/media/v4l2-dev.rst            |    2 +-
>  Documentation/driver-api/ntb.rst                       |    2 +-
>  Documentation/driver-api/nvdimm/nvdimm.rst             |    2 +-
>  Documentation/driver-api/uio-howto.rst                 |    2 +-
>  Documentation/driver-api/usb/URB.rst                   |    2 +-
>  Documentation/driver-api/xillybus.rst                  |    2 +-
>  17 files changed, 20 insertions(+), 20 deletions(-)

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

--cvVnyQ+4j833TQvp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl8AdpQACgkQhvpINdm7
VJIBvxAAqwgnnmzKHJ8nY2Ip3r9kE7Fygjzlzj9bHCF7iXLQVTYqC4W7cN0q0Bfu
QotqGgl0sAWKftn9qkvUzFI6TFRROjPuzPdDPucm+pQ5pW2m6HIEOgK42qjcuHLn
wvVJmYNuV3L+Y6NQtUS1PBulobtAYL8fMMhtQiG6rialiiB6yaJeHkpU7BP5cdUn
+n6i9IJIdl9//biQjBd5FQy7wqPLr+aXBZLAMSWT+hKl0huWGUXmFBTmcGLkGhAT
OEKrj9H7j8U7CmavcpNe0bHRLlucKl3a1wQTtf6CV+SwfaaFEtKhaEKEIsB4M9QI
sRvbV0gY9yJX2y3DabCS61B/EcCA2htBnk++AlNY+HvfXckvW9+g4xaMcCAU0cow
1EFaMIVEGWrEuaBIRDQJX5f9n97Wvc0Zp2B/hlxYvSo1xmaCObehZ9+UecKCW1C0
71A8NFc0cYiELXFZmQ+Vf7I9K3UeaRBaeoB8r4YEBNOO3JhmHq9E8re8ULoMvEse
HKZyuoGyoOhW27cZXoBw1ymZZ07Nnmpupyukmh9wQllQcMj5smqQAcbCtBNCcqXb
L+dlXBeIpE+KZHRFJ/2RtmDX903PaDcZ0Y5+NZUJsvt/KJCzg1rASkGcHC6lVTLj
4jBBZt4JmxUWKLxsdnkHXb12eTXPB7DkjhCiSThpm1A2Re9P4Jg=
=6Gqy
-----END PGP SIGNATURE-----

--cvVnyQ+4j833TQvp--

--===============8553597338142291369==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

--===============8553597338142291369==--
