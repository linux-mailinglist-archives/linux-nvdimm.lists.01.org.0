Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F912E8520
	for <lists+linux-nvdimm@lfdr.de>; Fri,  1 Jan 2021 18:09:18 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7E7CE100EC1F2;
	Fri,  1 Jan 2021 09:09:16 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.92.255.26; helo=apc01-hk2-obe.outbound.protection.outlook.com; envelope-from=k3meyeroc6l@hotmail.com; receiver=<UNKNOWN> 
Received: from APC01-HK2-obe.outbound.protection.outlook.com (mail-oln040092255026.outbound.protection.outlook.com [40.92.255.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 69770100ED4AB
	for <linux-nvdimm@lists.01.org>; Fri,  1 Jan 2021 09:09:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=muOqqfSr9ARCtLTSyak1X1TENMuDyfNiWgJRxuMfswTQCGcjxMxrixr4oAmvoM79rfPZdpIUfpw8bDanABV3jyCgT2Zbh276/2s9JDUlYK7fNA8RbXTg46zc9eN1h2gHzjr0TZZJ2wge4c49euxkVYncW7exNhMEckZuJGETWl9NVB6PnlBknxfEX1iYuX55jvVehb45rwLsBhm3Z/2GXjG4TU9qi1Pm/LLhxWP5RW0556mkRFYrDOu/+j4Kc0wTqlYzM47XEv6SkImupx00/z7+U46BQHyABF0pbPp8VMd/y1bJrpWuErmVrYbAbTUKbQT/8b7xNfPt/xgrQxMxwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGfYMFb8zr7d6cBJwrbP+Xzx/AbOjR9FJjIoCf1RGIQ=;
 b=UvlrBglVO1tdCTdTJxlO6HLbMe9vXdbb5m2QefBcVD7MBfArK/Jg7t4qk8rNHcpJ8nAo2lkZAmjX7X3dYt+7SODnMaDzPayLko7FepAPtQuAyLyqN+2vcxNjSe2OKK0/LmEHfqtZWNZwuk+SkQfFCkipR9/jjPEVkiK4stLolZchIwj7cy4HqBCIkdvk69K36LCs519s2m/wMsDwZS0bSIv1fyvUm8YOwnuMxG9APQAatICaM1uWvl0M30TEkkH5eCp7zPW2zqvm9BJB6Sz6VXHRr3hJcJb/T9OFSbRmvoGYkwcXI4NQKREaDW9cKba0pGJD5LneLv/PnLEXqGr4XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGfYMFb8zr7d6cBJwrbP+Xzx/AbOjR9FJjIoCf1RGIQ=;
 b=bKs8/5ROkg8fbNPxrJarc5nir5f13ofPW2SIrlm9fQW9yy+0zljHNYED31tZtaMqCYyOa0aHhh4T+msJI7lFINQqBnMEQKFtvG7NYtBDsDC0hreXdxhMh1cjAsC+miBCl4lnFd9wgAvfKbXYB5tslCX1hMbYDySrDJuVtAWsB1Farg0VXB4CLepjlTNJRBG9/vQOCITbW9ZaWUZSJxCngClwQ4jkv9Q2yo5n8Akb7mxmQS5UMGmkeXwoUBjhZNMB9mz7briutklNWUlTb26KSv/hJ4GFnIPcfoM0XX/4nNj+VmXuenzgOrwmqDddLAvjdWPjtRkSxDuNjpSz0WLcRA==
Received: from HK2APC01FT015.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebc::4b) by
 HK2APC01HT115.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebc::272)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Fri, 1 Jan
 2021 17:08:52 +0000
Received: from SY2PR01MB2363.ausprd01.prod.outlook.com
 (2a01:111:e400:7ebc::48) by HK2APC01FT015.mail.protection.outlook.com
 (2a01:111:e400:7ebc::167) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20 via Frontend
 Transport; Fri, 1 Jan 2021 17:08:52 +0000
Received: from SY2PR01MB2363.ausprd01.prod.outlook.com
 ([fe80::4cb2:98a3:67de:2481]) by SY2PR01MB2363.ausprd01.prod.outlook.com
 ([fe80::4cb2:98a3:67de:2481%7]) with mapi id 15.20.3721.020; Fri, 1 Jan 2021
 17:08:52 +0000
From: nesiml yehudi <k3meyeroc6l@hotmail.com>
To: "tuao@126.com" <tuao@126.com>
Subject: =?gb2312?B?s/a/7svZtsjX7r/sNbfW1tOjrLb4x9K7uczhuamzrLjftcTF4sLKqJA=?=
Thread-Topic: 
 =?gb2312?B?s/a/7svZtsjX7r/sNbfW1tOjrLb4x9K7uczhuamzrLjftcTF4sLKqJA=?=
Thread-Index: AQHW4GDHeR9e86tehkSUVh9eSQ8auA==
Date: Fri, 1 Jan 2021 17:08:52 +0000
Message-ID: 
 <SY2PR01MB2363141428F6F4932951C246A7D50@SY2PR01MB2363.ausprd01.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: 
 OriginalChecksum:54E6CEA6EE641C9F984954218F21B8754D35253FF88E025E0F945D7FC24FE27E;UpperCasedChecksum:0D5824CB9289149C8EA50C1C833C9A2A63910B2AC4A6F85424394EA0C8893E18;SizeAsReceived:12690;Count:41
x-tmn: [7cetX3LqwsgGD2quqaXs9O9VN48TM7hR]
x-ms-publictraffictype: Email
x-incomingheadercount: 41
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: c49d97c1-a48d-4c07-5d1a-08d8ae77e9e7
x-ms-exchange-slblob-mailprops: 
 =?gb2312?B?U2lQcm0vN29FU3ltSHJabkFuU3JFOGhlaVVrZS9Xc3dVWnczZS84UnBGY0VK?=
 =?gb2312?B?c3pBNGQrL25XSjNCUTdpZnBJNldpWTFRbVRSU2lhajg4bW5JRWVrMjF0R01t?=
 =?gb2312?B?MStaR1d4cHVOZW96aFFpejYxbDdGVkk2bWJOejBWaUFFS3dydGtFbjhzS3B3?=
 =?gb2312?B?MEFPY2puN2tZUGtsNnkzRGdqUjd2YjlUZ3c0R21YMzRaNGlmZ3dEd2RDSFQ1?=
 =?gb2312?B?SE1JV0NvOE9vdFM4NDdsVGtBSUY5QkNrZnd2emJtWFlYUmUycndqd3ladHRP?=
 =?gb2312?B?a3ZzYjFzWW9vZjF4MUtnSFRJVlVUbWJBaCtGb0pYMUVDTGx1a0pVaVVpdjlz?=
 =?gb2312?B?ZEtaeW1wd0U4OFhDblFPcktHTHhPcWxORDB5ZGMzM3ZSVTBWVCtwRTFOSlBy?=
 =?gb2312?B?dXNibFlpWEVUdWQ1RTE4NlZnNmlzdk5vUzBlYXNVczEySktjSElCTlpkaXBu?=
 =?gb2312?B?djRhRzRmd2NwTDZEOTU1VXc3cS9mREdNeGxyRFFHMkpVa3Y1a2w3eW1MR0RB?=
 =?gb2312?B?QjJmL2c5Qi9DV2tQTXVWUXpDdzhuSGtrU0swSjdvbmFJYUg0S3pZU2lVdHBS?=
 =?gb2312?B?Y0t6WmpNYXZxMkJFdnVNaCs1UFE2ZDJKM2xFR1JRNWdHSlAvTGkzOTJUb01y?=
 =?gb2312?B?R2xSU2Vud245YU9oOStIamNiTXlSSUxJVmlSWUk1YXE1L3ZyYlVvdVc3M081?=
 =?gb2312?B?L2VFOUhSR2VRdFF2YTVBbFgxR0loYmp4ZTdtdUxmbWFPVklPZm81UWJyd1Ex?=
 =?gb2312?B?NjdhRFA5dFdJVUkrRGwxOXhabW9NUzFWcTFUVmtPTGpnd0JZSjJGS0dTS0xV?=
 =?gb2312?B?SUI2OW1NcldpYWtaNWtUNllnbm9LMCtSWXNmZjhWRGMxaEorYmdoLzN3SEIw?=
 =?gb2312?B?YTJYckdmL21UZzdzREMwUWNZSVFqbW5ONEo5dDJEeDhCblJ5OXFkRTZjSFZY?=
 =?gb2312?B?OVRXa05qRDRJemFhTmdnTXhBejBuamprWnJKRkNWRldEUHNYNmFuOXBwL3pl?=
 =?gb2312?B?dTdXc1c2cGlYbDdpVFhjbXdPMzFXME1XS3FoKzE1cCtqUGlwOUd4dENkWkxu?=
 =?gb2312?B?U0pBVmxFQnhUalhoUU0xejZWbDhjeEVVNjVaU3VNcDVRSkVUcm5oSEducW4z?=
 =?gb2312?B?cUxDeFNLTENPT1hHVE16UDdZbFBpeURudTJHQksrYUE3Q0NybVlqeXlRVzIw?=
 =?gb2312?B?Nk1RcGNqWk5BNnNrQ0J1Q0trMUhDdEIxemdlMHgzWlBEOUFnbHJseE5nelg4?=
 =?gb2312?B?MVUxMUJNVmhKVittSy9nSEJReTF2dFE0MDVJTzk5S3hZcm84cTloTWhhQ2Fw?=
 =?gb2312?Q?XecAihGODcyQg=3D?=
x-ms-traffictypediagnostic: HK2APC01HT115:
x-ms-exchange-minimumurldomainage: 1ku111.com#412
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 HTVWcIoh3FbEUQZo3n9/hXqboyXpryFaWT6LkpXJezy7m1mWmKxQNZNGALo3LeAxtlawEFBQTyw6ec+iqWZyj430gwPnqnEtUAkt8MfBg/hby0oziA8K2zGkeSUTGFbQYLHFtq/+tfKnrCem/Y1WxP4MI1iwYZxpN1srJoHzVwMpAOk/Pk6/gNgNshksCmfCKLL1GxdO/u4dMa22Kizk1n5d3B1q0lV7yML3IEmFrK+bm5uk6Cqm2VDyF8pFy+pkcBDNlPPVwuI6HDUC15xVlMk6qpyUBD9BRItkIKgAYlw=
x-ms-exchange-antispam-messagedata: 
 FPgVUL3TWrQNmHWnQ8HPxc9reKARB9PvS6pvmzC2fiyhgym4hK2GWuDYm1AyJ7AspX6p2Dc2ElG+V9IDvHagTxtlILPS8O5kZFrYpW0xMVnPP30DgrKLlRzap5Od2cHgaekjOeBTqhuEQUxchDMtOA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: hotmail.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-AuthSource: HK2APC01FT015.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c49d97c1-a48d-4c07-5d1a-08d8ae77e9e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jan 2021 17:08:52.0540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT115
Message-ID-Hash: DPORMCFBTKAS3VA6QJCXJKH35GBLHMSN
X-Message-ID-Hash: DPORMCFBTKAS3VA6QJCXJKH35GBLHMSN
X-MailFrom: k3meyeroc6l@hotmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KW6D5UA7ZK6TPNR63LWE3SBAIVUEFXVY/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: multipart/mixed; boundary="===============8141547973219179924=="

--===============8141547973219179924==
Content-Language: zh-TW
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

xPq6w6iQIc7Sw8fKx2t10+nA1i7O0sPH1fu6z8v509DT6cDWzfjTzs+3LsjDxPqyxri7vqHU2srW
1tAuz9/Jz7Osuf2w2c3yyMvF48T60rvG8M3mz+3K3Nfu1ebKtbXE1ebIy7bU1b0usNm80sDWLsDP
u6K7+i7M5dP9ssrGsS6499bWyrHKsbLKtcjTzs+3trzT0CzN5rzS0+vN5rzS1q685LXEttS+9i4y
NNChyrHL5sqxv6rVvaOswu3Jz9eisuHP7brDwPHWu9KqxPrT0LG4tvjAtL7Nv8nS1ML61Ni2+Lnp
Ls7Sw8fKx9X9uea+rdOqtcTT6cDWzcW20y6okLGj1qS1vb/uu/DL2bW9v+4uxPrP67Tyt6LKsbzk
Ls/7x7LKsbzkLtfc09DE48/r0qq1xNPpwNYu16Ky4dPQ08W73brswPsu0vLOqrPP0MXL+dLUztLD
x2t10+nA1sTc1NrIq8fyzfjC59Taz9/M5dP9zbbXosa9zKjW0NOutcOzz9DFv8m/v7XEw8DT/iEg
1NrP38zl0/2+urLKzfgs1+680cqxyrGyysa9zKgstPPA1s241KSy4iws1ebIy7DZvNIstcLW3cbL
v8ssIDI4uNwsqJDC6b2r087PtyzFo8Wj087Ptyy2t7XY1vfTrs/WvfC1yLbg1tbG5cXG087PtyzA
z7uiu/ostefX09POz7e2vNPQIbP2v+7L2bbI1+6/7DW31tbTo6y2+MfSu7nM4bmps6y437XExeLC
yiDGt9bKsaPWpC6z9r/usaPWpCyz9r/uv+zL2bu2063E+sC0ytTN5iGokKiQqJDI59LUyc/BrL3T
zt63qLTyv6qjrCDH67i01sbS1M/CzfjWt7W95K/AwMb31tC08r+qOmh0dHBzOi8vcmV1cmwuY2Mv
ZThFb0VNPGh0dHBzOi8vd3d3LjFrdTExMS5jb20+DQo8aHR0cHM6Ly93d3cuMWt1MTExLmNvbT4N
Cg0Ka3XT6cDWtcfI69eo08PN+Na3aHR0cHM6Ly9yZXVybC5jYy9lOEVvRU08aHR0cHM6Ly93d3cu
MWt1MTExLmNvbT4NCg==

--===============8141547973219179924==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

--===============8141547973219179924==--
