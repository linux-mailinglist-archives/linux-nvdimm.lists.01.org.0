Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF0E1E92D7
	for <lists+linux-nvdimm@lfdr.de>; Sat, 30 May 2020 19:23:24 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4F76A100F227F;
	Sat, 30 May 2020 10:18:50 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=74.6.129.81; helo=sonic317-26.consmr.mail.bf2.yahoo.com; envelope-from=bill.aileen0240@yahoo.com; receiver=<UNKNOWN> 
Received: from sonic317-26.consmr.mail.bf2.yahoo.com (sonic317-26.consmr.mail.bf2.yahoo.com [74.6.129.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3020B100F2278
	for <linux-nvdimm@lists.01.org>; Sat, 30 May 2020 10:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1590859398; bh=3B2ZGTE6bSlrmugEjELcdwv13J2n9evHYlPN/PkW9n0=; h=Date:From:Reply-To:Subject:References:From:Subject; b=DWvH5p7vrDodX99y5MewcQX4I0whobauGe2CrDU/emycHWc/uTJTH6TaKFctpkK2nI6yJrcR2C1OcFtRfiPeFo8Rh0M6fR6+bOZrnj0K7/vffKb35mhjezba7Rm6+pPmSOVIvNjBPknUTndu7KpkmbRKW5XUdM/ft5ZkaWM1SOpyfKiEkR4dLov/jI5XzqqsvlCbiKj8RFW4mHfvzVcwAu3sfuf+HxU3v/aEaLsS8svc4RTaHCoO1frnTrm901x2H5K3aJk9GAa8d4CmWCyET6YtJu11VJFaW4+Bx0RWFkBsAnCx0AJQLV4xIG6f/QbmiuNIgn4pjh7cXXZIryk7gw==
X-YMail-OSG: S4tD__UVM1nXVsel7m7rrFr3OIj.TjaU65RY2UZn6iAAF94m7WhFVXy1W4mZsxw
 PIspgls23akY16Vm51bvXGI.D6pgxE6fVSNLX89uFivuHgn6V4qdkaxaCVSoF7UvtMUXhKJRCLxD
 AaWHYnSXJDpEvhBHDZcqM6mW8kAghvZGtCM2pI9SuQAO1nJEd1rr7JPwRZJScSHkozggVU5EFM2A
 nyk8llGi83yr5y4Ub1k2ynzmY5x6.Bv76eEvTrMK9AbSKESwwPsiMRXFvwHeMmuzVBHy7adRQ6QG
 wemEs.YANifuqoErwgRQ_kPKrunVk4MXzGCi23lqAPTWJAE1qJPWKhT6vTbQIHyaBZmgs_dZq0C9
 KIR36BeXpGlIA1j8nFeVAFOgtRUzlb_5Fzo9k0UktSieqhAFTmp1EO5Znj5l4Kycj4SoXXTD52un
 s4qogMiX_G_YrcHel.Ih0YiPg67k89wGRmIDD5dsToNlJEXNmq5xy5tUCH3QotB4lo7Tkrh.LlTH
 jUIaJ2Izd4nE7pjSUIqwdobgj70xY88.a6WqTYoa2weMZza1ZNWk.TsR2euGyFOoF1FbVy0dWebP
 8tpxDx4yJYzE4qW8XJMNkTgEExHkQDMDUv83tujqoLnIRqV3socc8I8wowZKS0CLejTQq2276vOi
 m4Bp279lJk3ZRpR_KcHtg5lP7Lp44tvU2x08zvvPCRkL_O3ImB3ml.Hvx4Pt8OYh9YqcSHZ2U18B
 leGtNwV6wGOdrnZ.fHyySb5d5JtHY.CGORrkJk57M7_.oUT6J3xKhTOb7y6TF6h3Yy3UqpDt9iql
 94NDN8kEdXVnzl9kDcTwNFf43Qgvv_Al_n7hY4KA7xdEvT1q2mvsgERIX6cN..pChK6FbtPj4KaY
 fJ0ZU_AAaidG6_fbk4nEWN2xtf159y6qqX0oPn6qecNVSyPb0u6j7DhvxhE2hXZqdDgJ_f8yX.WZ
 0s3I160Pp9rZeEh4nRPrOAJ7Kp3sqUvjl2A51ucqlqQruhoiWZC21YI8t7PNdke6ePIyEaFE0VrQ
 IWR1a5SWCh3IabGz4xunjR1yOS0cndxUqaBcKYqGvDKfNsroChC4HRhYHQYmqWdaj2EReHEIwKuC
 DQChVyjGgSAKHIs.XSyKzfXu6wFGsRbElHk8mR6sTfFKM7559JQDBq9vw09fuiNRIIHwuw5im8Uv
 hamsCeTL_LbQT6ZCiKJcToaO7Azma1yfZ2FUNdpCjBkg3xT1xhWDqkbTZPoqosX6ceUMeMcprrRI
 nHymWwMniwD03ib9xW9MLaFr.HecRbQIj8z2kYlcuFnQ9gvGEXCkP5_AxRVfRwOCeXV0AxQaQuw-
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Sat, 30 May 2020 17:23:18 +0000
Date: Sat, 30 May 2020 17:23:13 +0000 (UTC)
From: Aileen Billanes <bill.aileen0240@yahoo.com>
Message-ID: <677312667.138521.1590859393506@mail.yahoo.com>
Subject: From Mrs.Aileen Billanes
MIME-Version: 1.0
References: <677312667.138521.1590859393506.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16037 YMailNodin Mozilla/5.0 (Windows NT 6.1; ) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.61 Safari/537.36
Message-ID-Hash: AYANIC74JAFH7T3RLHWTVOUO354KC2CW
X-Message-ID-Hash: AYANIC74JAFH7T3RLHWTVOUO354KC2CW
X-MailFrom: bill.aileen0240@yahoo.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: billanesaleen93@yahoo.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/AYANIC74JAFH7T3RLHWTVOUO354KC2CW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dearest One,

Compliment of the Season,Pardon me for Contacting You Through this media. But please I am in Desperate Need of your assistance: My Name is Mrs.AILEEN BILLANES the wife of Mr.Eleaza Billanes Mayor of Rizal in Yatagan Province. Who Was recently in the Philippine Killed by Gunmen on JUNE 12TH 2018. Well Threat During the late husband on my life , He gave me the total sum of U.S.($8.5USD Eight Million Five Hundred Thousand Us Dollars) this money is deposited with a firm in ABROAD in a metallic box .

Then deposit it in a security and finance company abroad just in case anything ever Happen to him . I did deposit the total sum as He gave it to me under a secret arrangement as a family valuable. This Means That the security company does Not Know the content of this metallic box.Since the death of my late husband , the Philippine state government has blocked me and my late husband accounts Through the help of my late husband family. Also my late husband brothers succeeded in Collecting Have All Our properties from me That is under my control and They Are Still looking for more.Therefore I am Contacting you to help me secure the sum Which I Explain to you above , for the future of my kids.

Since my late husband family made it impossible for me to move out of my late husband in Philippine house Please do tell me if I can trust you as Who Will Not sit on this money When You Claim it. I am willing to Give you 20% of the total sum in box After That You Have successfully secured it. Reasons for safety so That I can come over to meet you there in your country for you to help me invest the money in a good business i will like to hear from you so that i will Immediately know if i can trust you with all my heart and if you are capable so that i Can send you my pictures and my international passport and all the documents so That You Will Better Understand and I will wait your message

Best Regards
Mrs.Aileen Billanes
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
