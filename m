Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 240FD12E01C
	for <lists+linux-nvdimm@lfdr.de>; Wed,  1 Jan 2020 19:36:15 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CDDD310097F3A;
	Wed,  1 Jan 2020 10:39:32 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a06:dd00:1:4:1::a9; helo=s239617.savps.ru; envelope-from=add4@s239617.savps.ru; receiver=<UNKNOWN> 
Received: from s239617.savps.ru (unknown [IPv6:2a06:dd00:1:4:1::a9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7DD2510097F2F
	for <linux-nvdimm@lists.01.org>; Wed,  1 Jan 2020 10:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=s239617.savps.ru; s=dkim; h=Sender:Content-Type:MIME-Version:Date:Subject:
	To:From:Message-ID:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=t89kOXxzzZvQPtd1//ta4fmQdQFbd27+YW0UDEo2Kuc=; b=B1E+0dKaf5HDswvxQwCowBXUsx
	hFg5f8HNIqbxe8166QgpckIUQAWc2/GTdenn2gM/XLq7xOu5s2/+cb9YgFbVWRc8bc3oZFaHH4Bdm
	CgWEB0y6wR/JoqbMu8/Qcp3pzeFQuM+WzsEvlhNFYKNp5lQNYH4tDSx6oCJp97WhdVao=;
Received: by s239617.savps.ru with esmtpa (Exim 4.92.3)
	id 1imiql-0006Aq-LG; Wed, 01 Jan 2020 21:36:07 +0300
Message-ID: <F50F5C799E4A6E7DA1A4ED51553B099C@ukr.net>
From: =?windows-1251?B?0MXKy8DMwC0yMDIw?= <sent-group@ukr.net>
To: <linux-nvdimm@lists.01.org>
Subject: =?windows-1251?B?xOv/IMLgIDUwJSDx6ujk6uAhISE=?=
Date: Wed, 1 Jan 2020 20:36:00 +0200
MIME-Version: 1.0
X-Antivirus: Avast (VPS 191231-0, 31.12.2019), Outbound message
X-Antivirus-Status: Clean
Sender: add4@s239617.savps.ru
Message-ID-Hash: JMNYRV26SPQTKZKLQEDUCSQJXKKZM2CC
X-Message-ID-Hash: JMNYRV26SPQTKZKLQEDUCSQJXKKZM2CC
X-MailFrom: add4@s239617.savps.ru
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
Content-Type: text/plain; charset="windows-1251"
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JMNYRV26SPQTKZKLQEDUCSQJXKKZM2CC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: base64

x+Tw4OLx8uLz6fLlIQ0KDQrRIO3g8fLz7+ji+OXsLCDN7uL77CwgMjAyMCDj7uTu7CEhIQ0KDQrM
+yDn4O3o7ODl7PH/IPDl6uvg7O7pIOIg6O3y5fDt5fLlLCDgIOjs5e3t7iDl7ODp6yDw4PHx++vq
4OzoLCDl8evoIMLg7CD98u4g6O3y5fDl8e3uIC0g7uHw4Png6fLl8fwhDQoNCs/l8OL77CA1LfLo
IOrr6OXt8uDsIOIgMjAyMCDj7uTzIPHq6OTq4CA1MCUhDQoNCi0tLQ0KDQrRIPPi4Obl7ejl7A0K
DQru8uTl6yDw5err4Oz7IMLr4OTo7OjwIMLo6vLu8O7i6PcNCg0K8uXrOiArMzgwNjgtNjgwLTQ2
NTINCg0KbWFpbDogaW5mb2dyb3VwcEBiaWdtaXIubmV0DQoNCnNreXBlOiBvcmctcmVlc3RyDQpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRp
bW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJzY3Jp
YmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
