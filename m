Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBC431D565
	for <lists+linux-nvdimm@lfdr.de>; Wed, 17 Feb 2021 07:39:23 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 31896100F2250;
	Tue, 16 Feb 2021 22:39:21 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=94.130.110.236; helo=antares.kleine-koenig.org; envelope-from=uwe@kleine-koenig.org; receiver=<UNKNOWN> 
Received: from antares.kleine-koenig.org (antares.kleine-koenig.org [94.130.110.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 04CA3100F2243
	for <linux-nvdimm@lists.01.org>; Tue, 16 Feb 2021 22:39:17 -0800 (PST)
Received: from antares.kleine-koenig.org (localhost [127.0.0.1])
	by antares.kleine-koenig.org (Postfix) with ESMTP id B7D5FB03DF5;
	Wed, 17 Feb 2021 07:39:14 +0100 (CET)
Received: from antares.kleine-koenig.org ([94.130.110.236])
	by antares.kleine-koenig.org (antares.kleine-koenig.org [94.130.110.236]) (amavisd-new, port 10024)
	with ESMTP id S8ReJb4Xkcck; Wed, 17 Feb 2021 07:39:13 +0100 (CET)
Received: from taurus.defre.kleine-koenig.org (unknown [IPv6:2a02:8071:b5ad:2000:7867:997:4a55:eb43])
	by antares.kleine-koenig.org (Postfix) with ESMTPSA;
	Wed, 17 Feb 2021 07:39:13 +0100 (CET)
Subject: Re: [PATCH v2 0/5] dax-device: Some cleanups
To: Dan Williams <dan.j.williams@intel.com>
References: <20210205222842.34896-1-uwe@kleine-koenig.org>
 <CAPcyv4gMg7ksLS6vWR3Ya=bZd5wBiRLtSGxf6mc3yqf+3rA_TQ@mail.gmail.com>
 <CAPcyv4jq_8as=qUL8LJnNcM2UsrqEJqjc7+EHjs8XwuWCVZKPw@mail.gmail.com>
From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
Message-ID: <d1891be1-9345-9d2b-edcc-2a5ce2ac9360@kleine-koenig.org>
Date: Wed, 17 Feb 2021 07:39:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAPcyv4jq_8as=qUL8LJnNcM2UsrqEJqjc7+EHjs8XwuWCVZKPw@mail.gmail.com>
Message-ID-Hash: RYMCZFDTSFL7BMTR27DEMDTNFB5OOXVC
X-Message-ID-Hash: RYMCZFDTSFL7BMTR27DEMDTNFB5OOXVC
X-MailFrom: uwe@kleine-koenig.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RYMCZFDTSFL7BMTR27DEMDTNFB5OOXVC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: multipart/mixed; boundary="===============3442369609691983668=="

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============3442369609691983668==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="NVYrnRlgCQ2dWcNf6WA1OxAcEomB67SXn"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NVYrnRlgCQ2dWcNf6WA1OxAcEomB67SXn
Content-Type: multipart/mixed; boundary="hBBVWP2Xum3ONlVJRDp4uyuSeD8Sa6qHy";
 protected-headers="v1"
From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang
 <dave.jiang@intel.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Message-ID: <d1891be1-9345-9d2b-edcc-2a5ce2ac9360@kleine-koenig.org>
Subject: Re: [PATCH v2 0/5] dax-device: Some cleanups
References: <20210205222842.34896-1-uwe@kleine-koenig.org>
 <CAPcyv4gMg7ksLS6vWR3Ya=bZd5wBiRLtSGxf6mc3yqf+3rA_TQ@mail.gmail.com>
 <CAPcyv4jq_8as=qUL8LJnNcM2UsrqEJqjc7+EHjs8XwuWCVZKPw@mail.gmail.com>
In-Reply-To: <CAPcyv4jq_8as=qUL8LJnNcM2UsrqEJqjc7+EHjs8XwuWCVZKPw@mail.gmail.com>

--hBBVWP2Xum3ONlVJRDp4uyuSeD8Sa6qHy
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hello Dan,

On 2/17/21 4:55 AM, Dan Williams wrote:
>> One small comment on patch5, otherwise looks good.
>=20
> I take it back, patch5 looks good. I was going to ask about the return
> value removal for dax_bus_remove(), but that would need struct
> bus_type to change prototypes.

Changing struct bus_type::remove to return void is the eventual plan. To =

make this a pretty and easily reviewable patch I currently go through=20
all buses and make sure that for the prototype change I only have to do=20
one s/int/void/ and drop a "return 0" per bus.

> All merged to the nvdimm tree.

Great, thanks
Uwe


--hBBVWP2Xum3ONlVJRDp4uyuSeD8Sa6qHy--

--NVYrnRlgCQ2dWcNf6WA1OxAcEomB67SXn
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmAsugYACgkQwfwUeK3K
7Anipwf+MQUO3Q+0QPOYdHW2iyztwa/+y2PBB7JgXTg7BWm3X0WiJ7B2ZUj9NKSx
2Z1oyu79E1w/mNFeXeVKJ/9HGEsClUCaag1AA2om/gKvSJmVFU48N4STJAZ5LAX/
tL6lLx4HDn1/mLXgIhsk3bdLQg959Q2BaBYmXFA/DOM+wRRYrnzI734WS/Vwst4b
50SijYxZSheaEJWVOT9cpK35C2qMifgs8dB9MyC2LmmD5P1rGL0BtztcmQSC3KSh
U5AvMnCnS9F+PAHWIbiAJKZxevIxDuOAMv7TyV7S2AY+KGW5wQS2isMHy8KhFRYm
1x8qvSbWvETF2H/4rzKM3s9yWg1S5w==
=lL31
-----END PGP SIGNATURE-----

--NVYrnRlgCQ2dWcNf6WA1OxAcEomB67SXn--

--===============3442369609691983668==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

--===============3442369609691983668==--
