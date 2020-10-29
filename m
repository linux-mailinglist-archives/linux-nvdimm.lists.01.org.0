Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E57FB29F6BB
	for <lists+linux-nvdimm@lfdr.de>; Thu, 29 Oct 2020 22:20:05 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D7CA015ECFAED;
	Thu, 29 Oct 2020 14:20:03 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=160.16.213.36; helo=uclxwexy.xyz; envelope-from=admin@uclxwexy.xyz; receiver=<UNKNOWN> 
Received: from uclxwexy.xyz (tk2-248-33782.vs.sakura.ne.jp [160.16.213.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C73B315ECFAEB
	for <linux-nvdimm@lists.01.org>; Thu, 29 Oct 2020 14:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=default; d=uclxwexy.xyz;
 h=Message-ID:From:To:Subject:Date:MIME-Version:Content-Type;
 i=admin@uclxwexy.xyz;
 bh=aK9PZd6GBZZ5VT3oj8eVglqgsipf7D72W3M4RomjB6Q=;
 b=1/oXGMZbfXyu9+l+UzEqGySTjY2vN04RW6b0YyjHrMEW5mFNkjNm+bijs+7H3rCG+MYs6KH6/ouS
   4ra12DQzq+xI02lNuQa8MQ7e8u7qu42KIvbG7X8SGITWI0nxWjzbaxjHlEntkTSNJYsbbu/TiVIf
   YVU/BXI0GG1JPjYHcbk=
Message-ID: <20201030051956486874@uclxwexy.xyz>
From: "Amazon.co.jp" <admin@uclxwexy.xyz>
To: <linux-nvdimm@lists.01.org>
Subject: =?iso-2022-jp?B?QW1hem9uLmNvLmpwIBskQiUiJSslJiVzJUg9ak0tGyhC?=
	=?iso-2022-jp?B?GyRCOCIkTj5aTEAhSkw+QTAhIiQ9JE5CPjhEP00+cEpzIUskTjNORycbKEI=?=
Date: Fri, 30 Oct 2020 05:19:50 +0800
MIME-Version: 1.0
Message-ID-Hash: NK4CWCONO2II6JIFTFLJW34YIWVU3X6J
X-Message-ID-Hash: NK4CWCONO2II6JIFTFLJW34YIWVU3X6J
X-MailFrom: admin@uclxwexy.xyz
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NK4CWCONO2II6JIFTFLJW34YIWVU3X6J/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit


 
Amazon お客様
Amazonチームはあなたのアカウントの状態が異常であることを発見しました。バインディングされたカードが期限が切れていたり、システムのアップグレードによるアドレス情報が間違っていたりして、あなたのアカウント情報を更新できませんでした。
リアルタイム サポートをご利用ください
お客様の Amazon アカウントは 24 時間 365 日対応のサポートの対象となっておりますので、Amazon サポートチームにご連絡いただければ、アカウントの所有権の証明をお手伝いします。
お客様の Amazon アカウント
アカウント所有権の証明をご自身で行う場合は、Amazon 管理コンソールにログインし、所定の手順でお手続きください。アカウント所有権の証明についてのヘルプセンター記事も併せてご参照ください。
状態: 
異常は更新待ちです
所有権の証明



数日以内アカウント所有権をご証明いただかなかった場合、Amazonアカウントは自動的に削除されますのでご注意ください。
今後ともよろしくお願い申し上げます。
Amazon チーム
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
