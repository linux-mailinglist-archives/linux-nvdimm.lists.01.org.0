Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC3930D404
	for <lists+linux-nvdimm@lfdr.de>; Wed,  3 Feb 2021 08:25:49 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9D299100EAB60;
	Tue,  2 Feb 2021 23:25:47 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.20.226.115; helo=dot.dotlines.com.sg; envelope-from=noreply@carnivalassure.com.bd; receiver=<UNKNOWN> 
Received: from dot.dotlines.com.sg (unknown [198.20.226.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 06D8A100F224C
	for <linux-nvdimm@lists.01.org>; Tue,  2 Feb 2021 23:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=carnivalassure.com.bd; s=default; h=Content-Transfer-Encoding:Content-Type:
	Message-ID:Reply-To:Subject:To:From:Date:MIME-Version:Sender:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=miRpAdBSO5eDo01VDX+EK9bqGCmqMjXHS3kO16T6iWw=; b=kpCxYUDs/Q6wFBgfe0+bmSS68M
	zcRYWno/roH+XKBInhEBiKEf4sx8y5/VefxhpIs/9qNGv8WOvWRCUN26vxTSG7tj0WdQmOoQFUzGd
	zFM6BBul3KRpIf0JTZbu6Gc0tILR3OADCzdq2jQpAr+iKaIbhn9Rm18NZ+GP5i3xtzfKEgr4eVlJ0
	3dgYZqwo3IWhtiIKzeiK2Z56Y1fDICQvb9Zp0KBuIYmQ0tUoaRYeeoyaIyZf2v3dlk5hTiB2kGqOn
	CMjmGpZsfobBwAkx8N1sOiSN6V0/cWmqmUGnX19FS5LdTSeXjM2y5OQ+CKiYPJhu4jYoICJGCThbx
	uLC5ik7A==;
Received: from [127.0.0.1] (port=46362 helo=dot.dotlines.com.sg)
	by dot.dotlines.com.sg with esmtpa (Exim 4.93)
	(envelope-from <noreply@carnivalassure.com.bd>)
	id 1l7CVi-0005Z8-7H; Wed, 03 Feb 2021 01:23:34 -0600
MIME-Version: 1.0
Date: Wed, 03 Feb 2021 01:23:33 -0600
From: Francois Pinault <noreply@carnivalassure.com.bd>
To: undisclosed-recipients:;
Subject: Hello/Hallo
Organization: Donation
Mail-Reply-To: francoispinault1936@outlook.com
Message-ID: <da06bea50ecb79383d03c55bea3716bf@carnivalassure.com.bd>
X-Sender: noreply@carnivalassure.com.bd
User-Agent: Roundcube Webmail/1.3.15
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - dot.dotlines.com.sg
X-AntiAbuse: Original Domain - lists.01.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - carnivalassure.com.bd
X-Get-Message-Sender-Via: dot.dotlines.com.sg: authenticated_id: noreply@carnivalassure.com.bd
X-Authenticated-Sender: dot.dotlines.com.sg: noreply@carnivalassure.com.bd
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Message-ID-Hash: JBM6CBJR4RGSXW3RNQ5KFYMXWQXIEQBT
X-Message-ID-Hash: JBM6CBJR4RGSXW3RNQ5KFYMXWQXIEQBT
X-MailFrom: noreply@carnivalassure.com.bd
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: francoispinault1936@outlook.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JBM6CBJR4RGSXW3RNQ5KFYMXWQXIEQBT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

DQoNCi0tIA0KSGFsbG8sIGljaCBiaW4gSGVyciBGcmFuY29pcyBQaW5hdWx0LCBpY2ggaGFiZSBJ
aG5lbiBnZXNwZW5kZXQuIFNpZSANCmvDtm5uZW4gbWVpbiBQcm9maWwgYXVmIFdpa2lwZWRpYSwg
R29vZ2xlIG9kZXIgRm9yYmVzIMO8YmVycHLDvGZlbi4NCg0KRsO8ciBJaHJlbiBTcGVuZGVuYW5z
cHJ1Y2ggdW5kIHdlaXRlcmUgSW5mb3JtYXRpb25lbiBrb250YWt0aWVyZW4gU2llIA0KbWljaCB1
bWdlaGVuZCB1bnRlciBmcmFuY29pc3BpbmF1bHQxOTM2QG91dGxvb2suY29tDQoNCk1pdCBmcmV1
bmRsaWNoZW4gR3LDvMOfZW4sDQpIZXJyIEZyYW5jb2lzIFBpbmF1bHQKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlz
dCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1h
aWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
