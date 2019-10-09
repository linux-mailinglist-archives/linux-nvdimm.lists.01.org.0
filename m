Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE977D0700
	for <lists+linux-nvdimm@lfdr.de>; Wed,  9 Oct 2019 08:03:53 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0EE4110FC6C95;
	Tue,  8 Oct 2019 23:06:18 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=66.163.186.146; helo=sonic302-20.consmr.mail.ne1.yahoo.com; envelope-from=houssamohamed80@yahoo.com; receiver=<UNKNOWN> 
Received: from sonic302-20.consmr.mail.ne1.yahoo.com (sonic302-20.consmr.mail.ne1.yahoo.com [66.163.186.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4A6DE10FC6C94
	for <linux-nvdimm@lists.01.org>; Tue,  8 Oct 2019 23:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1570601028; bh=Tc7pOpmlam4lI1R93iNOm8mkdVOnqewjoNE7tkbSLgQ=; h=Date:From:Reply-To:Subject:References:From:Subject; b=e8SvCeSK7KG6WKq52kI88QcFsbC7+Eyd6nkr5UzhvQJhfZ6KGlzhoKgpWHStHMEKJ1oYhsZzJq5pGby3Ig5Zz1qx2Eyu6XioQHce0FaNbwBfKcbs9qD+tlJMNP8LQUsaPBV7F9J6SYm1J01YG2oCQM1fdaZ6UrjcvlD91mdvWyn021ueClVMPGE5ZDco6sBd4Gxp/8+FFnmv1psHSG/KBOzjpbyzYn1XGrDUEVRnAf4R/FZIs0fUc0pj639mRQlzlj+V9sRcn7Cr9wr+Ep2cYDCtKPg3ze7HmP8/1ppy+/6oGvDocXqhvF7NdVt1L8SV5+RiHaSr3oOqywSbu4Ikhw==
X-YMail-OSG: ptTOZXAVM1nBjmdqZ.BNXxAGtxlUV4hkPV3yuzEEZi8w3OzA0EkTyf6aewEWasn
 oeAggD2Z0ByyuZhzComRWrY1cEqrs_.j.zGWs_n.EvpDgZ.UJZsIhpszFNURAwFq4tL3WgOuN4XU
 NaUheG7sP08DGHwn92ZmlECy.b_VCbHNbSPZ3z56GKXX52xSsP_rTa56TesRPvq9APwIG07SFN07
 _IUWK4OBrX8Lk40x8kUa22iAgaPxamI9kSCDqAnLUxTGP4ZRKYgpXbNePLJxHB0fSC_amXMXpSWF
 iZgO3Hl22SQge.6QazxzdED8oSQs_2I4f7ggzCHrBS1Ldw6iEK7SPGS5PXx3ou9mGEGin2Aw0a9N
 vfy7oQkrPaPzuVfdZBjaq1ZbjH0fB4nViaEr3W8CofSK1Xs7e8u3zFsaLPcxrsCTjWbF872t64G6
 syawYgLfJerlJI34OPpD9546C9cubzJwo37EqSEslquDX8s9PC5QNMLelu99Ghe01Fk83OB0DcFb
 YfkWon2D6QK5KMI5Y5KXZn6UYzyx6iMijpFN_J4fE1OYFwCH_wb5kEQBJuDWKKnDt296lqy0rVYU
 daa8OwJCIWk3KhltlIJxIax3IKIQL1Fx_m01B1xbUthKmm3k1znjf5u_Y8eFYxHIk5zCoPlSisPw
 Hl6ajeCxLVfMXbrtuDHQJ2WIf.LMNvTYi4h0GDWSk9zz9J0FWRg51KK3AmwldqdZs8Xs3TRwEDn7
 cg5RQLVCyiNmDwBaW0e9D5FxoYMHifLLIaa3Dp4gvMdkUcAu8MiH1zcwE3RYPGsC4L_LKOiCuPgC
 ARk2HK9gVuatDZmYzRuMenJyg9grDWfywPWm3qfmwwITv2O0HZOAD4mZCemsI8lTz_pjrIbJ08QD
 L8ZAyjdTAe3IyzyvQWOZ36DEDVCyT1iUlT11Dmi1aeLaSWw7Lqsi.eDRitAR1FmQPc4RLyaTEHHv
 kd1CM.6ZBDsCnbuaP5.mkbZcmfkyMby_MDpt8p7EglpE4MmaOFS2v5CIdPiY6vd2DaUsGdF9KHs_
 V79vGmn4ZMXboiQIYob9UzDIgEgKYbQ6_SRYC.Tm6C0Z1PUl8i9tak9WzQyr.qUlb213a_ZvUwcp
 dPzeK6NZT_krSxpZFXNzsLzGY9SPMG7avn1B_ZIx91qaWoijqDchOWcd_l7pOx8Yk9rb.w6Ypzno
 pHXJIiUeouX6dNVdN2_h6EJYxD81lDVJeffC6xa.qGIaC3sP.yosHxPKzErqLWiS7fLtM3b_cB5z
 UvpUsgI3VrJqvC4RW9KEWLUtqNeAao1.H7CV0VICcpzD5NeOLcg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Wed, 9 Oct 2019 06:03:48 +0000
Date: Wed, 9 Oct 2019 06:03:47 +0000 (UTC)
From: houssa mohamed <houssamohamed80@yahoo.com>
Message-ID: <1877074481.5714163.1570601027428@mail.yahoo.com>
Subject: Mr. Houssa Mohamed
MIME-Version: 1.0
References: <1877074481.5714163.1570601027428.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.14448 YMailNorrin Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36
Message-ID-Hash: TLSHD2JY5NVD7MT5QW46SZB6ROGJHMAZ
X-Message-ID-Hash: TLSHD2JY5NVD7MT5QW46SZB6ROGJHMAZ
X-MailFrom: houssamohamed80@yahoo.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: houssa mohamed <houssamohamed790@gmail.com>
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TLSHD2JY5NVD7MT5QW46SZB6ROGJHMAZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



From the Desk of Houssa Mohamed
(BOA)Bank of Africa.
Read and Reply to my Pravite Email( houssamohamed790@gmail.com )

Dear friend,
I am Mr. Houssa Mohamed, The head of file department of Bank of Africa
(BOA) Here in Burkina Faso / Ouagadougou. In my department we discover
an abandoned sum of (US$11.million US DOLLARS) (Eleven million US
DOLLARS) in an account that belongs to one of our foreign customer who
died in a plane crash along with his family. Since 1996.i Want you to
come and stand as next of kin to achieve this fund since you are a
foreigner my bank will be convince and approve the fund to you. Write
me here (houssamohamed790@gmail.com ) while I will deals you more whenever
I receive your respond to my offer. Call my private mobile line which
is +226 67 11 27 67

i wait to hear from you sooner to enable us process the transfer to
your account.
Thanks and God bless you,
Best regards,
Mr. Houssa Mohamed
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
