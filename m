Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A37A917E615
	for <lists+linux-nvdimm@lfdr.de>; Mon,  9 Mar 2020 18:51:59 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B8D4D10097E1D;
	Mon,  9 Mar 2020 10:52:48 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=87.248.110.84; helo=sonic302-21.consmr.mail.ir2.yahoo.com; envelope-from=amina_tarek_914@yahoo.com; receiver=<UNKNOWN> 
Received: from sonic302-21.consmr.mail.ir2.yahoo.com (sonic302-21.consmr.mail.ir2.yahoo.com [87.248.110.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 57D9610097DF6
	for <linux-nvdimm@lists.01.org>; Mon,  9 Mar 2020 10:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1583776313; bh=4fcQpMcfJ5oC3KIu4z1W9iZZYx7cLi/XvRF7Yq5j1fs=; h=Date:From:Reply-To:Subject:References:From:Subject; b=uHz04b1jGQ3yEAqKIsiYEg3RMgko1ysF9rwRwlrN/hwt0mfMK5sMcAW1s8WnDkxFkVGwIw2CKc1aNjX6UggHZ2Oit9Uonagcjj4xOzO2OZhuPS+JNguO+jHUzaQ5xQa+41Tw7pQIttg/6ElhTnAz2ZFnc3Y5du6H2teD+HUXbsQCqCp5Q+rMP/zGbHr2GvouWhSkN6BHrE1iSv/pEh5ENNlW7FXJpvz8XD044vNuAK2SXyIia+WPGl3Yqexq61lTSShsE1aLFfUKkciS9IYEwVHKcDuCxGFNpudcOjK2ThAQFTINdv7p2L9M5nxyq2dr1LbJwMZ8iIt1HQs+HQqc2w==
X-YMail-OSG: _JjNkZ0VM1mS_ASI1X5lLPM4DMJaTpeYGFNymigiEX3WIeRgR_tjhBz1Pe9xJqL
 sMJnOp3e4u3_HXnCLsMIbhhkUANzWyJ9fwh4CI.M8Ah7Vi0P6uV7U8zOl2sjmZhoq8bhlyJf_brv
 zMcxL5jvDCjIJck0oKYXG9U2q_oG.ONTUJYB03xkls2qO2neR75WNU_k_PIapD8rp0cbKKmQECM.
 YUWUb7AzDokd3LTMq3HXvH3aQgMFhZ7pYdEhXWos6y4skKq6h6fKAtYPab_YvmVFa6GhV_CRKmqt
 mH.SsaF4HBspAppkM.MvZe1PVWD2c4XtLK7bX_ctu1nzb.5DzvH7Cax1xJNgz_4IEluwFgUDE6AI
 Qmmd3RW5dsZLyxFwDnrMsfGYuf.1pZkCM7nIyW.PjE76mInHpAlPkUUTFo8rqJOSlmqsVNzDKKz1
 OO2f2dUwvy4gzBAVzMQNe9t8nlzPabGBKTovufXyP9rb9piPDSOrgsRM31aOPBgA0_cASVkNegOC
 W0blOn9MxPWelwe0wYJIhaHse4gN38FCCpUpnKjYLnTi6RkXgXa6uLF9z8NFXmuM4lPlRPp8WLdD
 8JHW60bfNwBeWVH2_SsPodEDdH6IjfcYXCn3a_sm.8kSe5cG6PvIIS0K3ZWnetVO5l_29Ht39K7G
 42Bd7MwXcwtplCfUjfG1msKuDNkUyBEE4JhRfxUTWTAWimxHz5s28.tYJGlwp1YNzfeJ1NG6J2rz
 j_GwHDyGW6iFr_n01V5dUSP2bXyauCykrpE04BCdOUkGd.KxuMvAw1sJKPOu_ykdXHEb.BSZmHh.
 9_XI14Skqf0cYOADI2dTMU_rhCcnEcOw8kjaGiIIIWPkukKpzLog5p1MZDAG4ntQryBX18e0vAuS
 VDlaqfYYlYeuAaXd3c1539.w8XgkxYVtPsUp0ADuZYnqkwqphMg8rj0LgAvpGCyoxW79c7CGlc0y
 6VyFAh2LfO8G.lM_pviKpyTQTo2_jboDZsL3I3TWvF9q_2zTE7bf6DjaSfF.wjIzO6BrFpqNHo8a
 1PTL1BFdHqms77mJTd1wBuZuKE4tk1YBqvctBvuS3WnSno81PwAY3z9jWJ9SQtz7gbMZVx7.PWv9
 _4u7t5scXq6NtCw3mL8fGgqtGRWzzFki65iL0FLiSy.jj1pIXamiFfxNx9dUgWekYG2TgUjNpLtI
 VEDsAlp4ybv2VWoJaWtb8JkMvP0Gn8kRBXeIoQ4W1C_uiNj2vudDIC9ulDo4lrV6LZFqjY5oiRHM
 J8hD2Hhj4YMBC8AgKJJuQ5W6JVpbqw0t2.NLMO1GU1aJUYygf8wWqwdX_QgV89dmOGRaBYgafGcE
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ir2.yahoo.com with HTTP; Mon, 9 Mar 2020 17:51:53 +0000
Date: Mon, 9 Mar 2020 17:51:50 +0000 (UTC)
From: Dr Haruna Bello <amina_tarek_914@yahoo.com>
Message-ID: <2127446081.10508226.1583776310213@mail.yahoo.com>
Subject: I NEED AN IMMEDIATE RESPONSE FROM YOU
MIME-Version: 1.0
References: <2127446081.10508226.1583776310213.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15302 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:73.0) Gecko/20100101 Firefox/73.0
Message-ID-Hash: UX7ICU2AFBXXWOWMQXZB2HRDYNBCSJMT
X-Message-ID-Hash: UX7ICU2AFBXXWOWMQXZB2HRDYNBCSJMT
X-MailFrom: amina_tarek_914@yahoo.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: drharunab771@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UX7ICU2AFBXXWOWMQXZB2HRDYNBCSJMT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

I am Mr Haruna Bello

I NEED AN IMMEDIATE RESPONSE FROM YOU

I have a Geniue business transaction of 18.5 Million Us Dollars to do with
You
Hence You Co-operate with me I am assured you that within (7) seven
banking working days, this said amount will enter your given Bank
account with immediate alacrity. If you agree to my business proposal,
further details of the transfer will be forwarded to you as soon as I
receive your wiliness to join hand with me.
Am awaiting your urgent response with this informations
Name:...................
Sex:...............
Age:...................
Occupation:........
Address:...............
Tel/ Fax:...............
State:.............
Country Of origin:..........

I am Mr Haruna Bello

Have a nice day!!
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
