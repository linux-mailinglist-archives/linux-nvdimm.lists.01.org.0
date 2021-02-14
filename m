Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9C431AF97
	for <lists+linux-nvdimm@lfdr.de>; Sun, 14 Feb 2021 08:28:39 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4F62F100ED4A3;
	Sat, 13 Feb 2021 23:28:37 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.92.254.24; helo=apc01-pu1-obe.outbound.protection.outlook.com; envelope-from=nib2ntezerk@hotmail.com; receiver=<UNKNOWN> 
Received: from APC01-PU1-obe.outbound.protection.outlook.com (mail-oln040092254024.outbound.protection.outlook.com [40.92.254.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1E1FF100ED49E
	for <linux-nvdimm@lists.01.org>; Sat, 13 Feb 2021 23:28:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=glOnZnKrREKTKXIykH9FNu1ZFlQ9LnN3sRXOSJrtoMBWjfNJrJg4qByqaNUPq7pHgBIADmQn9Vh8R9wNq3I3f2rdt53lpFWPOlK/i2sOmAQl0m2G0Q4IXVMGiYNzTehTKUGOrz+1vr5tm0O71ZLY/5lbLERrm8HD4gIyIge0U24g5TyooHgGw+kbMVwlngpxJmxPHi4gXMVVjPkVpY0Tkn0nAIjpXpvDrg/i6VwXxXr/rey0NzEXdLRGQSbkLqdXOaDVURugqSbBdr3tRJGCx9vl8U6u7dz16FQu3681zeD2tUNcFgvkLCoHver5jP4CA2Um8Dpc8LGIXdUCvqM42A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2MFt8P3y9LQdFsggu6l16tRQxxHb8hzk3HXcpnv2OQ=;
 b=QYR2FuJfNCdcl8daGIWcQ6wtPISUNAeV1hF1VCYJw4E2QTdSQnS38O2X5YxHVwuECQcz0xtOm/iSRMpRve1OBfiUvZ6YqYoj9k+3SD+bzf5DQDONKkdxsJ1WT58Zpar4cg8odftEMJlaBiZfyV9QCnXZAETtLiZc9TVTntFdLBn2JQioS7D4h2yQcPzPl+pNp7JTREMHwNrLR+5UwYWMpL5LVr/2TRG/fROdU8GCAuFMVF9hsSbNyGJnppk3ORkUWUU+fRp0JqfApERQnmLpYNIgDY/zyCH2v7yUP2z8Wdx29JMQ/uv2I158sY2GKJKsPC/29ysttafEyirHJWJKjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2MFt8P3y9LQdFsggu6l16tRQxxHb8hzk3HXcpnv2OQ=;
 b=oOmx+H2OHopCnzwLwmgJorMY9BlaAjrTy8OKpo9HPeutQRmRQgKKQBST/5qO6bOkWtYgt2/Cm6ltnh7Z8NIX6vDKX2eElSBr0jQ42QXsKveDdoscbNBZKw2sBeOU4nAdUB2lhmSg09Gl4X49/x2ybNoT/RQVhPbNoik4zZQbC292VVhKp8aUnQspgF3BUZhU5ABosi+mG9Xf4sxn400eY+npVSg8Q5T1AvjwmvX3cB+VZQdmJbeNM84QWS089a3pL03CxBNZTWV0SyyCCNsInymS2M1RBo6MGp97Ibg2cWM9jkYHfs4Ywqqbuc2xqgK+3wdYvBPEcpV/nmRVkRaE8w==
Received: from PU1APC01FT025.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebe::40) by
 PU1APC01HT111.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebe::325)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Sun, 14 Feb
 2021 07:28:18 +0000
Received: from TY2PR01MB1980.jpnprd01.prod.outlook.com
 (2a01:111:e400:7ebe::45) by PU1APC01FT025.mail.protection.outlook.com
 (2a01:111:e400:7ebe::237) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend
 Transport; Sun, 14 Feb 2021 07:28:18 +0000
Received: from TY2PR01MB1980.jpnprd01.prod.outlook.com
 ([fe80::2dd9:5202:39b8:4313]) by TY2PR01MB1980.jpnprd01.prod.outlook.com
 ([fe80::2dd9:5202:39b8:4313%3]) with mapi id 15.20.3846.027; Sun, 14 Feb 2021
 07:28:18 +0000
From: warre lorne <nib2ntezerk@hotmail.com>
To: "zbhzzk@163.com" <zbhzzk@163.com>
Subject: =?gb2312?B?zfjT0ce/wabNxrz2o6zX7rfhuLu1xNGh1PGh+Q==?=
Thread-Topic: =?gb2312?B?zfjT0ce/wabNxrz2o6zX7rfhuLu1xNGh1PGh+Q==?=
Thread-Index: AQHXAqL39cDKEsLRCkG1+gI8xiq1Kw==
Date: Sun, 14 Feb 2021 07:28:18 +0000
Message-ID: 
 <TY2PR01MB1980BECE6F63F550634D2E64E1899@TY2PR01MB1980.jpnprd01.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: 
 OriginalChecksum:876EEFFF9A46E339A51D2CEE9F767F5698DD83EE3E5D55399C6F865EF90A3D2F;UpperCasedChecksum:A7533485C8D85B43A17946500A01A627BB100C965AD3A43F766EBCAE113413A7;SizeAsReceived:11915;Count:41
x-tmn: [ausIBkVJsTvSX/uLH+uuanb/mU3iLtGR]
x-ms-publictraffictype: Email
x-incomingheadercount: 41
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 19616fe1-51c0-414a-e530-08d8d0ba1999
x-ms-exchange-slblob-mailprops: 
 =?gb2312?B?MnFqWjBqRk1CN3BaWTJhbEJjTWVtZ2J3RmNXWXJjOWU4OHJNY0F1VnZRY2Rv?=
 =?gb2312?B?M1dQMzBRM2V1ZUFNaitZK20xa3FFa1lqc1dZSkdzVUFiU0lhbnhKNE9IZHRK?=
 =?gb2312?B?QXNNRFA4NnBkRlFCTlpPTERxc0ppTHRyd0EvaGl5cmtnZVVPN1VpaXJCTVdI?=
 =?gb2312?B?SFZua05UeWZwRm16TE1MV0czU04xZEdnTTBSN084ZGJoSUFzUHY2eDYyNENN?=
 =?gb2312?B?UjZVemJrdkY2U3Y0aUFGbVNnWmxuVGsyb0hGbGg0clZVRGJteWU5NjBFb2ZD?=
 =?gb2312?B?TlpFcm9iNm90SXFHM0ZDSVo3MkdEcVB1MjhwUVh6NE92ZU9KK2FBWlp4eGUr?=
 =?gb2312?B?SWJrMlhTUjI4SnhVeDZKUkozb3Q2dnRKcWdzdWFJZnVPZGo1ZWZUWEFwT2Rw?=
 =?gb2312?B?YUZGK1B2bENwZU5kbnRvS2RGMXhaaTVKT3FnSnpRdmV1YUhQYm1uVWRyNEFy?=
 =?gb2312?B?dnNIN1NOODR2eG82dmFSZmp5bTVRVVl6bGEwRzJXMDE2ZHpoWWVvRUdlbnBi?=
 =?gb2312?B?K1puK0M5ZHMyOFVqbGtVOEQ3MDV1QS9iZlJpNzdBOXFibDZobEtBQ3FlL1kv?=
 =?gb2312?B?QnU5ZnBRWjRlbUE2eEF3NTFMSnI3cVhQdHkrYjhST1N5MzNCV2JTQVhyNno2?=
 =?gb2312?B?a3lhdUx5aDdnREladE9EZ2E5eFYxcmdLRGRkZTZ5NzZZdjBPNENXK1FEWFBp?=
 =?gb2312?B?ZFpEOG9xSktmeDY0Q09sbVQzYWJQeXRQVmFOd0VXQVNEaEdBckkvem43MkFT?=
 =?gb2312?B?WFRqRjVGdUk4eEJYb1Zibmlxc09ZbmJYaG1RdkF0V2gzVnpXVmIrajlKMXZE?=
 =?gb2312?B?QUpxcDN4STArb1RCOWZoei9iTHZ3MnBqQlIvVHhJMGdvdDlKVVdITlNVeE5l?=
 =?gb2312?B?Tm9TcUp4ZDYwRGs2OWhVb3UvVmptZ203U3p2R3gwSXRPc04vRXBjTmhOSVpq?=
 =?gb2312?B?NG9JREdFQUNJbFhJeFNSRjRvZFI4U0dCalZTNlJzNXhtYitTbWZHeXBEYm5O?=
 =?gb2312?B?WmpYVVdDMWxGWUFIeGVnelJURFMreDhOc3BrZGk5TmhQRVZOWWJUN0ZHeXph?=
 =?gb2312?B?aHpMelgvMGVaL0VOQUVONm5FU3NhaEcvMHkrRTRidjQ1QTdjb002a2lXL0c1?=
 =?gb2312?B?T1NhTlltTTR6eFJjNk5LZzFJenp6RWVnVUt2ZnAxRDlNK2lyWWlrcWRuZ29J?=
 =?gb2312?B?a0VibSs4OEY4TnZYVkt4dU5JS3puVjY1SmtUb0pOU3ExM2Z0WGM5TDlQMzJJ?=
 =?gb2312?B?MGUzWDFRSVBEY1U0RS9ZOERhNWsyamNsaGpaOU9BUUJiV0dwbldlSzNYYkg4?=
 =?gb2312?Q?EG4FwLCcXApf3bXpaIpuXYQoSjV6iZN58V?=
x-ms-traffictypediagnostic: PU1APC01HT111:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 5ZXdAWz7BTsUAhu+NOkiOo/5KidJdPwnA4F0ck5kR+uPLVlNrmPh+vob2CgEixF747IyXLBcl9k1YBfgvGcsB1r7BGvnZt6S6AMZBAgC5HUkweHucTan/+kJ+Qkt72LTv7opnwwTm514fMarvUQ/1nEHS7u7lzfqY+2ipkGpNY7jpfS9QbTgG/h9V+bqMZCfYhHjswiS7WYWPztDdOnsfg+ffoHWpfE31WFibFimUZKrXlzX72BLkZYZoHzVjEF6lQKlnbPY1k/RA3DYwutHjBboaOIoBOdg27P3jNgyT8yrWsUMWvM/9/XmkiyF1SV9C/iuiNOjo0TJuvD6aGdGjSR8X4ag9RFXa+V9S/ANeQexrWK5M/q8AKuiqpm31RxjwehAXmfbgIEnu/DaS/PKZQ6I/YgTiZ22/SbP5xsMJ9w=
x-ms-exchange-antispam-messagedata: 
 atxeedJIZX+YQEKebWxf2ChuUO2ibHpNcf422UAxdJJi4HI2UbpTpTizO99XSyEmi7ouXNoOQt4aDbJpJxph2JnxdJ2rCQufKK5HHLTZ52Yl/k8Gy4lAgnchJr3sk1d9jagkN/6TJaq3m8wmvdVvoA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: hotmail.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-AuthSource: PU1APC01FT025.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 19616fe1-51c0-414a-e530-08d8d0ba1999
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2021 07:28:18.4406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT111
Message-ID-Hash: WB3IPN2MPVRYATTJQ3SVWQWV42V5RSUW
X-Message-ID-Hash: WB3IPN2MPVRYATTJQ3SVWQWV42V5RSUW
X-MailFrom: nib2ntezerk@hotmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
Content-Type: text/plain; charset="gb2312"
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JQQUSADJWP4QM6LZ75YNDQ2HXCZ7RWPH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: base64

xPq6w6H5ofmh+SHO0sPHysdrddPpwNYuztLDx9X7us/L+dPQ0+nA1s34087Pty7Iw8T6ssa4u76h
1NrK1tbQLs/fyc+zrLn9sNnN8sjLxePE+tK7xvDN5s/tytzX7tXmyrW1xNXmyMu21NW9LrDZvNLA
1i7Az7uiu/ouzOXT/bLKxrEuuPfW1sqxyrGyyrXI087Pt7a809Aszea80tPrzea80tauvOS1xLbU
vvYusNnIy83FttPXqNK11MvTqtK1zvG3ts6nsemyvMirx/LWu9KqxPrT0LG4tvjAtL7Nv8nS1ML6
1Ni2+LnpLs7Sw8fKx9X9uea+rdOqtcTT6cDWzcW20y6h+bGj1qS1vb/uu/DL2bW9v+4uxPrP67Ty
t6LKsbzkLs/7x7LKsbzkLtfc09DE48/r0qq1xNPpwNYu16Ky4dPQ08W73brswPsu0vLOqrPP0MXL
+dLUztLDx2t10+nA1sTc1NrIq8fyzfjC59Taz9/M5dP9zbbXosa9zKjW0NOutcOzz9DFv8m/v7XE
w8DT/iEg1NrP38zl0/2+urLKzfgs1+680cqxyrGyysa9zKgstPPA1s241KSy4iws1ebIy7DZvNIs
tcLW3cbLv8ssIDI4uNwsofnC6b2r087PtyzFo8Wj087Ptyy2t7XY1vfTrs/WvfC1yLbg1tbG5cXG
087PtyzAz7uiu/ostefX09POz7e2vNPQIcO/zOzWwcnZyc/N8sjL16Ky4S67ttOtxPrSstK7xvC8
08jrIMa31sqxo9akLrP2v+6xo9akLLP2v+6/7MvZu7bTrcT6wLTK1M3mIaH5ofmh+cjn0tTJz8Gs
vdPO3reotPK/qqOsIMfruLTWxtLUz8LN+Na3tb3kr8DAxvfW0LTyv6o6aHR0cHM6Ly9yZXVybC5j
Yy8zTGFRYVg8aHR0cHM6Ly93d3cuMWt1MTExLmNvbT4NCjxodHRwczovL3d3dy4xa3UxMTEuY29t
Pg0KDQprddPpwNa1x8jr16jTw8341rdodHRwczovL3JldXJsLmNjLzNMYVFhWDxodHRwczovL3d3
dy4xa3UxMTEuY29tPg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEu
b3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxp
c3RzLjAxLm9yZwo=
