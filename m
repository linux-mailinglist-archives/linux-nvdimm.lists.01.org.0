Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A67B22BC88
	for <lists+linux-nvdimm@lfdr.de>; Fri, 24 Jul 2020 05:38:18 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 319BA12540C52;
	Thu, 23 Jul 2020 20:38:16 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=104.168.215.98; helo=serve0.anprostyles.xyz; envelope-from=lr@anprostyles.xyz; receiver=<UNKNOWN> 
Received: from serve0.anprostyles.xyz (ns1.anprostyles.xyz [104.168.215.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E48A712540C31
	for <linux-nvdimm@lists.01.org>; Thu, 23 Jul 2020 20:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=default; d=anprostyles.xyz;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
 i=lr@anprostyles.xyz;
 bh=r2RQi1OXJvp752+twzflSu+Ks8ZT8NTI/LKQpTXSpWo=;
 b=LauH1871V1IxQ6NRWBklbnSSxZiWk1a9OcgpVFNELcoltSHninGfnQ90rd2DjHnxsbutITiaGUcV
   CGGeYD8kWVvVlcEHq5Zwg1ZLcWA2LgzokJuDlBEifT9nm0TFN8Q3k+zVVkZ/zV98PhsWhToPkcLZ
   EPnPdcKd5uK4ify2j3w=
From: "Jianlong Steel" <lr@anprostyles.xyz>
To: linux-nvdimm@lists.01.org
Subject: =?UTF-8?B?6ZyA6KaB6YeH5Y+W55qE6KGM5YqoIC0gUGxlYXNlIENvbmZpcm0gVGhlIFB1cmNoYXNlIE9yZGVy?=
Date: 23 Jul 2020 20:38:14 -0700
Message-ID: <20200723203814.682A860E4F795F98@anprostyles.xyz>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0012_3C79A969.441D65A8"
Message-ID-Hash: VWEP6XUZFFJKZFPHH3WGKPZUBZBAPCAK
X-Message-ID-Hash: VWEP6XUZFFJKZFPHH3WGKPZUBZBAPCAK
X-MailFrom: lr@anprostyles.xyz
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VWEP6XUZFFJKZFPHH3WGKPZUBZBAPCAK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>

This is a multi-part message in MIME format.

------=_NextPart_000_0012_3C79A969.441D65A8
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

------=_NextPart_000_0012_3C79A969.441D65A8--
