Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A563B2C3F59
	for <lists+linux-nvdimm@lfdr.de>; Wed, 25 Nov 2020 12:54:02 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E5F65100EF27E;
	Wed, 25 Nov 2020 03:54:00 -0800 (PST)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=51.83.188.198; helo=edm7.clientprospectsts.info; envelope-from=am-linux+2dnvdimm=lists.01.org@gmail.com; receiver=<UNKNOWN> 
Received: from edm7.clientprospectsts.info (ip198.ip-51-83-188.eu [51.83.188.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 184D1100EF27D
	for <linux-nvdimm@lists.01.org>; Wed, 25 Nov 2020 03:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=default; d=gmail.com;
 h=To:Subject:Message-ID:Date:From:Reply-To:MIME-Version:List-Unsubscribe:Content-Type:Content-Transfer-Encoding; i=rachelgriffinmail@gmail.com;
 bh=hZ5PNaY39G3EuaAPhmLlubCTXWM=;
 b=EusOTMR8b0827O3ZaGKRRh8pOW2ov8GY1NF3KIIsGJgiP4FrBsjvmc/da5Y1Zktl9oX3k6vWhoh5
   Kzpe5hr6yAV9n6SMX6sdB4wYHYauJJ7ZxYGalsdvr/UbDxE4i1oE3jm6N7678aSXdVxKN+jVPkTd
   xmQEVWklS9+HnQTmPg/6w7N5KKAp4Y3uZKuqQbGHyLfH30rt1b9eJomJjvH2NoKZDisjHzwFkcYn
   jzJ289zUNUiO3LxQNlwln+J10PaBf7BGGicv0nsRMKtT+l+rUWL8OBUEVOyWo93IAGh+sRiWJzfc
   6UpV3sNZA9sKuWijm//ByUyyifVM8XRkQFkyUA==
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=default; d=gmail.com;
 b=KBbRqmfrXZhnNWyitHNwINx3iqJMz7EEvu+iMW7cslsJd+4tixIRzgoqNi7YQkEhV8JTHreUia56
   Lvb1kOnteesjezz39mGZzpM/yHwzaYsOK4OF+D0tME0ImLqctTK5eRpAOsLfIxRkxN+I/t3orxPs
   7TUkok3EfTBzOM5Pw/KLfU+Ad8Yt/drifD/OE/WWlRSa+RDia4PW2OpcYUl4HLAq5XOz2ug+ZQl5
   aN7OLjy3ozrivgYdRvPWGiWPqc+l1KI1ZY0h8bakRxSbHJ/KhKYPc3ZUDMBAwcdnLXH4DPtPTPMA
   jln83GYYPxg6t/AJtn7WeVmwZlvvKbD/N9B9BA==;
Received: from clientprospectsts.info (127.0.0.1) by edm1.clientprospectsts.info id hnp2tdi19tku for <linux-nvdimm@lists.01.org>; Wed, 25 Nov 2020 11:53:55 +0000 (envelope-from <am-linux+2Dnvdimm=lists.01.org@gmail.com>)
To: linux-nvdimm@lists.01.org
Subject: RE: follow up
Message-ID: <29d6b738a74d6efb6e572dce1cf1db20@clientprospectsts.info>
Date: Wed, 25 Nov 2020 11:02:11 +0000
From: "Rachel Griffin" <rachelgriffinmail@gmail.com>
MIME-Version: 1.0
X-Mailer-LID: 9,10
X-Mailer-RecptId: 7766207
X-Mailer-SID: 30
X-Mailer-Sent-By: 1
Message-ID-Hash: J6GF6WWGMUE53KETZFK3WR53XLVDK3K5
X-Message-ID-Hash: J6GF6WWGMUE53KETZFK3WR53XLVDK3K5
X-MailFrom: am-linux+2Dnvdimm=lists.01.org@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: rachelgriffinmail@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/J6GF6WWGMUE53KETZFK3WR53XLVDK3K5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; format="flowed"; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Your email client cannot read this email.
To view it online, please go here:
http://clientprospectsts.info/davemailer/display.php?M=7766207&C=dlc3dv7x6rvur3gzofp0so76ohw1crnh&S=30&L=10&N=3


To stop receiving these
emails:http://clientprospectsts.info/davemailer/unsubscribe.php?M=7766207&C=dlc3dv7x6rvur3gzofp0so76ohw1crnh&L=10&N=30
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
