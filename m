Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8E033AF93
	for <lists+linux-nvdimm@lfdr.de>; Mon, 15 Mar 2021 11:07:47 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0EE96100EC1D2;
	Mon, 15 Mar 2021 03:07:43 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=77.246.51.158; helo=ironportdmz.econet.co.zw; envelope-from=chawora@econet.co.zw; receiver=<UNKNOWN> 
Received: from ironportDMZ.econet.co.zw (smtp.econet.co.zw [77.246.51.158])
	by ml01.01.org (Postfix) with ESMTP id 48F5C100EC1CF
	for <linux-nvdimm@lists.01.org>; Mon, 15 Mar 2021 03:07:38 -0700 (PDT)
IronPort-SDR: X2mka+5EWfHSsae+F7z3UKwFDMJ4xboLXAER8DGHn9J9CWPS5BK1EpTzsZs/XAKYgf4m3/XsG1
 g4XDPrVzYollFoo6bVDig2BrE9v9292ufK9v7/bGSP3uafrrm4Jfz0O5XtbjEMOznPnuRDrq55
 3bk9C2V9K7PmqJ/71APIIRd/Wyqxemo5YiVi3T89pHT4KTXUHiMZP81loGuWygQM+G78T/BDr5
 uwc9jWbMU/TrQBzfKfu4TVGMXUh4zTcvqnHJBezunIS8p9xIvE4XW9443wLo0qpTlJyFIievXS
 l0o=
IronPort-HdrOrdr: A9a23:FjpUT6nlNFRCMHbYWs+n4/yFdkHpDfKO3DAbvn1ZSRFFG/Gwvc
 aogfgdyFvIkz4XQn4tgpStP6OHTHPa+/dOkOwsFJ2lWxTrv3btEZF64eLZsl/dMgD36+I178
 ddWodkDtmYNzZHpOLbxCX9LNo62tmA98mT9ITj5lNgVxtjZa0lzyoRMHfiLmRMSANLBYU0Gf
 Onj6ItzVfNRV0tYt2/Fj05WYH4yOHjr576fQUAQycu9Qjmt0LT1JfBDxOa0h0COgkv/Z4e9w
 H+4nfEz5Tml8uewh/Yk1bJ75JMmMbwo+EzY/Cku4wwIjXohh3AXvUGZ5Sy+BQ0pO2IzXpCqq
 i0nz4Qe/1p63XLfnykyCGdvzXd7A==
X-IronPort-AV: E=Sophos;i="5.81,249,1610402400";
   d="scan'208";a="5177446"
Received: from unknown (HELO wvale-jmb-svr-1.econetzw.local) ([192.168.101.35])
  by ironportLAN.econet.co.zw with ESMTP; 15 Mar 2021 08:35:08 +0200
Received: from MRE-MB-SVR-2.econetzw.local (192.168.64.154) by
 wvale-jmb-svr-1.econetzw.local (192.168.101.35) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Mon, 15 Mar 2021 08:34:15 +0200
Received: from mre-mb-svr-2.econetzw.local ((192.168.64.154)) by
 mre-mb-svr-2.econetzw.local ((192.168.64.154)) with ShadowRedundancy id
 15.0.1473.3; Mon, 15 Mar 2021 06:28:18 +0000
Received: from WVALE-MB-SVR-05.econetzw.local (192.168.101.173) by
 mre-mb-svr-2.econetzw.local (192.168.64.154) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3; Sat, 13 Mar 2021 20:27:48 +0200
Received: from User (165.231.148.189) by WVALE-CAS-SVR-9.econetzw.local
 (10.10.11.230) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Sat, 13 Mar 2021 20:27:59 +0200
From: "Reem E. A" <chawora@econet.co.zw>
Subject: Re:
Date: Sat, 13 Mar 2021 18:27:46 -0800
MIME-Version: 1.0
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Message-ID: <96f8ff6fe77b4507830ab5cf78a93340@WVALE-CAS-SVR-9.econetzw.local>
To: Undisclosed recipients:;
Message-ID-Hash: 6LWN4KXH5GEO7BFHWCCRX2BTRBU5GK4X
X-Message-ID-Hash: 6LWN4KXH5GEO7BFHWCCRX2BTRBU5GK4X
X-MailFrom: chawora@econet.co.zw
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: r19772744@daum.net
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6LWN4KXH5GEO7BFHWCCRX2BTRBU5GK4X/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

My name is Ms. Reem Ebrahim Al-Hashimi, I am the "Minister of state
and Petroleum" also "Minister of State for International Cooperation"
in UAE. I write to you on behalf of my other "three (2) colleagues"
who has approved me to solicit for your "partnership in claiming of
{us$47=Million}" from a Financial Home on their behalf and
for our "Mutual Benefits".

The Fund {us$47=Million} is our share from the (over-invoiced) Oil/Gas
deal with Turkish Government within 2013/2014, however, we
don't want our government to know about the fund. If this proposal
interests you, let me know, by sending me an email and I will send to
you detailed information on how this business would be successfully
transacted. Be informed that nobody knows about the secret of this
fund except us, and we know how to carry out the entire transaction.
So I am compelled to ask, that you will stand on our behalf and
receive this fund into any account that is solely controlled by you.

We will compensate you with 15% of the total amount involved as
gratification for being our partner in this transaction. Reply to:
reem.alhashimi@yandex.com

Regards,
Ms. Reem.
This mail was sent through Econet Wireless, a Global telecoms leader.

DISCLAIMER

The information in this message is confidential and is legally privileged. It is intended solely for the addressee. Access to this message by anyone else is unauthorized. If received in error please accept our apologies and notify the sender immediately. You must also delete the original message from your machine. If you are not the intended recipient, any use, disclosure, copying, distribution or action taken in reliance of it, is prohibited and may be unlawful. The information, attachments, opinions or advice contained in this email are not the views or opinions of Econet Wireless, its subsidiaries or affiliates. Econet Wireless therefore accepts no liability for claims, losses, or damages arising from the inaccuracy, incorrectness, or lack of integrity of such information.
[https://mail.econet.co.zw/OWA/auth/current/themes/resources/Agile/AgileBanner.png]
WORK ISN'T A PLACE
IT'S WHAT WE DO
________________________________





[https://mail.econet.co.zw/OWA/auth/current/themes/resources/Agile/telephone.png]




[https://mail.econet.co.zw/OWA/auth/current/themes/resources/Agile/email.png]

<mailto:>


[https://mail.econet.co.zw/OWA/auth/current/themes/resources/Agile/location.png]




[https://mail.econet.co.zw/OWA/auth/current/themes/resources/Agile/website.png]

www.econet.co.zw<https://www.econet.co.zw>


[https://mail.econet.co.zw/OWA/auth/current/themes/resources/Agile/inspired.jpg]
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
