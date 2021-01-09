Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2103E2F000E
	for <lists+linux-nvdimm@lfdr.de>; Sat,  9 Jan 2021 14:45:37 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CCAED100EC1CF;
	Sat,  9 Jan 2021 05:45:34 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=149.202.87.13; helo=ns3018554.ip-149-202-87.eu; envelope-from=aog@server.oztiryaki.net; receiver=<UNKNOWN> 
Received: from ns3018554.ip-149-202-87.eu (ns3018554.ip-149-202-87.eu [149.202.87.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id F3FE1100EF275
	for <linux-nvdimm@lists.01.org>; Sat,  9 Jan 2021 05:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aog.com.tr;
	 s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Reply-To:From:Date:Subject:To:Sender:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=zWsUuRExwsZIXCcE5DC0rvjvwOG/ZB8nu5a3YalfQto=; b=VN5B35wUMucyKhTt3mOf3cdHJC
	UaxygWm77YLCp6bzri6BNgvIJCN5CUxlW/mr0Xp8FztMwhkRxb/QLivSraxDwZeFziasqaJ9xoBdQ
	bhgq8Nvbm8R3uNyaUo5abV6VCHbiWXtGmo2knRTPo8ypwmkRosjxyD0CHmxFnFGyfWGfDWP3bZuCX
	6IrvD6L9CrbZUvUfyk/5yXEFskHeXQgcx7aR1nDJS/Z9priWLhx+ZWPJ/NwYvEN7qGiQpLhoM39VT
	l+PQpk+CxZ4VOcrJwj34o4WmwVpZnr9dn7lQ2Ml2iiRWPwnxcwyd2WzRXEZuHkMH0zBMb8DOfVdCa
	O8dD3t0g==;
Received: from aog by server.oztiryaki.net with local (Exim 4.93)
	(envelope-from <aog@server.oztiryaki.net>)
	id 1kyEYZ-0001QE-Qm
	for linux-nvdimm@lists.01.org; Sat, 09 Jan 2021 16:45:27 +0300
To: linux-nvdimm@lists.01.org
Subject: =?UTF-8?Q?AOG_-_=C4=B0leti=C5=9Fim_Formu?=
X-PHP-Script: www.aog.com.tr/index.php for 84.51.56.123
X-PHP-Originating-Script: 1021:class-phpmailer.php
Date: Sat, 9 Jan 2021 13:45:27 +0000
From: AOG - <info@aog.com.tr>
Message-ID: <8771cd5975f08d406e75bce83ae48791@www.aog.com.tr>
X-Mailer: PHPMailer 5.2.22 (https://github.com/PHPMailer/PHPMailer)
MIME-Version: 1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.oztiryaki.net
X-AntiAbuse: Original Domain - lists.01.org
X-AntiAbuse: Originator/Caller UID/GID - [1021 992] / [47 12]
X-AntiAbuse: Sender Address Domain - server.oztiryaki.net
X-Get-Message-Sender-Via: server.oztiryaki.net: authenticated_id: aog/from_h
X-Authenticated-Sender: server.oztiryaki.net: info@aog.com.tr
X-Source: 
X-Source-Args: php-fpm: pool aog_com_tr                                 
X-Source-Dir: aog.com.tr:/public_html
Message-ID-Hash: MD7ZTJH3U74YMWUVM5NJ7357A5ZPSFPQ
X-Message-ID-Hash: MD7ZTJH3U74YMWUVM5NJ7357A5ZPSFPQ
X-MailFrom: aog@server.oztiryaki.net
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: info@aog.com.tr
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MD7ZTJH3U74YMWUVM5NJ7357A5ZPSFPQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

TWVyaGFiYWxhciwNCg0KTWVzYWrEsW7EsXogYWzEsW5txLHFn3TEsXIuIEVuIGvEsXNhIHphbWFu
ZGEgdGFyYWbEsW7EsXphIGTDtm7DvMWfIHNhxJ9sYW5hY2FrdMSxcg0KDQpNZXNhasSxbsSxejog
8J+UpSBUYWtlIGEgbG9vayBhdCBteSBwaG90b3MgaGVyZTogaHR0cDovL2JpdC5kby9mTW9vdiAt
IGRvIHlvdSBsaWtlIGl0PyDwn5SlDQoNCi0tIA0KQnUgbWFpbCwgaHR0cHM6Ly93d3cuYW9nLmNv
bS50ciBhZHJlc2luZGVuIG90b21hdGlrIG9sYXJhayBnw7ZuZGVyaWxtacWfdGlyDQpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFp
bGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2Vu
ZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
