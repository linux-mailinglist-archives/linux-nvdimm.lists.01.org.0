Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2167A114DBD
	for <lists+linux-nvdimm@lfdr.de>; Fri,  6 Dec 2019 09:47:23 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C58AE1011350E;
	Fri,  6 Dec 2019 00:50:43 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2001:41d0:602:dbe::8; helo=tartarus.angband.pl; envelope-from=kilobyte@angband.pl; receiver=<UNKNOWN> 
Received: from tartarus.angband.pl (tartarus.angband.pl [IPv6:2001:41d0:602:dbe::8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 384821011331A
	for <linux-nvdimm@lists.01.org>; Fri,  6 Dec 2019 00:50:40 -0800 (PST)
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.92)
	(envelope-from <kilobyte@angband.pl>)
	id 1id9Ge-000645-8W
	for linux-nvdimm@lists.01.org; Fri, 06 Dec 2019 09:47:16 +0100
Date: Fri, 6 Dec 2019 09:47:16 +0100
From: Adam Borowski <kilobyte@angband.pl>
To: linux-nvdimm@lists.01.org
Subject: ndctl's Ubuntu MIR submission
Message-ID: <20191206084716.GA22949@angband.pl>
MIME-Version: 1.0
Content-Disposition: inline
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Message-ID-Hash: BF6D2TH7EHMRV3WRCBNLCLVJIXP6XQPW
X-Message-ID-Hash: BF6D2TH7EHMRV3WRCBNLCLVJIXP6XQPW
X-MailFrom: kilobyte@angband.pl
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BF6D2TH7EHMRV3WRCBNLCLVJIXP6XQPW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkhDQpVYnVudHUgZm9sa3MgYXJlIHdvcmtpbmcgb24gcHJvbW90aW5nIG5kY3RsIChhbmQgb3Ro
ZXIgYml0cykgZnJvbSB1bml2ZXJzZQ0KKGllLCB3aXRob3V0IHN1cHBvcnQpIHRvIG1haW4gKG9m
ZmljaWFsIHN1cHBvcnQgZnJvbSBDYW5vbmljYWwpOg0KDQogICAgaHR0cHM6Ly9idWdzLmxhdW5j
aHBhZC5uZXQvdWJ1bnR1Lytzb3VyY2UvbmRjdGwvK2J1Zy8xODUzNTA2DQoNCllvdSBtYXkgd2lz
aCB0byB0YWtlIGEgbG9vayBhdCB0aGUgaW5jbHVzaW9uIGJ1Zy4NCg0KDQrhm5fhm5bhm5/hmrkN
Ci0tIA0K4qKA4qO04qC+4qC74qK24qOm4qCAIEEgTUFQMDcgKERlYWQgU2ltcGxlKSByYXNwYmVy
cnkgdGluY3R1cmUgcmVjaXBlOiAwLjVsIDk1JSBhbGNvaG9sLA0K4qO+4qCB4qKg4qCS4qCA4qO/
4qGBIDFrZyByYXNwYmVycmllcywgMC40a2cgc3VnYXI7IHB1dCBpbnRvIGEgYmlnIGphciBmb3Ig
MSBtb250aC4NCuKiv+KhhOKgmOKgt+KgmuKgi+KggCBGaWx0ZXIgb3V0IGFuZCB0aHJvdyBhd2F5
IHRoZSBmcnVpdHMgKGNhbiBkdW1wIHRoZW0gaW50byBhIGNha2UsDQrioIjioLPio4TioIDioIDi
oIDioIAgZXRjKSwgbGV0IHRoZSBkcmluayBhZ2UgYXQgbGVhc3QgMy02IG1vbnRocy4KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1h
aWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNl
bmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
