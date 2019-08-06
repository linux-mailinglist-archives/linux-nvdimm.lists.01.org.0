Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 814AF82A0E
	for <lists+linux-nvdimm@lfdr.de>; Tue,  6 Aug 2019 05:36:14 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7E8432130D7FC;
	Mon,  5 Aug 2019 20:38:43 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=62.76.41.90; helo=mail.zbtc.info; envelope-from=info@zbtc.info;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail.zbtc.info (zbtc.info [62.76.41.90])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 25B3A21306CEC
 for <linux-nvdimm@lists.01.org>; Mon,  5 Aug 2019 20:38:41 -0700 (PDT)
Message-ID: <8a470ea251a882811d18ae02edb993b066b6c5@zbtc.info>
From: "Hope" <info@zbtc.info>
To: <linux-nvdimm@lists.01.org>
Subject: The second half of
Date: Tue, 6 Aug 2019 06:36:00 +0300
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; d=zbtc.info; s=mail;
 c=relaxed/relaxed; t=1565062560;
 h=message-id:from:to:subject:date:mime-version:list-unsubscribe;
 bh=feAPdsW21l0hpkdghktW6WP4tL9pHFcfagRj8Nob0KA=;
 b=YFDtEhPuCYs+yHTUFKThTJq81EFl4NX//sxJhXV2XJVocz/EI64k2DpYqM+/Pk
 5aJTzO7B+SM3SIaQmtYn27oBZ+AN1nbIv18XmStjZ3FAKYNZlXoRMc0yDX5pj1n6
 jwWFnDzz9QYRxeV79YluoLiYhUjwXSdtiBhymIMvKGI0E=
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

WW91IGdvdCA1MCBuZXcgbWVzc2FnZXMgYXQgTGFkYURhdGUuCgpIb3BlLCAyMwoKRGVhciBncmFk
aWwhISBoZWxsbyEgSSBvZnRlbiBhc2sgbXlzZWxmIHRoZSBxdWVzdGlvbiAtd2hhdCBpcyBoYXBw
aW5lc3M/IEhhcHBpbmVzcyBmb3IgbWUgaXMgdG8gYmUgbG92ZWQgYW5kIGhlYWx0aHkuIFdoYXQg
ZG8gaSBsaWtlIG1vc3QgaW4gdGhlIHdvcmxkPyBJIGxpa2UgdG8gc2VlIHRoZSBzdW4gcmlzaW5n
IGluIHRoZSBtb3JuaW5nIGFuZCBnaXZpbmcgbWUgYSBob3BlIGZvciB0aGUgZGEgLi4uCgpSZWFk
IG1lc3NhZ2UKClRoaXMgbWVzc2FnZSBjb250YWluIGxpbmsgdG8geW91ciBwZXJzb25hbCBwYWdl
IG9uIExhZGFEYXRlLgoKSGF2ZSBhIG5pY2UgZGF5LApMYWRhRGF0ZSBUZWFtCgpJZiB5b3Ugd291
bGQgbGlrZSB0byByZWNpZXZlIG5ldyBtZXNzYWdlIG5vdGlmeSBwbGVhc2UgYWRkwqBpbmZvQHpi
dGMuaW5mbyB0byB5b3VyIGNvbnRhY3QgbGlzdC4KClRvIExpc3QtdW5zdWJzY3JpYmUgY2xpY2sg
aGVyZS4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGlu
dXgtbnZkaW1tIG1haWxpbmcgbGlzdApMaW51eC1udmRpbW1AbGlzdHMuMDEub3JnCmh0dHBzOi8v
bGlzdHMuMDEub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZkaW1tCg==
