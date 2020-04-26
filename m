Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E89B1B93F5
	for <lists+linux-nvdimm@lfdr.de>; Sun, 26 Apr 2020 22:34:42 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3A5FA100A0268;
	Sun, 26 Apr 2020 13:33:54 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=66.163.186.148; helo=sonic302-22.consmr.mail.ne1.yahoo.com; envelope-from=stephanieleo966@yahoo.com; receiver=<UNKNOWN> 
Received: from sonic302-22.consmr.mail.ne1.yahoo.com (sonic302-22.consmr.mail.ne1.yahoo.com [66.163.186.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5894D100A3CEC
	for <linux-nvdimm@lists.01.org>; Sun, 26 Apr 2020 13:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1587933276; bh=CK8hs5QhawDF3aaQkLB8GL9CYcLbe/kQaGmJkokiQes=; h=Date:From:Reply-To:Subject:References:From:Subject; b=NhSwPiHzV72zZ8jOeWYN0/Ux3AgBLmBa5XSx4FcpTpB/EzEHhTga9reG8MbXd5kcgawl25SiU/SwKF+rIs7FHrT5j4mUkASKBkfTxjCJtlxrp5ADOmHnuMgbqdCXIRbcMYpNQjVbkD1EpnK4PA5OFxfMTwEfJNhI3LZLH0dZjEWPdLV0T2pJ3keqiTiY7dJNyaqCjz8A3Z5EvW7sfHHNmrf9htS3/cEJzdfA6k5x3asrdwswmvHJhXlynfPV9v7Kzeun73YIrxtkNHm8gCq0cZZO6Ru2hiVKhbsjybHR9aYQwyYF/BL1+/r9xYCEMg9j5ZmHYbKx15Jg+BnxarbCyQ==
X-YMail-OSG: GTrWA6IVM1kEcVHjh6bdCaN1aZ6ssPJ.F2UTi8pqFMxeKicXKGWNkoYj2gWVE94
 7DQqYIRAhdpJeJSjYlD_9qu0ZDKXBmPn.GbGm1hxePRtSx9G11LFLu9gf1u_ErFKUSmDIWRKvK1Z
 o58J6dKnh.oRd0SUJhCHIEBjX3BdDzunDIcfIsA9a1lvNc8awD7YODSHwpWyd9FV.H0tpdx7v2ni
 R3sW.ouuE0LgWrilYt.gpoUirOPkdLcmXeuJPZopDuHcl2dFSV7IKcuv7veSkH.vlB6.WbLF1Dx1
 tFAk2X7muXgBOKuJ9rE9FgW423S_BR6DQXSay_EYAJpL_6QXOVeKK5xzqVzvP7aZsIG18foi37ro
 aJmXWHksKiPzl6EFerk38GAyMUxcVQXXOXibVm7uY3YCH8v2n7G1c41S2jZXonAOhdsN3LC8T1pA
 debNdINaVARfsWR0udtg8hTnk.doRNj85bNY1LOUM.xxhMhybscwHrUTlxEsXgN0VOktGMenO48Q
 XEPSr2i7benE1p.MN9yKZjnIy6niNshlFhsy6pkID6jBDNhIqRvo.i1kjnDA4V0aJHptF0RwFbP7
 F.MZMj8XZmSNo1DeZac1BM9FodiZeh7iQFrkLuMJRItYzGQS7jJyOK5TwhtppdvPCfXuk5QQo3Vk
 z3DkXlTnpat6bpInSNSIAqHSUSxhGXv1QBgF81ubN3Th3HWEWSbfv1kvaQJAwrQ3o87Umw_j7y.2
 xsnrO4x5HZn_nZNGTV9XMB89j.xS8ZmXc8RJcsj99fkhc9lPzc7eUUdzrSZ23kfZ_Pvlhnc0.oM_
 pBF.VMhsONDSRykmVf0HbYMmuQirfkNgoC5Wq0TObXU8Ul_PlD91G_tElKeZHohIMjAYUUn6.pLn
 9anunsDpN3QiaHGPrQTW97PcBVC_3yB8scK4YPVacSB8gcZxo7kwYu4xekd7lUFGJ1k5T6_ki4hZ
 _y6hqx8RKeplFbEJhe7TCrTMBdCkLTYM7aeFyGulHCTnfj.ld6FZvKFMrvxMqTkVX4WaRm9X7JtM
 bf9qAjGgOFa9gjo9DIEbKu08ND4elvPv8UIiez2nrw5bZiwTlANcRWdWUWQebNgJ7yd8osoubb6g
 aii_0GkxL4CLwFdd2rdybGTfa2Rk6W1sgr716_9wgGJDoPjzUpMlzX27xI1qIkfo.QzYjrVMKRSY
 bBE4l_MbyPYVOk4oYXi21uR3ziiZJwcwW.5ZDSFm_4OAjfXvx5lAM4jWUR4Yl.u3WiqAE515RRye
 aEIAGd1HEZQ4svnwy0RF9nhQp6QRCT4LvFEv3hW51fB9sjPucfQGtIheMNvJJLlmXcaAO8Q--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Sun, 26 Apr 2020 20:34:36 +0000
Date: Sun, 26 Apr 2020 20:34:34 +0000 (UTC)
From: Stephanie Leo <stephanieleo966@yahoo.com>
Message-ID: <1031019431.601021.1587933274363@mail.yahoo.com>
Subject: From Stephanie
MIME-Version: 1.0
References: <1031019431.601021.1587933274363.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15756 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:75.0) Gecko/20100101 Firefox/75.0
Message-ID-Hash: GZANQ4IGT4IDZ7MDOVUUPMA4VDPG36H5
X-Message-ID-Hash: GZANQ4IGT4IDZ7MDOVUUPMA4VDPG36H5
X-MailFrom: stephanieleo966@yahoo.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: stephanieleo2017@aol.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GZANQ4IGT4IDZ7MDOVUUPMA4VDPG36H5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



From Stephanie Leo!

I am writing you this message with tears and sorrow and I know this mail may come to you as a surprise, I am Stephanie Leo. The only daughter. My father was a very wealthy cocoa merchant in Abidjan Ivory Coast (Cote Ivoire) my father was poisoned to death by his business associates on one of their outings on a business trip.

My mother died when I was a baby and since then my father took me so special. Before the death of my father in a private hospital here in Abidjan he secretly called me on his bed side and told me that he has the sum of (7,500000.00) seven million five Hundred thousand US Dorella, left in fixed / suspense account in one of the international bank here in Abidjan, he used my name as his only daughter for the next of Kin in depositing of the fund. My late father instructed me to seek for a foreign partner in a country of my choice where I will transfer this money and use it for investment purpose such as real estate management or hotel management.

I am honorably seeking for your assistance in the following ways:(1) To provide a bank account in which this money would be transferred to .(2) To serve as my guardian.(3) To make arrangement for me to come over to your country to further my education.

Note: I am willing to offer you 20% of the total sum as compensation for your effort/ input after the successful transfer of this fund to your nominated bank account. Anticipating hearing from you soon.

Best regards,
Stephanie Leo
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
