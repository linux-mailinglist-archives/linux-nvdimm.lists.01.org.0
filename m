Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B1623360D
	for <lists+linux-nvdimm@lfdr.de>; Thu, 30 Jul 2020 17:53:38 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E945512788B21;
	Thu, 30 Jul 2020 08:53:36 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=66.163.185.147; helo=sonic305-21.consmr.mail.ne1.yahoo.com; envelope-from=williams.lina265854@yahoo.com; receiver=<UNKNOWN> 
Received: from sonic305-21.consmr.mail.ne1.yahoo.com (sonic305-21.consmr.mail.ne1.yahoo.com [66.163.185.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8E48111CB2FBD
	for <linux-nvdimm@lists.01.org>; Thu, 30 Jul 2020 08:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1596124413; bh=UTdeZtwcLAAshuqRinb4IC3V1yzEDH+OJIg1EC78vr4=; h=Date:From:Reply-To:Subject:References:From:Subject; b=OnEXbnv3UZX7KrVwf2TPUF70O9M3JhB4KnWX/G3kblmSfvMSYQ6pU5oEPEEF0qaREAn7Y753Q2uhxyLnwdLiR2xqe/J7dDrsOPqmvDJfHtFJaIA+0NeqLKpm3h3evTFtnjoB2tPPCkxt5jcl/KyUjSloKZR2SqW8zMVcAlT689S9CtP1aHPFCs5PIk5+hUaKMTcsvD3QonpWIISR+YU459DwLD3josvMsifW0r8gmsGxlLbstdV1wgc10V1XZA6d88jcijny6RDc1FlfMIBwd22ur46n0QFDO5A3dM5QiQYToLH+U0C/p8ffL4reS+pMPyTN8NxdXzPMW3J8uMrNgQ==
X-YMail-OSG: qLcvEE4VM1nH5strt_t0Txhj9g5SaOmBEoy20hvFGuAMKBSmvV8G527LlbK76Ng
 k8M53sej6GfpIzCudOCz78RvXtOFIJRhDjxViNR4.oXkkh36Vy179sBf6NEAQv8gZ2g4lpNav0AW
 Sv51jY.1RGl_UHsZCCaoht._h5I.KnefYURoYIFbNoBbLzNJ.QaSWAH7WGRmsF6XDmW._4cy_foW
 .Giz7O0Xrt525B9_EVxx8wQ3z4itS_9FkvkBTdj4mj_cYEd6FAuxv8D4.O3vK6t4vQwwYD2RmT01
 rJNA4qWM8Fv.vqguSR0.Qi8xyB_QzZuguaOcrmNP9CxOQEu4XrWxfisRrupjDfMxpikkSYMPTyEq
 de0oqUYqGKmkfSYevh.auHhpw6D.e5Vv.YaaX0O5tXLXspwn0hb6KxRstE3Gnp02Kt1Da_.86HVk
 MJOaak4fE5lvmhbg9eIU4.0Sw_FujW_XZgMScUVDOPGybrUYT1OCr_7UV12EYnE.mERwCsle5phf
 j0Zbv3KaZXWnNjym89eYrRCdyDcnU.dp0S7ZNQ4Yg006s1odc67jGS0gG_Ja3Ftt5xWJdSWRbgvA
 TAt6jiCCQwR7kK4IIuw3djFdUpUjLxVdeDpcOyL8kvOKhVNAfySNiv575oFfVrksaLdv6HkKpUki
 HxCioaA.3031J1D4TH2sWxJCE.Slt2CdoA9v67Onhe7wujgdjyfPBOp.OTV68ru3Cx9TN8QfBEEA
 50jX9CmwyMbksb0NHisP2r_OC42jC5wTG6fMs9lDUQG9NgAK.vZQFOz43LiPs1YzMUReLvG3YgJu
 cvHNcqEACCfQyWQAkMZ_22PN5Z9Dki1R5n3vaYO5Hwb._e0ywxkJfBqdllmORuaFouxwmo.i.1Xd
 70gGfizaaYwhIN99qqg2mCYuu8ahE.y0O8vITpI1QPdSooFDt01P5eh1QoRKctufh_JVo7wcBCGD
 mO2fICgRmlrxZxDgEBs0xLvUCkBhOczBREPceOIvG5S._e4KzXjUwZcQAmvY0E_tTVEejP3FYYY0
 BVlK2FT4Jjeyj3bmDbRSbCdd3kANGXE7RVCiwG9kakVqbnaIRMI2H9yKYgsXyWBfxz7NSJsYFpvb
 xXysZrDd8M2dDJood7fsYGpumWk5_CRxwWeWJrDhS_7hAWsv_AQ6I2hV2rJheMtLGBDdRWUMw.b2
 gZSacfzqrllGtnJOUjeh9I8OjLrSG4dfSH1XfUkhxgVMmEFi_UQ6QGh7QyrCfYxwD4Ha5pkcPWmw
 Jhv3kFEUzmSb45L2sDJkrycz7fLRo7JGELNigRy50ruemHg4J
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Thu, 30 Jul 2020 15:53:33 +0000
Date: Thu, 30 Jul 2020 15:53:30 +0000 (UTC)
From: lina williams <williams.lina265854@yahoo.com>
Message-ID: <15968346.9560621.1596124410171@mail.yahoo.com>
Subject: MY LOVE,
MIME-Version: 1.0
References: <15968346.9560621.1596124410171.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16271 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:78.0) Gecko/20100101 Firefox/78.0
Message-ID-Hash: GTSBNZOFN5T3AJ653HY6SJYL4NZHO2DI
X-Message-ID-Hash: GTSBNZOFN5T3AJ653HY6SJYL4NZHO2DI
X-MailFrom: williams.lina265854@yahoo.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: linawilliams684@yahoo.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GTSBNZOFN5T3AJ653HY6SJYL4NZHO2DI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



MY LOVE,
My name is Lina Williams There is my email ( linawilliams684@yahoo.com
 ) I pick
interest on you. I will like to establish
with you. I will introduce myself better and send
you my picture as soon as I receive your reply.

I am looking to read from you as soon as possible.
Thanks.lL

LINA WILLIAMS
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
