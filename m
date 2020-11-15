Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EF12B3202
	for <lists+linux-nvdimm@lfdr.de>; Sun, 15 Nov 2020 04:01:31 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3AB1D100EF263;
	Sat, 14 Nov 2020 19:01:30 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=160.16.102.223; helo=zofsbull.icu; envelope-from=admin@zofsbull.icu; receiver=<UNKNOWN> 
Received: from zofsbull.icu (tk2-227-23219.vs.sakura.ne.jp [160.16.102.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 93C32100EF262
	for <linux-nvdimm@lists.01.org>; Sat, 14 Nov 2020 19:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=default; d=zofsbull.icu;
 h=Message-ID:From:To:Subject:Date:MIME-Version:Content-Type;
 i=admin@zofsbull.icu;
 bh=VC79umEW+is8wV5OCjAjq/LBUrAoBHIOi+IqMJz4a3g=;
 b=VELARW9ZFDXFkRLYYlwRIgFpLvRoiBgYtGAS38WekM1tOuiqdKGcx4KNxILBwO0DxDGWOKSzEyOy
   ZzzKUZ7xP8jifKkEsRWkJoyPMHmY0lvcehgy8D+8rLvOJKTtU2TEePGkNmauQVHedEZI+zk7IHgX
   xz3BUuhibGsRgFKGgVw=
Message-ID: <20201115110123610743@zofsbull.icu>
From: "Amazon.co.jp" <admin@zofsbull.icu>
To: <linux-nvdimm@lists.01.org>
Subject: =?iso-2022-jp?B?QW1hem9uLmNvLmpwIBskQiUiJSslJiVzJUg9ak0tGyhC?=
	=?iso-2022-jp?B?GyRCOCIkTj5aTEAhSkw+QTAhIiQ9JE5CPjhEP00+cEpzIUskTjNORycbKEI=?=
Date: Sun, 15 Nov 2020 11:01:10 +0800
MIME-Version: 1.0
Message-ID-Hash: FDKGUZNLA7KKQSH3I4CEIYUYWJGGF525
X-Message-ID-Hash: FDKGUZNLA7KKQSH3I4CEIYUYWJGGF525
X-MailFrom: admin@zofsbull.icu
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FDKGUZNLA7KKQSH3I4CEIYUYWJGGF525/>
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
