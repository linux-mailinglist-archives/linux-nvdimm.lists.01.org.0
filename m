Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9596713DCE6
	for <lists+linux-nvdimm@lfdr.de>; Thu, 16 Jan 2020 15:04:14 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3394B10096C9B;
	Thu, 16 Jan 2020 06:07:31 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=54.240.4.2; helo=a4-2.smtp-out.eu-west-1.amazonses.com; envelope-from=0102016faeab01be-58b14a75-2440-46d9-a15a-3faad7d3b487-000000@eu-west-1.amazonses.com; receiver=<UNKNOWN> 
Received: from a4-2.smtp-out.eu-west-1.amazonses.com (a4-2.smtp-out.eu-west-1.amazonses.com [54.240.4.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1BFCF10096C97
	for <linux-nvdimm@lists.01.org>; Thu, 16 Jan 2020 06:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1579183440;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=KT9SmZTgktge7oUq/xfcR0QHxGR7P9CBHQwDi7VfbuE=;
	b=gelj/TkrmjNOuqDHcDHvxHL6G29oZq0muA8+xAR71bFA9A+RXD3hFHzMnB1DKVDM
	JwCfMcO45LzbGUi+aAuIISa7OdiHmB7hm+/XkW8OEO3YtgoNd1nOh7EducEKvhdblAN
	kN5omByhj7KBHfu5yOhjydbRDt/wlxuos9AW7YrE=
thread-index: AdXMY0+ihsu9M7kSRx+LnGnsPFMkMA==
Thread-Topic: =?gb2312?B?ob7E2sKape+pYKWvob+hvtTa1ayl76lgpa+hvyC9VfJZsruGliDX1NWspMs=?=
	=?gb2312?B?vtOkyqSspOm82qSwIKXNpcOlyKW3peelw6XXpNikzsnMxrez9sa3tPrQ0A==?=
	=?gb2312?B?pdGpYKXIpcqpYKTytPPEvLyv?=
From: <y5566jp1@gmail.com>
To: <linux-nvdimm@lists.01.org>
Subject: =?gb2312?B?ob7E2sKape+pYKWvob+hvtTa1ayl76lgpa+hvyC9VfJZsruGliDX1NWspMs=?=
	=?gb2312?B?vtOkyqSspOm82qSwIKXNpcOlyKW3peelw6XXpNikzsnMxrez9sa3tPrQ0A==?=
	=?gb2312?B?pdGpYKXIpcqpYKTytPPEvLyv?=
Date: Thu, 16 Jan 2020 14:04:00 +0000
Message-ID: <0102016faeab01be-58b14a75-2440-46d9-a15a-3faad7d3b487-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
X-Mailer: Microsoft CDO for Windows 2000
Content-Class: urn:content-classes:message
Importance: normal
Priority: normal
X-MimeOLE: Produced By Microsoft MimeOLE
X-SES-Outgoing: 2020.01.16-54.240.4.2
Feedback-ID: 1.eu-west-1.ghcekm2URM80rxYsQ8srimAAfaKSrkY5TjtvLRYnlsQ=:AmazonSES
Message-ID-Hash: YUVCRCF7HK2CDAY77RAGB6XRIJX64OUD
X-Message-ID-Hash: YUVCRCF7HK2CDAY77RAGB6XRIJX64OUD
X-MailFrom: 0102016faeab01be-58b14a75-2440-46d9-a15a-3faad7d3b487-000000@eu-west-1.amazonses.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YUVCRCF7HK2CDAY77RAGB6XRIJX64OUD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: multipart/mixed; boundary="===============5156419443226460140=="

--===============5156419443226460140==
Content-Type: text/plain
Content-Class: urn:content-classes:message
Content-Transfer-Encoding: quoted-printable

=CD=BB=C8=BB=EF=BF=BD=CA=A5=EF=BF=BD`=EF=BF=BD=EF=BF=BD=EF=BF=BD=CA=A7=EF=
=BF=BD=F1=A4=A4=A4=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=DE=A4=EF=BF=BD=EF=BF=
=BD=EF=BF=BD

=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDj=D8=9B=EF=BF=BD=EF=BF=BD=D8=9C=EF=BF=BD=
=D3=A4=F2=A4=B7=A4=C6=A4=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=CB=A4=CA=A4=EF=BF=BD=DE=A4=EF=BF=BD=EF=BF=BD=EF=BF=BD
=D8=9C=C2=B7=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=CB=B0=E9=A4=A4=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=CD=A5=C3=A5=C8=A5=EF=BF=BD=EF=BF=BD=EF=BF=BD=C3=A5=D7=A4=EF=
=BF=BD=EF=BF=BD_=EF=BF=BD=EF=BF=BD?=D8=9C=EF=BF=BD=D3=A4=EF=BF=BD=EF=BF=BD=
=D6=81=EF=BF=BD=EF=BF=BD=C3=A4=C6=A4=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=D1=A9`=EF=BF=BD=C8=A5=CA=A9`=EF=
=BF=BD=EF=BF=BD=C4=BC=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=C6=A4=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=DE=A4=EF=BF=BD=EF=BF=BD=EF=BF=BD

=EF=BF=BD=EF=BF=BD=D5=AC=EF=BF=BD=DA=84=D5=A4=CA=A4=CE=A4=C7=A1=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=CA=B7=EF=BF=BD=EF=BF=BD=CB=A5=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=C7=A4=EF=BF=BD
?=EF=BF=BD=D2=A4=CB=A4=EF=BF=BD=EF=BF=BD=CA=A4=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=C2=A4=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD
?=EF=BF=BD=EF=BF=BD=EF=BF=BDI=EF=BF=BD=C7=85=EF=BF=BD=EF=BF=BD=EB=A5=A2=EF=
=BF=BD=C3=A5=D7=A4=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD
?=EF=BF=BD=D4=B7=D6=A4=CE=A5=DA=A9`=EF=BF=BD=EF=BF=BD=EF=BF=BD=C7=BA=C3=A4=
=EF=BF=BD=EF=BF=BD=CA=95r=EF=BF=BDg=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=C2=A4=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD
?=EF=BF=BD=EF=BF=BD=EF=BF=BD=C2=A4=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDo=EF=BF=BD=CA=A4=C9=A4=
=F2=A4=B7=A4=CA=A4=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD`=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=C7=A4=EF=BF=BD=EF=BF=BD=EB=B7=BD
?=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDM=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=E3=A4=B7=EF=BF=BD=C7=B8=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EB=A4=AC=EF=BF=
=BD=DB=A4=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD
?=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=CE=A4=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BDA=EF=BF=BD=EE=A4=B7=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD

=CE=B4=EF=BF=BDU=EF=BF=BDY=EF=BF=BD=C7=A4=EF=BF=BD=EF=BF=BDZ=D3=AD=EF=BF=BD=
=C7=A4=EF=BF=BD=EF=BF=BD=EF=BF=BD
=EF=BF=BD=EF=BF=BD=EF=BF=BDD?=EF=BF=BD=EF=BF=BD=EF=BF=BD=CB=A5=EF=BF=BD=EF=
=BF=BD=CE=B7=EF=BF=BD=EF=BF=BD=CF=B4=EF=BF=BDZ=D3=AD=EF=BF=BD=C7=A4=EF=BF=
=BD=EF=BF=BD=EF=BF=BD
=C8=AB=EF=BF=BD=EF=BF=BD=EF=BF=BD=C9=A4=EF=BF=BD=EF=BF=BD=C7=A4=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BDI=EF=BF=BD=EF=BF=BD=EF=BF=BD=DC=A4=C7=A4=EF=BF=BD=
=EF=BF=BD=EF=BF=BD
=EF=BF=BD=C2=85=EF=BF=BD5=EF=BF=BD=EF=BF=BD=D2=A1=EF=BF=BD=EF=BF=BD=C7=A4=
=EF=BF=BD=EF=BF=BD=EF=BF=BD

=D4=94=EF=BF=BD=EF=BF=BD=EF=BF=BD=CF=A4=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
X=EF=BF=BD=CB=A4=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=CF=
=A4=EF=A4=BB=EF=BF=BD=C2=A4=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD
=EF=BF=BD=EF=BF=BD=EF=BF=BD=CE=A5=EF=BF=BD`=EF=BF=BD=EF=BF=BD=CB=B7=EF=BF=
=BD=EF=BF=BD=C5=A4=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=D4=94=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDB=EF=BF=BDj=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=C6=A4=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=DE=A4=EF=BF=BD=EF=BF=BD=EF=BF=BD
--===============5156419443226460140==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

--===============5156419443226460140==--
