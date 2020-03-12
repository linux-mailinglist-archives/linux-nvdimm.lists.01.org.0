Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A24A182F1D
	for <lists+linux-nvdimm@lfdr.de>; Thu, 12 Mar 2020 12:27:27 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 733A710FC3764;
	Thu, 12 Mar 2020 04:28:16 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=98.137.65.30; helo=sonic315-54.consmr.mail.gq1.yahoo.com; envelope-from=aomrisa@yahoo.com; receiver=<UNKNOWN> 
Received: from sonic315-54.consmr.mail.gq1.yahoo.com (sonic315-54.consmr.mail.gq1.yahoo.com [98.137.65.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A41D910FC36E4
	for <linux-nvdimm@lists.01.org>; Thu, 12 Mar 2020 04:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1584012443; bh=8xpm+cacAfAnFCbwSdgMceaBJxowNWaFZvEVU/zxgKw=; h=Date:From:Reply-To:Subject:References:From:Subject; b=UXCgo0FdMxeK2bzuT12XomAwub4ZqiOn8pMOgGczJ+MaOWKh7Zcmyn+80/QWn+HOOVvo0YWs0+WurBg98h/i0sMDKlHTaZTU1VWBt6oWI2cjDLQ1iLmNztD5d3/pGhCYS/ZW6AVI5re9DiiAOUr526jOrUcVkIWWjKHvOtLNuR8gbpJl2Pz45DtGS/NYuVvqq4CsQ5MOA1U3PYD0oHkHDhXDadHelWqJkcQMc+blzJkVyEXCfzYkmgnuW9gT7F9VYCGr9oNj+IpCuvP02R+JYGZnFV2TbJ+QFZcWRO2oV/ibT5MwhMq/tBjskr/Yvzbm9bLrfNhx/MpWTO38vxDT5A==
X-YMail-OSG: WBB_.2YVM1kIz_K1X_szcIrBNo7CUJKj3r5xNbLSqXZlyXjYBRoMbsfSpqdJe01
 Ly.gASDhtsp._EOXYow5Yzxp1djK8398oG0uM1Cepl.u28EqvgiXAymmWGKGqxL95FzeXhvj5I7a
 IPfvB_FkxG1z0w8vPm46d6GhxxlvTlvQ2D3xnHZbOPfbxtNPJ0asopbIW77PRyp2ar9dWaOsBv0E
 xe.oVmssdef9pIUgjsx_hNUd_xiW_ivgfTbDoXmNARAKGU2tY09uwqARTeI5gRs7nbyrvjcs6kEv
 YX61WgMLZY7w.DM1JgTmPsfornnMm1pmPSkbkZygn.0OrjKkeeEkb_IWE341R43HVN7MsCa78PWI
 tNIpsUWDLMabKAy5r6O5ravhmXSU9D7YB4ZCk6mOlc9tVqhYV3hPjoeF4u1bcIRGDP3a2365IDBO
 2iPMegnaHLB_HWaCTZfXkGvdJGeOfIkI3uW69UzJ6Ptc96w5qX_oiQ.mYKx22S9wzaFUTpUJijVh
 7XFUIhbw.pHBzCNOJOWRKgUtdvMTDJsqNOLXwx1wE5vlH19rZFzUI_TWTbgLI4uQZwdPMmkDt2z8
 SzGSc8my5pVWIl0NjSvN1rIugaT9aJdoetrVbrkW8ukpkQrzIurwCB0ZDGQteNHkx5s38OHhLXpB
 UKRRFsVSS0wTvpcztGY9lOUeEm0MQISUTBUawqF3xKWWpUbQT4CWWh1_84UfQTZkE9lHD4IZkXcE
 U2NsFzWB22vjF3CLSpVFVfWr8.wOIJogHNbXCcUUEFiCF.qyw69Mp3aOliv6mRqwTmc9Ln6PoLrP
 XsWXmXJ7pRiQIY0KZ3X2jhamvXHs2vguZXtCB.2GqjSChwGvRvo2jsAaEi8ZiFAv_fk4HYOp90FT
 2dObuokw9TmMM5Sdv5QV7nUbTboCXrWkBPSL9Y4OJg3PdjJ9iLv08sUX5keg8f0Qd1LVe_CYAX7m
 hGLA2rZQGeKyiOoqcDKTzuYhE3WRhwI8sDg3pfy5sageZJkMZYPZ8Dgp1qehkjVU79g9WffihIr3
 PsrOo09kJCnuQKV6bqzdNAN6K5FchbJjQb2YBKWs6Wtw_KECYKbw8v.2pDitM55l8V4kdZW6_03L
 Hwxy.7rYYdvnGj61GKDr4rNIYwttoWquQv5jkk6ITSbpc0uwGd.AJ2n.9TZjxz1Xqqa5QEQrHiQo
 3k21lZ9aeaMM8HgZgWuttT5Il9oxqIJtQg3MYdDC3oOe7lUQcF9TddPPy6ecMWNU7Pk.3DjkIp1G
 UKrOyGjamkybBsSd8glOhJyNtQFvo5iqmlazwu5ER8MhcdvjGvB18.pi7uPVof1HvMiU-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.gq1.yahoo.com with HTTP; Thu, 12 Mar 2020 11:27:23 +0000
Date: Thu, 12 Mar 2020 11:27:21 +0000 (UTC)
From: Ttiti Roseline <aomrisa@yahoo.com>
Message-ID: <1768237896.4338480.1584012441136@mail.yahoo.com>
Subject: My Dear
MIME-Version: 1.0
References: <1768237896.4338480.1584012441136.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15342 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:73.0) Gecko/20100101 Firefox/73.0
Message-ID-Hash: PM3E2U7K4LEI7GQ7VXOKKUCPA72EQYWS
X-Message-ID-Hash: PM3E2U7K4LEI7GQ7VXOKKUCPA72EQYWS
X-MailFrom: aomrisa@yahoo.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: cheriftiti268@yahoo.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PM3E2U7K4LEI7GQ7VXOKKUCPA72EQYWS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

 My Dear

I am Miss cherif Titi,20 years old and the only daughter of my late parents Dr.Richard Tit. My father was a highly reputable real estate developer who operated in the capital city of Ivory coast during his days

It is sad to say that he passed away mysteriously in UK during one of his business trips abroad year 12th. JUNE 12, 2014. Though his sudden death, But God knows the truth! My mother died when I was just 4 years old,and since then my father took me so special Before his death on JUNE 12, 2014 he called his secretary who accompanied him to the hospital and told him that he has the sum of Nine million,five hundred thousand United State Dollars.(USD$9.500,000) left in bank

He further told him that he deposited the money in my name, and finally issued a written instruction to his lawyer whom he said is in possession of all the necessary legal documents to this fund

I am just 20 years old and a university undergraduate and really don't know what to do. Now I want an account overseas where I can transfer this funds. This is because I have suffered a lot of set backs as a result of incessant political crisis here in Ivory coast. The death of my father actually brought sorrow to my life

Dear, I am in a sincere desire of your humble assistance in this regards,Your suggestions and ideas will be highly regarded.


Now permit me to ask these few questions:

1. Can you honestly help me as your daughter

2. Can I completely trust you

3. What percentage of the total amount in question will be good for you after the money is in your account

Please contact me with my private email cheriftiti268@yahoo.com


Please,Consider this and get back to me as soon as possible.


My sincere regards,
Mrs.cherif TITI
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
