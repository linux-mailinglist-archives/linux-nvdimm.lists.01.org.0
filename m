Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD5D1BAB0E
	for <lists+linux-nvdimm@lfdr.de>; Mon, 27 Apr 2020 19:20:04 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8D89A1009A320;
	Mon, 27 Apr 2020 10:19:10 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=74.6.128.32; helo=sonic304-9.consmr.mail.bf2.yahoo.com; envelope-from=wilsonri_richard77@yahoo.com; receiver=<UNKNOWN> 
Received: from sonic304-9.consmr.mail.bf2.yahoo.com (sonic304-9.consmr.mail.bf2.yahoo.com [74.6.128.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 73B621009A31D
	for <linux-nvdimm@lists.01.org>; Mon, 27 Apr 2020 10:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1588007998; bh=wQAZ2vw+ABSMpAJoIp2gUqC/PoAMxiKP625Y+8N3DxE=; h=Date:From:Reply-To:Subject:References:From:Subject; b=Yb228/a9getB8DGNWsc2gqEOyGocq0oxzE1d0MGR1OC9L92yyESwXI/8A9X1kEd6svaW7Hr47iv1tyE1mCaudtFHnMWrG5eWyGgnZAI7prGWi+l05FpcSr45mhS6/XmjM4YZ+L/Syf6+12II6w4JzIibs2MSbTQ6zcj1TtMIEjNR9uYOMgvDoQ1kA/wjoen7j/GLw6EyfLp6HIFD8MEtx+AGrO38iEjvBFTiwR1dFaAB9JShFtNk+jIkNk/ROXiHUQGepE3LPq7TLEyHsLgokF3a+YSTsnI+bQGfLxeF0wK/VaIj4zxtRZhGAAD6IYSzpCWoxRouFf2pTOypumvF9g==
X-YMail-OSG: cuaEI18VM1nBRJyefehW8OlQQl5ToMnjXK65Oi1WqfsudNSDX8Klbwpy0anWQ5b
 iXO5x7juSYzoI.FLAkv29O93QV7FL7uNmTvvJ2nXnLETvyJ2BRWakRE5E52Be0nTNFGroyY3bYtP
 UJ83crXfBN16oFqQ.mi864patWCWovm9LxGKWmQj4.Q54Zw658eY_SXJPbEpEg0ps6l7ASCsUo2K
 HqISva25Q2sVp9AGAcRoZeBW5JjS2iL6vFPtKaM1ra6UDLtmIXoQBODUyhSrtfRgmR2GkPciOfrA
 sVrzuwE.woLylPQJoK5ujn2.8sJdGMz6.SDTdj.Gw2vFM4Nmqk0Yz16.JB_ia_sAjypkn7pJuynI
 AvIXEl5d4Yf6QgEzF6XjiMk6Svqfh4vAxsPufUXDk7SUVrto1uEK1mrLWyzYuYff8Dj9w_qlJUEU
 pnPUNBjFlvan62kXYqdRMCQACQTt37QUOaNVL0nWWD9UZ0HjJbWy7DvzgKDcI9iVGMGDO9PD73B.
 hTE4fWdLKPxJyXD94yPJmR.xstdFWUFZNqlgnVHoJ6.m1F3lT3Awja_Ic3q_4zIh4keJJ0oZDqQ1
 bZ0vCwEgFygeRpKmG0Aqw2b7H36xMIHK1rHW1fspg6urKayAtyrqByblo6RW9OCyGBpMMEwJFS.A
 kIa77Cumd85JBuq9C_2BBe9wHukMPAxyqCeOLMyYiesbU6es2mSRUiLd.YSblve5bgIMgDJPbASY
 LFjHtJzHIQZw6EglYDCWa3QRXfEWdM8Izbt9lPy6NbdLCu9eiyW1FKNdy.Ab5lJjKgeeSrfpQWUa
 viEam_4wOC8xWT5Xsuzv_ymE52yqu86A01NVQE6MhRpIDT7aWRTOr2s2UQdWgfqKZMv0Elgr9vEG
 ESYsbq.d1iG3c5jyEi.D8e_bieXwRiBgb4aFEzVSJKpoQRx5gydyAqg5jPsaiLqP4WLNTeYlAen2
 bZY0eh7ijWS.pHZ4_6Q8qQEygYh7KZWfxdNnrDbt00xXasL10GThlYy92dGIEQgbRP4bXaJ.KlcK
 SrTYorsVRwcZ.5G_HJFLtiRVgosNbjSKK.jlgAs0yPKppT3axoykZqc8A6SP4BgBVPdCThDS3WBF
 RBDUjRTjjp9gBRPdDwGi68PEsXnt4DFD.NKk.Uh5.bxBAgnpksTm6dZZHFqz6MWiyThIErW7KmcX
 BUQeUCYHhHVjdFCgpCE.PW3TtPm5lgfxnqcOA3jRo7MpTLtUOBcdICqooGcCQ1UWLI7ydC1666lj
 bbxOHJUrYb9G6bPALBISdC6OoXRCA1QiqngCtd350wxf1VbwzFhHgHxvTPM6kkLISy4oxLbvEMXt
 0yy5W
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.bf2.yahoo.com with HTTP; Mon, 27 Apr 2020 17:19:58 +0000
Date: Mon, 27 Apr 2020 17:19:53 +0000 (UTC)
From: Richard Wilson <wilsonri_richard77@yahoo.com>
Message-ID: <1249015205.694854.1588007993266@mail.yahoo.com>
Subject: Dear
MIME-Version: 1.0
References: <1249015205.694854.1588007993266.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15756 YMailNodin Mozilla/5.0 (Windows NT 6.1) AppleWebKit/535.7 (KHTML, like Gecko) Chrome/16.0.912.77 Safari/535.7
Message-ID-Hash: MXUWFGCE5VWHZCZQEXKCW2VQQHR6Y3VF
X-Message-ID-Hash: MXUWFGCE5VWHZCZQEXKCW2VQQHR6Y3VF
X-MailFrom: wilsonri_richard77@yahoo.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: barr.kone@aol.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MXUWFGCE5VWHZCZQEXKCW2VQQHR6Y3VF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



Dear

I am contacting you to assist retrieve his huge deposit Mr. Alexander left in the bank before its get confiscated by the bank. Get back to me for more detail's

Barr's George A Levi
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
