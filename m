Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC6D2F8B4C
	for <lists+linux-nvdimm@lfdr.de>; Sat, 16 Jan 2021 05:39:04 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 189B3100EB358;
	Fri, 15 Jan 2021 20:39:03 -0800 (PST)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=67.227.255.162; helo=host.unuhospedagem3.com.br; envelope-from=rcrsolucoesdigitais@gmail.com; receiver=<UNKNOWN> 
Received: from host.unuhospedagem3.com.br (host.unuhospedagem3.com.br [67.227.255.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6E240100EB358
	for <linux-nvdimm@lists.01.org>; Fri, 15 Jan 2021 20:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=rcranalisesetoriais.com.br; s=default; h=Content-Type:Mime-Version:
	Message-ID:Reply-To:Subject:Cc:To:From:Date:Sender:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	 bh=AZQFvJYkbA/KqAB137AtPM1x59WDmY2jQT9zUEXJCRw=; b=kPgPUCHJowVKiiq9lOlmwglA5
	CDpBBCfG7M+Pv3G6+2i6jcWP3Cup8k0zOuMmBDl21cxnMRef2eToS0A2fqah7ekWYEec+dtScg4C8
	vm3gcLuRozXDi0Yetk436egXnlQMqJ4OGQkepKY2V7YT9Ul5cFLKQYTdJTGP2BJfP8ORZTItLJI54
	oSPuHuSlxCOR+yofMYlTdBDX5JF05hZJY6bxaqV1oasTSF4Pfl/KbLTQNkRDmkv7i6JGehsvAYA93
	HfdLHqy4F8t/eoS3MmpqwQy/jEoiQ8HUmhKULrTtPJLpMoR6cj6+PEbW7KD2gmOSThWOzN886MrMK
	me8ZscXEg==;
Received: from rcranali0 by host.unuhospedagem3.com.br with local (Exim 4.91)
	(envelope-from <rcrsolucoesdigitais@gmail.com>)
	id 1l0dMY-0006k5-Np; Sat, 16 Jan 2021 01:38:58 -0300
Date: Fri, 15 Jan 2021 23:38:58 -0500
From: =?UTF-8?Q?RCR=20SOLU=C3=87=C3=95ES=20DIGIT?==?UTF-8?Q?AIS?= <rcrsolucoesdigitais@gmail.com>
To: linux-nvdimm@lists.01.org
Subject: =?UTF-8?Q?MENSAGEM=20ENVIADA=20COM?==?UTF-8?Q?=20SUCESSO?= =?UTF-8?Q?!?=
User-Agent: CodeIgniter
X-Sender: rcrsolucoesdigitais@gmail.com
X-Mailer: CodeIgniter
X-Priority: 3 (Normal)
Message-ID: <60026de2a4b30@gmail.com>
Mime-Version: 1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host.unuhospedagem3.com.br
X-AntiAbuse: Original Domain - lists.01.org
X-AntiAbuse: Originator/Caller UID/GID - [504 32007] / [47 12]
X-AntiAbuse: Sender Address Domain - gmail.com
X-Get-Message-Sender-Via: host.unuhospedagem3.com.br: authenticated_id: rcranali0/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: host.unuhospedagem3.com.br: rcranali0
X-Source: /bin/bash
X-Source-Args: sh -c cd '/home/rcranali0/public_html' ; /usr/sbin/sendmail -oi -f rcrsolucoesdigitais@gmail.com -t 
X-Source-Dir: rcranalisesetoriais.com.br:/public_html
Message-ID-Hash: 7J3MEGLSMJZSYNJTMPCOCA4NGPFGFR73
X-Message-ID-Hash: 7J3MEGLSMJZSYNJTMPCOCA4NGPFGFR73
X-MailFrom: rcrsolucoesdigitais@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
CC: contato@rcranalisesetoriais.com.br
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: rcrsolucoesdigitais@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7J3MEGLSMJZSYNJTMPCOCA4NGPFGFR73/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

U3VhIG1lbnNhZ2VtIGZvaSBlbnZpYWRhIGNvbSBzdWNlc3NvISEgTm9tZSA9IEUtbWFpbCA9DQps
aW51eC1udmRpbW1AbGlzdHMuMDEub3JnIEFzc3VudG8gPSBNZW5zYWdlbSA9IOKdpO+4jyBMb29r
IGF0IG15IHBob3Rvcw0KaGVyZTogaHR0cDovL2JpdC5kby9mTUNEej9xaDZ0diAtIGRvIHlvdSBs
aWtlIGl0PyDinaTvuI8gRW50cmFyZW1vcyBlbQ0KY29udGF0byBlbSBicmV2ZQ0KDQpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFp
bGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2Vu
ZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
