Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA3D1E9DFC
	for <lists+linux-nvdimm@lfdr.de>; Mon,  1 Jun 2020 08:19:46 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A011D100DEFF9;
	Sun, 31 May 2020 23:15:02 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=106.10.241.82; helo=sonic305-19.consmr.mail.sg3.yahoo.com; envelope-from=roshanishrivastaw@yahoo.com; receiver=<UNKNOWN> 
Received: from sonic305-19.consmr.mail.sg3.yahoo.com (sonic305-19.consmr.mail.sg3.yahoo.com [106.10.241.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E91D2100E2AF2
	for <linux-nvdimm@lists.01.org>; Sun, 31 May 2020 23:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1590992380; bh=VvWhTjueOF3fqxm96/qLqRIVwkVHUuKCcgIq7Fh1RhM=; h=Date:From:Reply-To:In-Reply-To:References:Subject:From:Subject; b=VD4YGtv7f0tqA8YSLMrnVD5wA3RsVUfQD7N2oqasyEk8YZ6TGuMfGbW+7RVTY7xQepzV19O6U5nz+gXUGQGkDXvaVRpvUHZw6GjHqT+FB0g5i5EfUWM82dORSxtBZ2RlINSQf9ld2IYXt2aBU+nK1jJXomafn63+D1/TDAxbE2hhmDKNibQyB+VFuk+jLJb+q9Y/5OlDR77Co2sHAWYu6fRQstt1XTUh4w0k45xU9o+jj2F1kPNYTSoWiwsXXHtmo/BzJF81Eq55Jc2G1W9Cm37PbKVjKskuUVCedQhZmthOIQ8XEjTrHAsaHdDcshKYzjaYUgfEa5vvX7JLlBnwlQ==
X-YMail-OSG: SasCRxYVM1nwSpN1LUWNmgIMZz78mPGy1ctvyFK_0laeUQCfLA.YiiHqcHuI9ju
 z6yqd.w0q6dK_aRBZ4wkDaL8CIf5oJzmDZNDZp9mOBNr0Ak7_1VAwUYZsnxVh4rQjY8eoNaHIFU_
 ap2CvtszgodsDcy7SRmJOfLzwbPi5MCVIQAcRElUNp0IZShZxxTfPpDoxsQ4yy2ybIdozbK14zJG
 soUbmfbpCgIBNr_A7fGF7POQAMpfmHRJ1vWwOAL3vLIk1CfjIUHDSY0djvVXQkjucPvDlJtvlxdk
 KkdElJgg97oAXQwuG9.GMrVpa8Yk.PCo16yvOP.Sa5k0rbrf72_Un6Rq8xz54So67AXWtmNB9CFn
 u.e_FW.6qThWLNzdj8XfLlZbxFJL8i3ylK5XmHokYJ0WlbQlr08R5Go4rEIW3gkajduCyEaojKiu
 D2cw61KnNkYeUjneE1NJ7Z7h__GSbZJ6sxZ3_xhd57aVRMjuVNPl4JZrXt26i_G0KdJRR5ZrbX.s
 WMW3OH9jfmFthLlunWYJTINlfJC9hBfCNHOHYWG87u08i0TboePJmndvmh20dP283dxBaaizomSL
 vcLyjLDa6dcuB6yde7TL7CO8q8J9J3lu0lURXO02uhHLBi3poGWPfue2xa6tBdoZsppF5AMRnRLF
 KmmEZOsc6GTWHy5CEGp8PlInfCXm38bGnKfZl6kn.iaOo_7Lp9gmgZmnJEBxLR0d0zMb3nnh2MDI
 3IeE_ef4Lel9gzxw1rvIp_TTx8Cew7KPiKMiOf6YgxveYhmhSNVvFijXpvSw8IgCno7TnDhJS476
 A4Qbz.ERp_xtKB9bLXBs4zMACfSj80xZItqcd4_fo8.n5.hWf_r73IdxVtGBR9RPlUDgts.rZiEb
 AHZ.JSI9_iiZf9bnOyskbJ9ahavR8FYf8NDU4AkEBawnJO_6ygnE1neKHt7_Z0yqPoZyq4OEUdj1
 BXsJ8JJFGis9eBu9g0VtsYBtQVsIhjH1jSNVCbeuO.SfKupM1GXIYXbjqQdDP5whcP6i0P88fZx9
 pzBTRZFfz6VXU8E_XqseZ5htv1nmgpArkmhwtXBLSd5ZhE2r4FkiijhRNsJfH63hOlpsV9oHQlNf
 8cG0NqAnz87KVlNlMZw6U7ejzq_.uJhKt5KFexXPQUIK8w1Zklv1oSEdUfgdp_1gwMYTfmPB5nBB
 Jg7QPkl295aqjBm18U6IAVaz6LgaqgWRWVDqBQodekN5TKvoD_vT7yNjgL97IIXlGIqhcdHm2CH0
 Dy7sfZItuLDikpKZlT5z8rHk.06ABsj.9RMYSQZPaUfnyQVZVpm8bUylx2Zf4TEMuCGlxHX5nzoM
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.sg3.yahoo.com with HTTP; Mon, 1 Jun 2020 06:19:40 +0000
Date: Mon, 1 Jun 2020 06:19:35 +0000 (UTC)
From: Riya Goyal <roshanishrivastaw@yahoo.com>
Message-ID: <1292310910.599146.1590992375092@mail.yahoo.com>
In-Reply-To: <951256005.2233599.1587377894073@mail.yahoo.com>
References: <951256005.2233599.1587377894073.ref@mail.yahoo.com> <951256005.2233599.1587377894073@mail.yahoo.com>
Subject: Re: Apps
MIME-Version: 1.0
X-Mailer: WebService/1.1.16037 YMailNorrin Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.61 Safari/537.36
Message-ID-Hash: I3LH5LE4XZF2QP3LVBRCUVY5WC67X7AJ
X-Message-ID-Hash: I3LH5LE4XZF2QP3LVBRCUVY5WC67X7AJ
X-MailFrom: roshanishrivastaw@yahoo.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: Riya Goyal <roshanishrivastaw@yahoo.com>
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/I3LH5LE4XZF2QP3LVBRCUVY5WC67X7AJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

IA0KSGksDQoNClN0YXkgc2FmZSENCg0KSnVzdCB3YW50ZWQgdG8gY2hlY2ssIGhhdmUgeW91IGNo
ZWNrZWQgbXkgcHJldmlvdXMgZS1tYWlsPyBEbyBsZXRtZSBrbm93IGlmIHlvdSB3b3VsZCBsaWtl
IHRvIGRpc2N1c3PCoE1vYmlsZSBBcHAgRGV2ZWxvcG1lbnQgc2VydmljZXMuDQoNCklmIGFyZSB5
b3UgaW50ZXJlc3RlZCwgcGxlYXNlIHdyaXRlIG1lIGJhY2sgd2l0aCB5b3VycmVxdWlyZW1lbnQg
YW5kIGlkZWFzLMKgDQoNClRoYW5rcywNCg0KDQogICAgT24gTW9uZGF5LCAyMCBBcHJpbCwgMjAy
MCwgMDM6NDg6MTQgcG0gSVNULCBSaXlhIEdveWFsIDxyb3NoYW5pc2hyaXZhc3Rhd0B5YWhvby5j
b20+IHdyb3RlOiAgDQogDQogDQpIaSwNCg0KR3JlZXRpbmdzIQ0KDQpEbyB5b3Ugd2FudCBhIE1v
YmlsZSBBcHBzIChBbmRyb2lkL2lPUyBhcHApZm9yIHlvdXIgQnVzaW5lc3M/DQoNCldlIGRldmVs
b3AgbG93IGNvc3QgbW9iaWxlIGFwcGxpY2F0aW9ucyBmb3JnbG9iYWwgZW50ZXJwcmlzZXMgdGhh
dCBoZWxwIHRoZW0gZ3JvdyB0aGVpciBidXNpbmVzcy4NCg0KwqBXZSBhcmUgYW4gSVQgY29tcGFu
eSwgd2hpY2ggZm9jdXNlc29uwqBBcHAgZGV2ZWxvcG1lbnQsIGlPUyBhcHBkZXZlbG9wbWVudCwg
QW5kcm9pZCBhcHAgZGV2ZWxvcG1lbnQsIEhUTUw1IGFwcCwgTWFjIE9TWCBhcHAsIE1vYmlsZSBh
cHBkZXZlbG9wbWVudCBhbmQgQ3VzdG9tIFdlYiBhcHBzLg0KDQooQ3JlYXRlIGFwcCBmb3IgeW91
ciBidXNpbmVzcykNCg0KSWYgaW50ZXJlc3RlZCwgcGxlYXNlIHdyaXRlIG1lIGJhY2sgd2l0aCB5
b3VycmVxdWlyZW1lbnQgYW5kIGlkZWFzLMKgDQoNClJlZ2FyZHMsDQoNCihJbmRpYSkNCg0KICAK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZk
aW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2Ny
aWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
