Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 178B12B0126
	for <lists+linux-nvdimm@lfdr.de>; Thu, 12 Nov 2020 09:22:16 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DF5F4100EF25F;
	Thu, 12 Nov 2020 00:22:13 -0800 (PST)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=69.16.218.16; helo=sd.sdsofts.com; envelope-from=info@baliyev.com; receiver=<UNKNOWN> 
Received: from sd.sdsofts.com (sd.sdsofts.com [69.16.218.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6B9B9100EF252
	for <linux-nvdimm@lists.01.org>; Thu, 12 Nov 2020 00:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=almuhajir.sd; s=default; h=Content-Type:MIME-Version:Message-ID:Date:
	Subject:To:From:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=32WJwfcBzWa3P3hfYAds2P+gEAObgnF56u8CdBJLt7E=; b=olRF/jfuAW5DjrIqtaC2jZyf+7
	uayG5wCH0kteERFVPOtvS7y692t/afLsNTzpZxhR6oKufzqQBzkR6oEDSOOn6B4Ybb7w7DdQbB2N9
	SXvQPYkej8iWZWoQIaeaETkYkStS0AQxX7XRYf7LxNXbgPlLdOs8Wo00Hx3nzlf9wCtQtYrInkkFx
	zEGf9Mi1nVaPbtIEetPhcVluQDEmFKwRrqMHok+/Cl+2+oijmbiRx1UcuV08qXvrS1kHFE41Qu3QW
	E383o9cgKEz5SrOlg7hIrzWiqQ5xcNLyySmpHJ2NAxYeAf/Jcv2SRsQ/Sm4TTkHWo4upp2RTq0k2F
	zguunY5A==;
Received: from ec2-99-79-56-76.ca-central-1.compute.amazonaws.com ([99.79.56.76]:62487)
	by sd.sdsofts.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <info@baliyev.com>)
	id 1kd7rt-00077t-E8
	for linux-nvdimm@lists.01.org; Thu, 12 Nov 2020 11:22:09 +0300
From: "support@lists.01.org" <info@baliyev.com>
To: linux-nvdimm@lists.01.org
Subject: New Recording [13913790]
Date: 12 Nov 2020 08:22:09 +0000
Message-ID: <20201112082209.F844946387FC7F9C@baliyev.com>
MIME-Version: 1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - sd.sdsofts.com
X-AntiAbuse: Original Domain - lists.01.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - baliyev.com
X-Get-Message-Sender-Via: sd.sdsofts.com: authenticated_id: satc@almuhajir.sd
X-Authenticated-Sender: sd.sdsofts.com: satc@almuhajir.sd
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Message-ID-Hash: WBGNYUHL5KB5FJYQBE37UHNMWM3QHZIO
X-Message-ID-Hash: WBGNYUHL5KB5FJYQBE37UHNMWM3QHZIO
X-MailFrom: info@baliyev.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WBGNYUHL5KB5FJYQBE37UHNMWM3QHZIO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

wqANCsKgDQoNCklEOiA8IGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcgPg0KDQpBIGNhbGxlciBp
biB5b3VyIGRpcmVjdG9yeSBqdXN0IGxlZnQgeW91IGEgbWVzc2FnZS4NCg0KQ2FsbGVyIDogKzEg
NzAxIDMyOCA5MDEwDQpEYXRlOiAxMS0xMC0yMDIwDQpEdXJhdGlvbjogMDE6MHNlYw0KDQpMaXN0
ZW4gdG8gVm9pY2UgTWVzc8SFZ2UgDQoowqBodHRwczovL3dlbGwtZm9ybWVkb2VmZWR4eGUuZmly
ZWJhc2VhcHAuY29tL2kuaHRtbD9BbGxNYWlsPWxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcmQWNj
b3VudD1lbi1nbsKgKQ0KDQpFbWFpbCB3YXMgc2VudCB0byBsaW51eC1udmRpbW1AbGlzdHMuMDEu
b3JnDQoNCllvdXIgbWVzc2FnZSBsaW5rIGxhc3QgZm9yIDEyIGhvdXJzwqAKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcg
bGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4g
ZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
