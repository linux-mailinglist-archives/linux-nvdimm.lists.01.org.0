Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E132257FA7
	for <lists+linux-nvdimm@lfdr.de>; Mon, 31 Aug 2020 19:34:17 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 478F112604A5D;
	Mon, 31 Aug 2020 10:34:15 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=66.163.190.146; helo=sonic315-20.consmr.mail.ne1.yahoo.com; envelope-from=abenpamads@yahoo.com; receiver=<UNKNOWN> 
Received: from sonic315-20.consmr.mail.ne1.yahoo.com (sonic315-20.consmr.mail.ne1.yahoo.com [66.163.190.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id AEB1012604A5B
	for <linux-nvdimm@lists.01.org>; Mon, 31 Aug 2020 10:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1598895251; bh=/wWE/srJrz9OuGq81agug6j8cDZKLJjOEAHUvES6oeE=; h=Date:From:Reply-To:Subject:References:From:Subject; b=sbZ6AzqbF7Jf1H4l+ZzBEY046IzzF3v2sVyKvK4VV3imNkYC7rWjMUaIwijAQSOYIWFDhHEM07+cFMT4sopja6C/tNUIvD8UC8GGDHozQuua4ka3eLhpoPdwvapvhljKKjJu8e1EMebFcym73+fl+pplhwiBYbh/Tc4GGsknvcyasxpN+bC/SO1Ci+wkWODivTptBePyKRllfbL+3sZ9Zl/0Vvges9BeJdejOEFpjS3yudPcqTq1+ADsC1xvGSUbHYltS6Drf7+p3GCSyJcOUbI7h7+4Tku0XY8UfvXVe0dZDAGsXKZ+MYIxdB03V6lttc+VHyj6NIbJdAWFZnWyGw==
X-YMail-OSG: bMP7QA0VM1n6sfLr480FyoJ8OnRfqv7.D_JaARBeVm.s4iQVAmRC38.xiBTyusm
 FfNdinDdhnGI4RSojJoMwbPY4KqJ5ViEslGBkXxq3LaQDbsLoqbkE_XZkIxMe3tITcg6wGy469T_
 WfBLfObBFzPh8kXOYuoa1RQffkXTsPurL5Wegx6TsQCvWjweDrWfLNtn91i.AysT19y06NdBnRrW
 7X5jFuuz5ee4qVET_VewSMa8qo1XUWsXmOLd2xS2c2a97KeMMQ0Se7Tz9xswReXP6rIlzdIa3z6m
 0nfRJmSLGR.0Pd.2n.0fcVp.3mZFT92w17duIN11p.Eucb2941pm08JsG.nxbZoLYDRc9Lxq1xcO
 570jpYwYS.h6rfrPfTSiwoLFtKOhc3SlMjZ8B8.iiT02lW488f9SqhX6oeUR2iYqVB9jZHL8BgF8
 b9H.aQv8TD8IAJSKfcig6iH7uSfg.8ArQe8SumK2yqi5qvw7n6KbergopmiyampeiEf.IF9Had3_
 3DUhvEMzD15CrNeBzMmzBhmyr8_1I2RchvcdOkduQV77oTh4Pwi8ZA.0CxZu.hJ0RxWZj6Mj6PaR
 xwYh5vzVjS.matXx_M7nQ7aein8DaNznxlxu3PFhW1KbRcbBAC_b8JziooBktxDyRbaULkSaGPRq
 66cv5N2Y7P0iKaQcC22mfzHOinN5xXUYJfQipyu9BcMUxc_2dzt1VPdvHZr5meJkSvYFbu86nO7b
 qwU9UJFv3QsSF0ojtdbz0H3.pP7vXQCKedSXaGodjAlrZpxbb_lkjFqh53JspswhHnBC38cB5wBt
 jasDAvYplhreojnByKfmZSquJoKSGYN5b6TjEq8aPu.lHlGlgjA7OZQRQv_YLmT1iq9b4bJ8I52i
 aEgFYzvDoppbyJiihk9GQ.mKPNvjEUPjnMdqdYG2vMnaspNRoCUyj2V1DYW6dikq9oHh1rqhbNM1
 IOkuQFPw11YFHYOfGv2E6FX2MOXTej8FS.9NNHbrbHgicqIA0ueDQ359rAExXUc6GNYJum7AxyMO
 f6wXA1XoMgpcIy7GW_4kcING45pGko7trNeklFGpoIglfJilEJwGmtULOzS7hUAr4mo3mIEt_KyU
 JE4UuBKzowxFtr8O04ZTGpEyiMfJA7roXvlyJuRmUUx1huzHJ2wLVaZnxEWOvZmni6hxL7MnfaG_
 nIrfankcenLTHzM_RnznL6gh7ztZOvqKiC3a7dkouAuFY..7VFNIOg0Y7MQ1mspw_vFfsEq9zyVA
 wKZjpNeYvuyQl6AzH8xpF7HDF0jcSHLaD5Pr7af5EIeCzvn_qBkP009Wy8RpviR951TqlRhM08hu
 Zz7G6R6rZWVksyjOLz_PyI4GBxnHuJTDjzKCYw_DdgAd2RHW7bGK.pcpvLggf3JFa_WzW0FqlhzV
 e5IPMtUGiJwq1Avv3.5O_LFHpIIEoPkzfX9xd7RguFw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Mon, 31 Aug 2020 17:34:11 +0000
Date: Mon, 31 Aug 2020 17:34:07 +0000 (UTC)
From: "Mrs. Johanna maaly bob" <abenpamads@yahoo.com>
Message-ID: <2133829573.965029.1598895247634@mail.yahoo.com>
Subject: Dear God's Chosen,
MIME-Version: 1.0
References: <2133829573.965029.1598895247634.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16565 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:80.0) Gecko/20100101 Firefox/80.0
Message-ID-Hash: RTAKT6C6ZBGPOFQAHSCFQZVHJZBMK6NG
X-Message-ID-Hash: RTAKT6C6ZBGPOFQAHSCFQZVHJZBMK6NG
X-MailFrom: abenpamads@yahoo.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: maalybobm@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RTAKT6C6ZBGPOFQAHSCFQZVHJZBMK6NG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


Good Day Dearest,

I am Mrs. johanna maaly bob from Australia. It is understandable that you may be a bit apprehensive because you do not know me; I found your email address from a Human resources data base and decided to contact you. I would love to employ you into my charity work; I am ready to donate some money to you to carry on the Charity work in your country. Please reply so that I will give you further details and tell you about myself via email: maalybobm@gmail.com

Thanks and God bless you,
Mrs. Johanna maaly bob,
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
