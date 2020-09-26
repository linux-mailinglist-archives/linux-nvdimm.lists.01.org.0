Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 193FB279CEB
	for <lists+linux-nvdimm@lfdr.de>; Sun, 27 Sep 2020 01:51:04 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 989F214E7CAE1;
	Sat, 26 Sep 2020 16:51:00 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=66.163.189.147; helo=sonic314-21.consmr.mail.ne1.yahoo.com; envelope-from=anitadominic50@yahoo.com; receiver=<UNKNOWN> 
Received: from sonic314-21.consmr.mail.ne1.yahoo.com (sonic314-21.consmr.mail.ne1.yahoo.com [66.163.189.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BCA5314E7CAE0
	for <linux-nvdimm@lists.01.org>; Sat, 26 Sep 2020 16:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1601164255; bh=L2gqQLBGncqe+MprhY8+G5Q64NzPa7pslg2nGpaQtao=; h=Date:From:Reply-To:Subject:References:From:Subject; b=IktR/nAUPHlfvwv6JYRBBQqfLleGpVqpRi33Su5xxG74fEohuYbsP1bGGsuYtfnqNIkV4GFkDnxN/IX3azExNnmJeAMEnwwLZWcJkaKH+VZLxKpWQ+ngzpKnFcv8pDUbs1GqAVGavuDbeHbG409hkMdUnW8eaD+nMQ+No/63d506XkssC5WoYEBVP7Vdc/e/IQSq/lMbPH/4qWNcAGGxhvIJhN3E2gLaFiaawsWGRN1TksbzqI8ax++vgIMqUJ/d7Vyg1aBxa4e68CorMznFFvKxddEJUjihH/vY9BnXbKRoZpAQTUSR/wtfNPzIaTeqGLyPdAC1LSJF5dSg7RVRig==
X-YMail-OSG: Xje3GkUVM1kYiXw1tNre4rJNRGfXjsxOmwEYVKgDYFmznSeoog3BrDVnl9P6Ur2
 zrqA9vTVo2ZF3CC1BQifTD1rhkzG46c1f.Vn79.9BDhNWrICMYPenJADJGqPiyAJek2kF0r0uHHb
 yZvsrzPiIweUobO_GYdWE42mgvJYdOFNyL3Lx7SxI78LVzOI7Wr5nCCn5XoN10Qr8xzrQ4Lkfzrv
 YLSxjWZTZPG1CI3HeyhrRTspoH0ZmSdJ48vbE0yX4Sjs13csSX6Cp3dyRV0c4Vp9FZEGwARg6b7f
 5kqTGQZnAYCtF270.6ag5FOQiPjLgrZsQN9A8iDePd6uGq8cGRZObfcFx8b0HsrRMRNc7.3KC1hA
 gfoaOeN7ZrFlvIR_ewqjK72gVK3b9SRKyEgLSFOrm_ENrOIHREiGiHfhEiBOkUqTnvTSWyMnMOkm
 GVvGFi4.RcMVc4WfdVET4ITW.MULS5YUep.nZEWHQNN3Yqdeb_eGPRHuujVWTbvlxTcI5p8tQO4K
 NLMl.cAO1YDOlV41DeuwxR1hV41zALYU.5iHJE.vOH1XmeOR.STbLLMrmxUwAbmR0Qn_nM78RO_M
 13ktI8noHjJCRTJ_oNndglGTOrUKyD2zDZPt5CHgRa6ukxYJ6rBj1nYvjVIE9np3GJxd4Xo8h7LW
 Un4Pmrg51y6cIV1HhU42qohz6zUSIz5QyTZq76l3EKo7FQqOpWsoYN0ZnZiRyAvJYFGkU68pO7Nf
 GCoQceEBwjvw6H9Tb5GKw6UBh4WaPot9jgC6rB5T6e5vXw5MbNSitzTrEOkKMumgRmpPKd2WXXpb
 UF1_CtsDGICmLZ8dppy6bq8z72iRdIeU.UHa.GNjgu8LNJJ9XxipiQq_ZE450P631tu8nFfIoRfF
 8AimIMqfwFTWswV_Wb9wlCxina809g1SamJu0y03jQMojdHwfbBTmwyZkP7gD6jWu2w_izHM.514
 cZUakAcNPbZo6mlvyEvMIOWdDLh63kxAHTpQtSOybk3LXZIIiOxdqleP.DHEy8tgT6bsyWodkMik
 YV3r7bj.KDZmBB_VmU8Zra4nuIJFTkkgiCopSALCkmhWRopIk_MFiUWky5w.WBFJzcNIyoRNAhin
 RsbFZR6S3VCU_FDVyMEX_6e.4C3CfSj6oPgW4APiOIKhczi9WJQUJaxs8tL32tNR1AnIVm6SSgIN
 RZRAM3Jz_ONtlJW_gZhKDv1F7KRNLfkilcfKjqBnueyR_8OVp0y2wCIB_Z0QLYDlcrW6_r4FD0p0
 zFtUb1LadGQYcNYbWF60b84eImHDWal4549qjJS5ODY_lYc3XunEUMggxpMGBIOMfX62jHYO43cR
 c9XFLRnIxJ9n7CijaSzu0l3tdb7iJElKRVejhD0WtjNh5MHSW3MEz.hdADFQgq4.rr7ZrQilh7s3
 FRPiFId5QOlraXj.w_iw_JZDUy6tFuOtysXuWXwl2jvmKbTpeo_c-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Sat, 26 Sep 2020 23:50:55 +0000
Date: Sat, 26 Sep 2020 23:50:54 +0000 (UTC)
From: anitadominic50@yahoo.com
Message-ID: <1600741060.1184971.1601164254120@mail.yahoo.com>
Subject: hi
MIME-Version: 1.0
References: <1600741060.1184971.1601164254120.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16674 YMailNodin Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.0.1611 Safari/537.36
Message-ID-Hash: 7F2ZH422UDIN6RTND7SFM3SBGKUVL5CS
X-Message-ID-Hash: 7F2ZH422UDIN6RTND7SFM3SBGKUVL5CS
X-MailFrom: anitadominic50@yahoo.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: augstinemichelle00@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7F2ZH422UDIN6RTND7SFM3SBGKUVL5CS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit




Hello, Can we be friends? If you don't mind
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
