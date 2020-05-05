Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DAA1C54E9
	for <lists+linux-nvdimm@lfdr.de>; Tue,  5 May 2020 13:58:23 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7E905111C7C70;
	Tue,  5 May 2020 04:56:37 -0700 (PDT)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=77.238.176.98; helo=sonic301-21.consmr.mail.ir2.yahoo.com; envelope-from=aishag688888@gmail.com; receiver=<UNKNOWN> 
Received: from sonic301-21.consmr.mail.ir2.yahoo.com (sonic301-21.consmr.mail.ir2.yahoo.com [77.238.176.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D419C111B0D8C
	for <linux-nvdimm@lists.01.org>; Tue,  5 May 2020 04:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1588679896; bh=EsAwSD3thQFeGHmZWWDtvYOSPbA1GhfmuPFdT9AE3kE=; h=Date:From:Reply-To:Subject:References:From:Subject; b=s8bWPWodqfvk7MQ5+vTRVhSxgAk2bdKdeL/OmMN4MU1sDp+fDTWZxqA6vXETxUk+cM8iUcLLNSau8pSG8jCRGgJXOyOdXOhtxkhr1/IrrrFxRiG1VtLPYlArr2YVoYWqp4J4vE99CDp54diqQanGn7crYhON2Q9xB2hNFRiJbAJDDri5dB0NmzLAaIHpKCtg4spRLQn/Kx8jTAtaXEgzk2YFprUSrkIoLdYRA8AiQoC65aw82Qy5q5yiO51e35Fx2sHS0NdJqH6SGRKtubS+f8SPp2nItBr8jpCpxayxe1hynfofLRy/vuEpY71LC6BnEw08hKA3xJwdGapwhpiG+g==
X-YMail-OSG: 6ELjgZMVM1ng9nOE3KE.39gPhqPd9CfrsashQySNpmDCdW3m4LjbVauaugc6pSK
 7OpqDpMSpPH5iTfpOKx6F2UhJcYUtSsRG.mEGPL5ZnMKCfoh7ZgFiBDAwPm9X3ce1rfa5I33abVN
 cAFWUNu1tI8v2ZuGb6bZ6BQM3.yvhv3HE6bpKKc6s5QQ_G0xm9TpGe7gKcAm0Otv0iTT8T8ZhVQF
 vt13Ulo7pcpWqpklvixKPeJdxW6WC11JyX9llCrTbv7LMK0c2xFBHOIlQ95eo894Or8lHrD175jH
 5bhUgEeLwCRtxs8mKuYa7Z0Ji7vSDDZz6Qb5zt5oSc.n_YRJ4SKRHTQUvHPoA8_jdZO8VoDksWYs
 PhnbCn6znCAaoZy62xT461lgBOOE60KJOJgvJ5U4hRl_eaqFmsLAW50S0_lgh3vnA0yKfJTucsAp
 NFMxDA3gvKFB.FOeu5N5.3pt3NKj5IPwU8KjFv4IdclUPQYQiFDSD.auTG2WsARIfRtbT192oTLt
 O5srTXkQxlfmCvi80kaHpToQ30fDkRhv5oHrJ36kmsvCvbeF6koMVci2EWczVBSGiQJ47PMHUR.V
 URoftivIkm2ATtNGhMf9sJWNwSFsSG7gXiCV4w6YbaRUf0576i6XKubcvgVI_cZLyhpZasu.JeI_
 78wgbCJ.1t6NQZaeiATbbRIxA9Zfl4dvQ6d2SwIvheicqnUZBYYelzUV2un_OmZwczA8iMP9CtUS
 .YjPUr7ftvCmfgg3xloKCv_gjijj5nWhSLer9CIAqpPPF3XoBakrw8PxiX64jgpwq0mFZKD16yZw
 6S99or5TK6tDVcYDC0ob1wt85T7.Gfg_wxz7Mg7HsUjioyekYAjpNc4AzVZflzHd4k4learzA_6o
 _RT3UKtnBDpxnPCW0pXo6AK6B.2xc2xp0gAu4fnRpPgQuV1x_wGqqfmwzDZ67sy51UIDbbAF9mVH
 bn6gwr57l4w7CNtKrOcLFYoCCC2KtInIN3QiiXYncg_L5bIz3MNLX9JW5g8Pj8Qwsr6OrUpIQoFT
 E0nTinX7k_CkjYGrKmMrKR4eThTIjA5Q416CLYk06W2SU6teHFxZIhN5eYj4DYX42KAv.WpcqDIH
 ljFgXkgOo39B_.1mCtJcw.v8QT3yPFjOX2Znw5MbROu87wEbNnylPjMCwGO6tf_Jnojhb0uVmx1F
 4N7hxuvMYpTYrgzoLmyfXmS_D_NnrR8CBald2QQnXACpWgcqYIcn7sa8Zycu_xkoZN0CO..b3eQz
 XJvfyP1IwDrGTQ4W44zh8TrI8O5CZ4h6hz_SvgUqWGhcR_wN9XOqW3oEIJ2OhT5TlMIr5uGN4JRJ
 au3owceSEPXNV4BS66sz4
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ir2.yahoo.com with HTTP; Tue, 5 May 2020 11:58:16 +0000
Date: Tue, 5 May 2020 11:58:12 +0000 (UTC)
From: Aisha Gaddafi <aishag688888@gmail.com>
Message-ID: <1596782075.3026892.1588679892496@mail.yahoo.com>
Subject: Dear Friend,
MIME-Version: 1.0
References: <1596782075.3026892.1588679892496.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15756 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:47.0) Gecko/20100101 Firefox/47.0
Message-ID-Hash: HSFXWW4O2CODJW6QQMHXAVLFQBXUTWCI
X-Message-ID-Hash: HSFXWW4O2CODJW6QQMHXAVLFQBXUTWCI
X-MailFrom: aishag688888@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: aishag6p777@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HSFXWW4O2CODJW6QQMHXAVLFQBXUTWCI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear Friend,

I came across your e-mail contact prior a private search while in need of 
your assistance. My name is Aisha  Gaddafi a single Mother and a Widow with 
three Children. I am the only biological Daughter of late Libyan President 
(Late Colonel Muammar Gaddafi).

I have investment funds worth Twenty Seven Million Five Hundred Thousand 
United State Dollar ($27.500.000.00 ) and i need a trusted investment 
Manager/Partner because of my current refugee status, however, I am 
interested in you for investment project assistance in your country, may be 
from there, we can build business relationship in the nearest future.

I am willing to negotiate investment/business profit sharing ratio with you 
base on the future investment earning profits.

If you are willing to handle this project on my behalf kindly reply urgent 
to enable me provide you more information about the investment funds.

Your Urgent Reply Will Be appreciated and all email should be at the email below;

Best Regards
Mrs Aisha Gaddafi
(aishag6p777@gmail.com)
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
