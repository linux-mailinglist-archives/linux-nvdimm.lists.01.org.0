Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 046C4CCBC2
	for <lists+linux-nvdimm@lfdr.de>; Sat,  5 Oct 2019 19:45:45 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AF1CD1011344E;
	Sat,  5 Oct 2019 10:48:35 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=87.248.110.31; helo=sonic307-54.consmr.mail.ir2.yahoo.com; envelope-from=jpmorganchasebank.ny13@yahoo.com; receiver=<UNKNOWN> 
Received: from sonic307-54.consmr.mail.ir2.yahoo.com (sonic307-54.consmr.mail.ir2.yahoo.com [87.248.110.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A05921011344C
	for <linux-nvdimm@lists.01.org>; Sat,  5 Oct 2019 10:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1570297537; bh=EE/TQ1hKDPvej/sSUj8etfyy6efGFy8mQqgJL+ozwaw=; h=Date:From:Subject:From:Subject; b=GxF1iNEIbaA4dVG7fyKRu6A0SpnNcckaxbB4AL6z1JgYlSonpDBIAnpg7rYaETPqlE7+iq/ForO8aA5if23KZgIRX+gB2qIpP9jW5FK7icoueuzz6LIT+ifVYiCUzHwB4HxuzXBZpHXwqCTzlJP14oocCZnehYfNZ9+XQkLhTvh9y7HRbARCw02DPlbivZ7rhwTxdSTVJ0Kqu6CqcRynJnhNTKBBkSjF0Vcu+eFl52i0X5xMn47DX0U0IDxwe9ZZutRzHZptbJfZdinNu0OSBgsp2ML2Lfeykw4lD8N2cy5AMVtm5xI+ibtsVYpZI0H3NGzyuR3/3uvtJGvqhjS+Xw==
X-YMail-OSG: vbQ5TX8VM1nkmpNJpE.SVxgxwvyBNw3zIl3X785oC2Kibqq21YNyr47RKUBUP6D
 rokeHo_z06xdU3TunBksECF152SZjNgnsInJUYo2Hsfh_.Y1uH6ICz9VYMWyrS09AS6_rmwS1zgm
 cTGeTdExAdMm8UurUx9vkRV6PhkSfNxgS8oANs8W9xQnbqsf0x3KUCA9CIukimoU.GwguSvQVynM
 Vv5onSPKEbX70MAdL4AB.kOESc_KtQR2.AQ56Iq76pLBil.an9WGEoi5STqt6L3JxPurq1wmb1cE
 tgtYYmBCK0_E607MTwFjcZjEufsN82yXZBI1A.DldTH0s8fYBv_yvwdWnqKtIdoqMtFoaV8dbTbp
 .JKZZKF1SLV1w1FwRm8CnAT9Xn3WwftPzbamSMt0Eat2pg5ZFNgw8V1R91GdBcTpIjE.f6rarS07
 O2l9u2S2t3mPBKf.im5ZKSlNEVtirt2yFGkDw2prRTTp1UgQ7ARzyK4iDbCjAka0BU39oVxmcvsb
 R7.9B9sEyO9QEdbio3dTejaj.f5Wmfr072k67tSF8CRSdIoZgR6EzTf4qy6G6N6h5zxA.ytkL2m0
 rxlkinHhr91TbNTthhFH1YQzC20D_iFHEnIAtSdVtp.DP.22pQ1NQbgMf3wZZ7V55.pfiYPqoIcI
 mqjoBc7IiufCz8p7TMSRyuVf66woa6zh798PAlGSVD.OP6dzG.L4AJw1WHx.4yWrz7c1eE7LgFI4
 F6XttPTOUPW5.eLJP9O.P8Ez76JPApj2YMq6oAjjkrukf4mCphS2e5Oqej7pw0TGm_cnQ7XQTzu9
 epqMtiZ7cpz9Cb52bbEe_QhThwjNTZ8Z7eMHsegjSwGzVei5N6RmiOYz31LHlODx1Rah8MJmL6qg
 xAtRth7FD9_QtHPQNW9SnbRC3GdxaJrcPyswJJn9Nez0qatZk2tv7SjRZl1AGCNk0GW9GBfTSs0O
 ECT1s5fIq.W7pLaJnRYDw_Wl6uBbOJULnKK8SYIDZDnRw8def25eICowJ.4vHyvk4Jwa8QflZsHI
 YGGt.7PRwzaBkxRfC2fg81Zaz3PjSCdOdAlf7g8Gq8tO4TXf.DKNO7e5f1LITFh3VkQNKjomnQas
 fUakjtOL3evLnDefB7gtIKSdPpuHi7hcTnFuZHzZ3OKGS5rj53qRWxXhd8A_8wtfj2Tx7fubMDB8
 4xa34Vxe60wgnaWyHBaD1NMLDj7WiCEtmWppevXEPe_q33meo0QqcrZMwWEde7znBH8DWa9YAQxa
 NzwO_8ztfn0VFOYTWGYf4gfMwnRTOmpvJRhhds7XnIOtkKHE2GhQIZIIIfu5IoRiXKJOnuy_Od_b
 AsmqXCOk-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ir2.yahoo.com with HTTP; Sat, 5 Oct 2019 17:45:37 +0000
Date: Sat, 5 Oct 2019 17:45:35 +0000 (UTC)
From: jpmorganchasebank.ny13@yahoo.com
Message-ID: <679597762.5751901.1570297535564@mail.yahoo.com>
Subject: Happy to inform you, CONTACT WALMART TRANSFER To pick up $8000.00
 sent to you this morning.
MIME-Version: 1.0
Message-ID-Hash: M6ZD5LEZAP3CEBAUBZOX7OWGEIDLQRRG
X-Message-ID-Hash: M6ZD5LEZAP3CEBAUBZOX7OWGEIDLQRRG
X-MailFrom: jpmorganchasebank.ny13@yahoo.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/M6ZD5LEZAP3CEBAUBZOX7OWGEIDLQRRG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Attn Dear Beneficiary.
Happy to inform you, CONTACT WALMART TRANSFER To pick up $8000.00 sent to you this morning.

I have deposited your payment funds $2.500,000MillionUS Dollars
With Walmart international money transfers.
Receive the Money with Walmart | MoneyGram service.
Walmart partners with MoneyGram to allow customers
easily receive money transfers abroad,
Contact Walmart international money transfers office -Benin
Receive your approval payment funds $10.500,000MillionUS Dollars
HERE IS WALMART CONTACT INFORMATIONS.
Contact person. Mrs. Mary Anderson,Dir. Walmart transfers-Benin
Email: walmart.b100263@gmail.com
Telephone. +229 68823234
Text Her on this international phone line. (256) 284-4886 

Ask Mrs. Mary Anderson,Dir. Walmart transfers-Benin to send the transfer
as i instructed.
we agreed to keep sending the transfer to you $8000.00 daily.
Until you received your total payment $10.500,000 from the office
Once again,
make sure you contact Mrs. Mary Anderson,Dir. Walmart transfers-Benin
today including your infos.
(1) Your  Full Name==============
(2) house address=============
(3) Your Phone Numbers=============
Urgent to receive your transfer now without any further delay.
Finally, Send your first payment transfer fees to Walmart office on below address
Receiver's Name====== ALAN UDE
Country=====BENIN
City=======COTONOU
AMOUNT =====$58.00 only. Your first payment $8000.00 transfer fee.
Question======God
Answer=========Creator
Thanks
DR.Mike Benz
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
