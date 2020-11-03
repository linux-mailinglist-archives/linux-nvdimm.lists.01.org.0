Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D268B2A3F96
	for <lists+linux-nvdimm@lfdr.de>; Tue,  3 Nov 2020 10:04:47 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0DC3F16544F78;
	Tue,  3 Nov 2020 01:04:46 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=160.16.205.14; helo=pnipfbeuc.icu; envelope-from=admin@pnipfbeuc.icu; receiver=<UNKNOWN> 
Received: from pnipfbeuc.icu (tk2-244-31760.vs.sakura.ne.jp [160.16.205.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3FCC91637BC4F
	for <linux-nvdimm@lists.01.org>; Tue,  3 Nov 2020 01:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=default; d=pnipfbeuc.icu;
 h=Message-ID:From:To:Subject:Date:MIME-Version:Content-Type;
 i=admin@pnipfbeuc.icu;
 bh=cRV1X1SQZvYGgKw4rz0+MYDmEiDDV2X5HV586qUJ0Xo=;
 b=YMbaVzZF0dm5vFLzDnDWjaafx+2DlxDLhlaxbXLKFgWHMmdZ5NzbeGpbbwDUO20SN1VoMlcsCuX5
   7ML4vMvTdT2vSvU9QTH3gBKXkZ9czXGQvlKckJrGQidVubgLzVmZ3ndiPShGNwvD6XtdfFIE4CFq
   bQ3qcqt0m1MBlAOhg7M=
Message-ID: <20201103170442604654@pnipfbeuc.icu>
From: "Amazon.co.jp" <admin@pnipfbeuc.icu>
To: <linux-nvdimm@lists.01.org>
Subject: =?iso-2022-jp?B?QW1hem9uLmNvLmpwIBskQiUiJSslJiVzJUg9ak0tGyhC?=
	=?iso-2022-jp?B?GyRCOCIkTj5aTEAhSkw+QTAhIiQ9JE5CPjhEP00+cEpzIUskTjNORycbKEI=?=
Date: Tue, 3 Nov 2020 17:04:33 +0800
MIME-Version: 1.0
Message-ID-Hash: HHHEWP2CXBJ5BOWDE52J6DNKLLI4KHZK
X-Message-ID-Hash: HHHEWP2CXBJ5BOWDE52J6DNKLLI4KHZK
X-MailFrom: admin@pnipfbeuc.icu
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HHHEWP2CXBJ5BOWDE52J6DNKLLI4KHZK/>
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
