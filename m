Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FF02BAAC8
	for <lists+linux-nvdimm@lfdr.de>; Fri, 20 Nov 2020 14:05:30 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CB119100EF277;
	Fri, 20 Nov 2020 05:05:28 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=51.83.174.126; helo=edm1.clientprospectsts.info; envelope-from=oia-linux+2dnvdimm=lists.01.org@skptywceo.biz; receiver=<UNKNOWN> 
Received: from edm1.clientprospectsts.info (ip126.ip-51-83-174.eu [51.83.174.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 57BDF100EF277
	for <linux-nvdimm@lists.01.org>; Fri, 20 Nov 2020 05:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=default; d=skptywceo.biz;
 h=To:Subject:Message-ID:Date:From:Reply-To:MIME-Version:List-Unsubscribe:Content-Type:Content-Transfer-Encoding; i=olivia@skptywceo.biz;
 bh=1MqwnEueacp20Z6jg90vP7i91Bc=;
 b=bN2BXv04i1XP7B4uXbmNNugXB/Pe00jIg7sST5bFkxTgiZ6+7QunDiQs25msZYUGOy4/9gBOs32e
   sccWYWHsV2XolEPQXasjhMxCK2w9vl/rXd80w4ohofslAapp0KqCnbU9xkctsqtenhxmv5Fyzjpf
   D5PdjB5cqIIoXId6Z6M06KfoH0aDwY4PpQCpzc69sJGfkIgOSz2HmAKY7SY7NXopMUugxRbFLHDH
   Hs7Z+1Tzx5cz85LJKSLwXPHiwjSCFd3Ta91VTUm/Lsc12UgWx2UIuQ5qE/fCAn9GBWkmh/Bxf0Km
   Ig84Xr7H7bG1sj+wnWziSXfljvj2Zz6XbNnsLA==
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=default; d=skptywceo.biz;
 b=EdFpnuBpAggBvU9jyXzcXbPvBn4unjwKmxEymsAnF+f86ob/ptviPXOw+PcrexOP7zqmvPiQ8q9G
   ZyQJxilCbDBGu0UCCFcgP8psJrM+hOA1ZDqiy0y5aEH8J5M00YPKs4VVeuEBP+ZzTiBeeC+CaTs4
   nzSBP4KfUiPncN6VUpWUYWtEY2L8LmEzEdyUgsS0JL61ZkQjYQ/PL46Jmjl9KuUtgnMFCNIeqXp3
   hhmWnZalaR4n88p+J16la1w/cm0O429rYhQe9WbUw6A5U2xHSaxvO+4sTM9hIxb/C7m2N7op+B0E
   TXguiUdURRWMicnkl29WtW1c5Wh6oi3ZwIcg1Q==;
Received: from clientprospectsts.info (127.0.0.1) by edm1.clientprospectsts.info id hmuvhdi19tk9 for <linux-nvdimm@lists.01.org>; Fri, 20 Nov 2020 13:05:23 +0000 (envelope-from <oia-linux+2Dnvdimm=lists.01.org@skptywceo.biz>)
To: linux-nvdimm@lists.01.org
Subject: RE: 100K Leads at 250
Message-ID: <7091f0693ee260498e7628a65c7e3cde@clientprospectsts.info>
Date: Fri, 20 Nov 2020 07:37:25 +0000
From: "Olivia Hernandez" <olivia@skptywceo.biz>
MIME-Version: 1.0
X-Mailer-LID: 2
X-Mailer-RecptId: 1194392
X-Mailer-SID: 16
X-Mailer-Sent-By: 1
Message-ID-Hash: FYUECMUWW6N4LSGAPK2DYY4DLYYVKMN4
X-Message-ID-Hash: FYUECMUWW6N4LSGAPK2DYY4DLYYVKMN4
X-MailFrom: oia-linux+2Dnvdimm=lists.01.org@skptywceo.biz
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: olivia@skptywceo.biz
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FYUECMUWW6N4LSGAPK2DYY4DLYYVKMN4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; format="flowed"; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Your email client cannot read this email.
To view it online, please go here:
http://clientprospectsts.info/davemailer/display.php?M=1194392&C=7qfj5uhazzszx89bzmxux8xt2ufky4xe&S=16&L=2&N=2


To stop receiving these
emails:http://clientprospectsts.info/davemailer/unsubscribe.php?M=1194392&C=7qfj5uhazzszx89bzmxux8xt2ufky4xe&L=2&N=16
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
