Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8FE374B87
	for <lists+linux-nvdimm@lfdr.de>; Thu,  6 May 2021 00:48:50 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4B05B100F2265;
	Wed,  5 May 2021 15:48:48 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.92.255.59; helo=apc01-hk2-obe.outbound.protection.outlook.com; envelope-from=lloydh326vxmi@outlook.com; receiver=<UNKNOWN> 
Received: from APC01-HK2-obe.outbound.protection.outlook.com (mail-oln040092255059.outbound.protection.outlook.com [40.92.255.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 51EAB100EB32D
	for <linux-nvdimm@lists.01.org>; Wed,  5 May 2021 15:48:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gsrguDz0jLTE7cGB8OhDW7P0xYwnwEZrHGOPJBtx03ptHpF2dcKBFBIj4wKvNqiPzQZdC6Wn+Sl/xzsVTb1g95ON4XyoDH/KUhfRWIC6lthMoW4VggrRFExvWAER3dJYXe3Qsoag24ICRHV/hBzE0muurn98CYF0NhiBZQDBnR4EUcQZyYvlaInYqGWa9TQn/BExC91y3WonYtrflHOUZuU912M664ae44WuQxAra7xV6FrPFO7Gh1fKF5LLwb3IW68Ms/Hkx5CHZqcw61uVoFgUeAKSmpKgTm11lXpl3RWRPXQxQlXWcNKpPhmzgL74u7oiKfmHVMZlBuWFZNXX9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fUhWGn7uHObEJpySNozYnO8eTG2Gb4P+Il76fkNoRM=;
 b=mOXD91SxeG2gg2DwsjcXqKszb1yBYaz5va8NigbkdRvmWXhGUjx+OHgdQ3biyinfN8dsr4HbI1fMabyvV8CzHPlAxZ8tNH7rUwB7jC16Tny77+6tnMwL27TTkiPO5M/4Ec9UlRCZW7MZpWCZ/q39naZT/5NY4OsLvbHdyyvK08szgTIAE2JA/ghWq7BJ+wrU5x2ra0l3IJEQq2/M0lRstC2V3AarCSTBPfm+NIUKJhTfZ4ddDF0my1QMMovyyWhMzhGb+ywQXZZNDsuMF7P366Cw3mlPy8MNsfK9xvX/zeqibrU+k4HmRVq01hLU4Gdzk1bJ+Ur/QGofBeHyV9FKJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fUhWGn7uHObEJpySNozYnO8eTG2Gb4P+Il76fkNoRM=;
 b=OniXA02bawPAkWnaSl/IEyKeZNkTH/76uF4A7CeyPR94Xw/wrj2ezw6M0dVJNab8W48pZv6cNnTszlYx+j0SvKx8Sq+WacaXuPMerVi4aNFAcSHXSNM1/D8g7M7Lr/jtDChMNmykkaVtMHRrKxQLFG/0jHxtLN1zRv7RSCxgvz3u+xG+MnCUikoarGOGzMiVUhOsU1Hxl5cC9sCWriIQShGcovoIT7gv53K9sl/VgLMRcp5mYArlzkpR9sWaZEjYFMCeh2OKbdTA0N++BxRQkLZNfly4fkJ//NpLvzWH+GsA10bhvLGqjG89BI9F4+WMoHjF3HqLbcymI39l8wwMig==
Received: from PS2PR06MB3414.apcprd06.prod.outlook.com (2603:1096:300:6a::17)
 by PS1PR06MB2614.apcprd06.prod.outlook.com (2603:1096:803:4a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.43; Wed, 5 May
 2021 22:48:27 +0000
Received: from PS2PR06MB3414.apcprd06.prod.outlook.com
 ([fe80::385b:a987:2ac5:a6e7]) by PS2PR06MB3414.apcprd06.prod.outlook.com
 ([fe80::385b:a987:2ac5:a6e7%5]) with mapi id 15.20.4108.026; Wed, 5 May 2021
 22:48:27 +0000
From: litt audr <lloydh326vxmi@outlook.com>
To: "dryde@netsun.com" <dryde@netsun.com>
Subject: =?gb2312?B?usPN5rW90/uw1bK7xNyjrLbg1Kq3/s7xsru2z7S00MKh8g==?=
Thread-Topic: =?gb2312?B?usPN5rW90/uw1bK7xNyjrLbg1Kq3/s7xsru2z7S00MKh8g==?=
Thread-Index: AQHXQgDDU7OFmpN6XUS/jxN0Y/Y4Ww==
Date: Wed, 5 May 2021 22:48:27 +0000
Message-ID: 
 <PS2PR06MB34142A80A08E38C38B58A23AB2599@PS2PR06MB3414.apcprd06.prod.outlook.com>
Accept-Language: ru-RU, zh-TW, en-US
Content-Language: ru-RU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [NGo06RtKuWbCbVJ9/J4aiIeJi1VfOj/J]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1fed2afb-1c9b-4c09-d761-08d91017e5b0
x-ms-exchange-slblob-mailprops: 
 WdFS8CKwqrvsBBOHYq+/GXq2CqJ8obOw4fujRoPaJZ4ruSjPoD2jiCtB+znBjc7K7zc3CUuYcOH8r7w+JAjlU6Rl7mya3o9lhonP6dlnn/hbQwlbsfSNjFMof2PPqRxwqWYg9KD/bFeKXvtj7CbBJ3CCX80WWvD+NvXKSPVcDBdIDDLrIcsV2j3V+cn+3FmTWfEGiGc6LzxJhA8q9/v5Rw0DlOzzDefgkLAObSdGHosVL/QtyoY4A3k7DB/CcNSftdZvZm/WIJLSEhox35+setmB+PgH1ginX7luk8Xtu0l6beuc+i2NfL05AsasxOV3DZUCUwKtJ4zHKXJSwckD2ROXmIYjMSZ42UnSsNuhUW5cU3IL+j+wguWIz5ehrQZEjZmwfeff0gwXV5zzRQzqWzVyYah+g2LG4xo0vD+xU4BX/M8QYDMAFoH7rWUKY3yxVqwzlsYrMwUe4NdswWZIzdao1Jj7OYs5Hj0odQv4doNxQd/an94SXLEsLkHfHuaIIaWt/pgH5jKuR2g3kALr4vuN/PL306LayImvUc8htsi0XaO8NcXo9QBxg3ZWaFTXs6q9W0sRTPLoaxe0nQLc7P+WOiYELw9zJuS1GEiROmK6hs/ueTbgDIn0qUyeYjJ/HcIOHq96W6oxaGGSceIK1QH6o4tl1tv47Dd5YnhNgW08XwIOUVtkjs9qFGgKAqRw+vgqmEyIu7YDNDFLEdEEBWodybsBVnNfw47MlN6oJDnQks1ybCdYgmWv3t2fpYljHNn+5gfjzLYKhrGpBBTdn8I9aGKO3QijiohWzFfhWEATn37WsFWhhzWA7l+/c7EMVvkU72yhGfOI0P5BfTA8iAfVP4S9K3cV
x-ms-traffictypediagnostic: PS1PR06MB2614:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 HGb+dX1kC1rPpCLB5J8pd42Utu1bJFFdAfgzqAo4cqDZCRTcBkHX6Gg/cFa5tnA4g8TEEv+RAPvSXGEuUk54wjkj1ze7A7lyAeNVl2DDH5UkSn8i2VDVMbVysHW7p6n1XjJ9IP0XpZklfUPQagKKVlsX43tOBjdD8JWKlQhFv0BYrf2SH+9oJ8uTQOsPsCrCYOBJ19g8WIDuAkhpF8IsQbdA4Sq4LMUmvV0kJdMP8djWsuILxvunkavFL6Z++EEEY+XnxI5ytd2XhxLGMol6toUwm795YKKfvsOduuepbyAutw2UyckDX9h+/9jPD/lL+PKIvusDxDth9BMziU9gAWow5HEaq0Mtw6wISYDDJ8y1Bk7IFKxjdpIkjBiMChkxRk6KA9fMSODa/r8sekl7wHmxsLGMSzifkfdKnpcqqs/k4JMEwcCzesFq/5Coytkum/AVreq1HmE/PfGUmaGsSw==
x-ms-exchange-antispam-messagedata: 
 TssE28e2lfX5FsHO7YdyhQ5IlQX1qqCLPmBs5wY+GjgNgLKUAlPdu+httFAl2erwA3KWe5sbnffmEUMSe2S7Ml8tkAz1vPIJ8RNH/GI8HZqVn8zPrscvWCUg1MosNpeDvQYWIfTXnvMWI/9Qfm1IrA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS2PR06MB3414.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fed2afb-1c9b-4c09-d761-08d91017e5b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2021 22:48:27.2630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PR06MB2614
Message-ID-Hash: JMEBZCI3YHCAYPWJTGUASMWBLD5QHM6H
X-Message-ID-Hash: JMEBZCI3YHCAYPWJTGUASMWBLD5QHM6H
X-MailFrom: lloydh326vxmi@outlook.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
Content-Type: text/plain; charset="gb2312"
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/467ZU7XEVARJOE7HZ5AAUSEQQE3FDPHS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: base64

w7/M7La8yc/Hp8jL16Ky4bXE087Pt8a9zKhVQ8zl0/3T0NfuyKu1xMrWu/rT6cDW087Pt8fSzfjW
t8rHzqjSu7XEudm3vc341b4sVUPM5dP9xr3MqMrHtPPQzbXEufq8ytPpwNbTzs+3tcROTy4xLM3m
vNK/ydLU1NrN+NKzyc+1x8K816Ky4Sy52c34u7nM4bmpYXBwz8LU2LCy17AszebTzs+31+61o9DE
vs3Kx7P2v+6h8lVDzOXT/bP2v+6/7MvZLrK708PU2cXCzea1vbrazfguofJVQ8zl0/3Tw9DEvq3T
qi7N5reo1+624C7V/bnmtcTTzs+3xr3MqMjDxPrN5rXDv6rQxNPWt8XQxC7V4rj208W73bOszca8
9qOsyMvIy9PQu/q74aOsuPa49tPQsNHO1cO/zOzWwcnZyc/N8sjL16Ky4S67ttOtxPrSstK7xvC8
08jrVUPM5dP9IaHyofLI59LUyc/BrL3Tzt63qLTyv6qjrCDH67i01sbS1M/CzfjWt7W95K/AwMb3
1tC08r+qOmh0dHBzOi8vZGUzODMua3UxMTMubmV0PGh0dHBzOi8vd3d3Lnl5YWh1Lm9yZz4NCjxo
dHRwczovL3l5YWh1Lm9yZz4NCg0KVUPM5dP9tcfI69eo08PN+Na3aHR0cHM6Ly9kZTM4My5rdTEx
My5uZXQ8aHR0cHM6Ly95eWFodS5vcmc+DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGlt
bUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRp
bW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
