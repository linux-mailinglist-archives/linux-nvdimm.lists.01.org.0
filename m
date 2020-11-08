Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 113362AA9C2
	for <lists+linux-nvdimm@lfdr.de>; Sun,  8 Nov 2020 07:04:41 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0738E161A7F6B;
	Sat,  7 Nov 2020 22:04:39 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=133.125.49.213; helo=zykxlxgc.icu; envelope-from=admin@zykxlxgc.icu; receiver=<UNKNOWN> 
Received: from zykxlxgc.icu (ik1-442-53459.vs.sakura.ne.jp [133.125.49.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 901A2161A7F69
	for <linux-nvdimm@lists.01.org>; Sat,  7 Nov 2020 22:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=default; d=zykxlxgc.icu;
 h=Message-ID:From:To:Subject:Date:MIME-Version:Content-Type;
 i=admin@zykxlxgc.icu;
 bh=a4VXox1Co5AqyBZhqb2ayWKyF7oDjeKuC7e0TrN9Ufo=;
 b=YAb6AciUwBv/L/Tudq3LlDTKg0/tA87CBh4jFoFJbJxmJeJgkSUi+w1GZYA5LCsiLcp9jLZLhOHx
   0jEKUoyl6tyDdvSqYRWiiqm9PBpqt5PFIKE2365XQXsx1O3VQosfuMrriNlNjuPvGaq4rB+RV7LP
   xONBtWw71tBartk9L08=
Message-ID: <20201108140433615865@zykxlxgc.icu>
From: "Amazon.co.jp" <admin@zykxlxgc.icu>
To: <linux-nvdimm@lists.01.org>
Subject: =?iso-2022-jp?B?QW1hem9uLmNvLmpwIBskQiUiJSslJiVzJUg9ak0tGyhC?=
	=?iso-2022-jp?B?GyRCOCIkTj5aTEAhSkw+QTAhIiQ9JE5CPjhEP00+cEpzIUskTjNORycbKEI=?=
Date: Sun, 8 Nov 2020 14:04:28 +0800
MIME-Version: 1.0
Message-ID-Hash: QUH4Y3RLFPMQQZSTXCZL4QINLODJNHH7
X-Message-ID-Hash: QUH4Y3RLFPMQQZSTXCZL4QINLODJNHH7
X-MailFrom: admin@zykxlxgc.icu
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QUH4Y3RLFPMQQZSTXCZL4QINLODJNHH7/>
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
